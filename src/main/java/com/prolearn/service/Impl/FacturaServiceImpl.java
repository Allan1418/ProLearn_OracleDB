
package com.prolearn.service.impl;

import com.prolearn.dao.FacturaDao;
import com.prolearn.domain.Factura;
import com.prolearn.service.FacturaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FacturaServiceImpl implements FacturaService {

    @Autowired
    private FacturaDao facturaDao;

    @Override
    public void save(Factura factura) {
        facturaDao.save(factura);
    }

    @Override
    public List<Factura> getFacturas() {
        return facturaDao.findAll();
    }

    @Override
    public Factura getFacturaById(Long id) {
        return facturaDao.findById(id).orElse(null);
    }

    @Override
    public void delete(Factura factura) {
        facturaDao.delete(factura);
    }
}

