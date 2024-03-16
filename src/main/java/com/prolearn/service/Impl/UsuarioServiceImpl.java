package com.prolearn.service.Impl;

import com.prolearn.domain.Usuario;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prolearn.dao.UsuarioDao;
import com.prolearn.service.UsuarioService;

@Service
public class UsuarioServiceImpl implements UsuarioService {

    //La anotacion autowired crea un unico objeto mientras se ejecuta la app
    @Autowired
    private UsuarioDao usuarioDao;

    @Override
    @Transactional(readOnly = true)
    public List<Usuario> getUsuarios() {
        var lista = usuarioDao.findAll();
        return lista;
    }

    @Override
    @Transactional(readOnly = true)
    public Usuario getUsuario(Usuario usuario) {
        return usuarioDao.findById(usuario.getIdUsuario()).orElse(null);
    }

    @Override
    @Transactional
    public void save(Usuario usuario) {
        usuarioDao.save(usuario);
    }

    @Override
    @Transactional
    public void delete(Usuario usuario) {
        usuarioDao.delete(usuario);
    }
}
