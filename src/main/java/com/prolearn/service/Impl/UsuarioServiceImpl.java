package com.prolearn.service.Impl;

import com.prolearn.dao.RolDao;
import com.prolearn.dao.UsuarioDao;
import com.prolearn.domain.Rol;
import com.prolearn.domain.Usuario;
import com.prolearn.service.UsuarioService;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
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
    public void save(Usuario usuario) {
        
        Rol rolUsuario = rolDao.findByNombre("ROLE_USER");
        
        usuario.setRoles(Arrays.asList(rolUsuario));
        
        var codigo = new BCryptPasswordEncoder();
        usuario.setPassword(codigo.encode(usuario.getPassword()));
        
        usuarioDao.save(usuario);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Usuario> getUsuarios() {
        return usuarioDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Usuario getUsuario(Usuario usuario) {
        usuario = usuarioDao.findById(usuario.getId()).orElse(null);
        usuario.setRoles(rolDao.findAllByIdUser(usuario.getId()));
        
        return usuario;
    }

    @Override
    @Transactional
    public void delete(Usuario usuario) {
        usuarioDao.delete(usuario);
    }

    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Usuario usuario = usuarioDao.findByEmail(username);
        
        if (usuario == null) {
            throw new UsernameNotFoundException("Usuario o password inválidos");
        }
        
        usuario.setRoles(rolDao.findAllByIdUser(usuario.getId()));
        
        return new User(usuario.getEmail(), usuario.getPassword(), mapearAutoridadesRoles(usuario.getRoles()));
    }

    private Collection<? extends GrantedAuthority> mapearAutoridadesRoles(Collection<Rol> roles) {
        return roles.stream().map(role -> new SimpleGrantedAuthority(role.getNombre())).collect(Collectors.toList());
    }

}
