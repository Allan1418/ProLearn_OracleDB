
package com.prolearn.service.Impl;

import com.prolearn.dao.UsuarioDao;
import com.prolearn.domain.Rol;
import com.prolearn.domain.Usuario;
import com.prolearn.service.UsuarioService;
import java.util.Arrays;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UsuarioServiceImpl implements UsuarioService{

    
    @Autowired
    private UsuarioDao usuarioDao;
    
    //@Autowired
    //private RolDao rolDao;
    
    @Override
    public void save(Usuario usuario) {
        usuario.setRoles(Arrays.asList(new Rol("ROLE_USER")));
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
        return usuarioDao.findById(usuario.getId()).orElse(null);
    }

    @Override
    @Transactional
    public void delete(Usuario usuario) {
        usuarioDao.delete(usuario);
    }

    
    
}
