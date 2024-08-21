package com.prolearn.service.Impl;

import com.prolearn.dao.RolDao;
import com.prolearn.dao.UsuarioDao;
import com.prolearn.domain.Rol;
import com.prolearn.domain.Usuario;
import com.prolearn.service.UsuarioService;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    @Autowired
    private UsuarioDao usuarioDao;

    @Autowired
    private RolDao rolDao;
    
    @Override
    @Transactional
    public void nuevo(Usuario usuario) throws UserAlreadyExistAuthenticationException{
        
        usuario.setId(0L);
        
        Rol rol = rolDao.findByNombre("ROLE_USER");
        
        usuario.setIdRol(rol.getIdRol());
        
        var codigo = new BCryptPasswordEncoder();
        usuario.setPassword(codigo.encode(usuario.getPassword()));
        
        Long idNuevo = usuarioDao.upsert(usuario.getId(),
                usuario.getNombre(),
                usuario.getApellidos(),
                usuario.getEmail(),
                usuario.getPassword(),
                usuario.getIdRol());
        
        if (idNuevo == -1L) {
            throw new UserAlreadyExistAuthenticationException("El correo ya existe!");
        }
    }
    
    @Override
    @Transactional
    public void save(Usuario usuario) {
        
        usuarioDao.upsert(usuario.getId(),
                usuario.getNombre(),
                usuario.getApellidos(),
                usuario.getEmail(),
                usuario.getPassword(),
                usuario.getIdRol());
    }

    @Override
    @Transactional(readOnly = true)
    public List<Usuario> getUsuarios() {
        return usuarioDao.getAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Usuario getUsuario(Usuario usuario) {
        usuario = usuarioDao.getXId(usuario.getId()).orElse(null);
        
        
        usuario.setRol(rolDao.getXId(usuario.getIdRol()));
        
        return usuario;
    }

    @Override
    @Transactional
    public void delete(Usuario usuario) {
        
        //dao
        usuarioDao.delete(usuario);
    }

    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Usuario usuario = usuarioDao.findByEmail(username).orElse(null);
        
        if (usuario == null) {
            throw new UsernameNotFoundException("Usuario o password inválidos");
        }
        
        usuario.setRol(rolDao.getXId(usuario.getIdRol()));
        
        return new User(usuario.getEmail(), usuario.getPassword(), mapearAutoridadesRoles(usuario.getRol()));
    }

    private Collection<? extends GrantedAuthority> mapearAutoridadesRoles(Rol rol) {
    return Collections.singletonList(new SimpleGrantedAuthority(rol.getNombre())); 
}

}
