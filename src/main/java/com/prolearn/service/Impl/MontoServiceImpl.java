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
        monto = montoDao.findById(monto.getIdMonto()).orElse(null);
        return monto;
    }

    @Override
    @Transactional()
    public void save(Monto monto) {
        
        montoDao.upsert(monto.getIdMonto(), 
                monto.getNombre(), 
                monto.getDescuento(), 
                monto.getMontoSinDescuento(), 
                monto.isEstado());
    }

    @Override
    @Transactional()
    public void delete(Monto monto) {
        montoDao.delete(monto.getIdMonto());
    }

    @Override
    @Transactional(readOnly = true)
    public List<Monto> getMontosPublico() {
        return montoDao.findAllPublico();
    }

    @Override
    @Transactional(readOnly = true)
    public List<Monto> getMontosAdmin() {
        return montoDao.findAllAdmin();
    }
}