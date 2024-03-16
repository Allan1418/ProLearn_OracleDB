package com.prolearn.service.Impl;

import com.prolearn.domain.Crear;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prolearn.dao.CrearDao;
import com.prolearn.service.CrearService;

@Service
public class CrearServiceImpl implements CrearService {

    //La anotacion autowired crea un unico objeto mientras se ejecuta la app
    @Autowired
    private CrearDao crearDao;

    @Override
    @Transactional(readOnly = true)
    public List<Crear> getCreados() {
        var lista = crearDao.findAll();
        return lista;
    }

    @Override
    @Transactional(readOnly = true)
    public Crear getCrear(Crear crear) {
        return crearDao.findById(crear.getIdCrear()).orElse(null);
    }

    @Override
    @Transactional
    public void save(Crear crear) {
        crearDao.save(crear);
    }

    @Override
    @Transactional
    public void delete(Crear crear) {
        crearDao.delete(crear);
    }
}
