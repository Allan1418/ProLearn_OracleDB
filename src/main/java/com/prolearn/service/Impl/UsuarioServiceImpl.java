
package com.prolearn.service.Impl;

import com.prolearn.dao.UsuarioDao;
import com.prolearn.domain.Usuario;
import com.prolearn.service.UsuarioService;
//import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UsuarioServiceImpl implements UsuarioService{
    
    @Autowired
    private UsuarioDao usuarioDao;

    @Override
    @Transactional(readOnly = true)
    public Usuario getUsuario(Usuario usuario) {
        return usuarioDao.findById(usuario.getIdUsuario()).orElse(null);
    }

    @Override
    public void save(Usuario usuario) {
        usuarioDao.save(usuario);
    }

    @Override
    public void delete(Usuario usuario) {
        usuarioDao.delete(usuario);
    }

    @Override
    public Usuario findByCorreoAndContra(String correoUsuario, String contraUsuario) {
        return usuarioDao.findByCorreoAndContra(correoUsuario, contraUsuario);
    }
    
    
    
    
}
