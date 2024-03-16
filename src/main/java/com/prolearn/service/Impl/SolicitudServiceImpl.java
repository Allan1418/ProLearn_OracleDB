package com.prolearn.service.Impl;

import com.prolearn.domain.Solicitud;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.prolearn.dao.SolicitudDao;
import com.prolearn.service.SolicitudService;

@Service
public class SolicitudServiceImpl implements SolicitudService {

    //La anotacion autowired crea un unico objeto mientras se ejecuta la app
    @Autowired
    private SolicitudDao solicitudDao;

    @Override
    @Transactional(readOnly = true)
    public List<Solicitud> getSolicitudes() {
        var lista = solicitudDao.findAll();
        return lista;
    }

    @Override
    @Transactional(readOnly = true)
    public Solicitud getSolicitud(Solicitud solicitud) {
        return solicitudDao.findById(solicitud.getIdSolicitud()).orElse(null);
    }

    @Override
    @Transactional
    public void save(Solicitud solicitud) {
        solicitudDao.save(solicitud);
    }

    @Override
    @Transactional
    public void delete(Solicitud solicitud) {
        solicitudDao.delete(solicitud);
    }
}
