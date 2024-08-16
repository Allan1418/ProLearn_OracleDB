package com.prolearn.service.impl;

import com.prolearn.dao.MontoDao;
import com.prolearn.domain.Monto;
import com.prolearn.service.MontoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class MontoServiceImpl implements MontoService {

    @Autowired
    private MontoDao montoDao;

    @Override
    public void save(Monto monto) {
        montoDao.save(monto);
    }

    @Override
    public List<Monto> getMontos() {
        return montoDao.findAll();
    }

    @Override
    public Monto getMontoById(Long id) {
        return montoDao.findById(id).orElse(null);
    }

    @Override
    public void delete(Monto monto) {
        montoDao.delete(monto);
    }
}