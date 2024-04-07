package com.prolearn.service.Impl;

import com.prolearn.dao.UsuarioDao;
import com.prolearn.domain.Rol;
import com.prolearn.domain.Usuario;
import com.prolearn.service.UsuarioDetailsService;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("userDetailsService")

public class UsuarioDetailsServiceImpl implements UsuarioDetailsService, UserDetailsService{
    
   @Autowired
    private UsuarioDao usuarioDao;
    
    @Autowired
    private HttpSession session;
    
    @Override
    @Transactional(readOnly = true)
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        
        //Se busca el usuario que pasamos por parametro en bd
        Usuario usuario = usuarioDao.findByUsername(username);
        
        //se valida si se encontro un usuario de la bd, si no lanza error
        if (usuario == null) {
            throw new UsernameNotFoundException(username);
        }
        
        //se recupero la info del usuario y se agrega la img del usuario
        session.removeAttribute("usuarioImagen");
        session.removeAttribute("nombreCompleto");
        session.setAttribute("nombreCompleto", usuario.getNombre() + " " + usuario.getApellidos());
        
        //se van a recuperar los roles del user y se crean los roles en sec de spring
        var roles = new ArrayList<GrantedAuthority>();
        for (Rol rol : usuario.getRoles()) {
            roles.add(new SimpleGrantedAuthority(rol.getNombre()));
        }
        
        
        return new User(usuario.getUsername(), usuario.getPassword(), roles);
    }
    
}
