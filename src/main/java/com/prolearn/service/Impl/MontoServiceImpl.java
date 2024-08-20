package com.prolearn.service.impl;

import com.prolearn.dao.MontoDao;
import com.prolearn.domain.Monto;
import com.prolearn.service.MontoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MontoServiceImpl implements MontoService {

    @Autowired
    private MontoDao montoDao;

    @Override
    @Transactional(readOnly = true)
    public Monto getMonto(Monto monto) {
        monto = montoDao.findById(monto.getId()).orElse(null);
        return monto;
    }

    @Override
    public void save(Monto monto) {
        montoDao.upsert(monto.getId(), monto.getTipoSuscripcion());
    }

    @Override
    public List<Monto> getMontosByTipoSuscripcion(String tipoSuscripcion) {
        return montoDao.findAllByTipoSuscripcion(tipoSuscripcion);
    }

    @Override
    public void delete(Monto monto) {
        montoDao.delete(monto.getId());
    }
}