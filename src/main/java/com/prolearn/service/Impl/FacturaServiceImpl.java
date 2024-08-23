
package com.prolearn.service.impl;

import com.prolearn.dao.FacturaDao;
import com.prolearn.domain.Factura;
import com.prolearn.domain.Monto;
import com.prolearn.domain.Usuario;
import com.prolearn.service.FacturaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;

@Service
public class FacturaServiceImpl implements FacturaService {

    @Autowired
    private FacturaDao facturaDao;

    @Override
    @Transactional(readOnly = true)
    public Factura getFactura(Factura factura) {
        return facturaDao.findXId(factura.getIdFactura()).orElse(null);
    }

    @Override
    @Transactional()
    public List<Factura> getFacturasByUserId(Usuario user) {
        
        return facturaDao.findAllXUser(user.getId());
    }

    @Override
    @Transactional(readOnly = true)
    public List<Factura> getAll() {
        return facturaDao.findAll();
    }

    @Override
    @Transactional()
    public void crear(Monto monto, Usuario user) {
        
        facturaDao.crear(monto.getIdMonto(), user.getId());
    }
    
    @Override
    @Transactional()
    public void delete(Factura factura) {
        facturaDao.delete(factura.getIdFactura());
    }

}
