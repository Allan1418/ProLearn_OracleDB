
package com.prolearn.service.impl;

import com.prolearn.dao.FacturaDao;
import com.prolearn.domain.Factura;
import com.prolearn.domain.Usuario;
import com.prolearn.service.FacturaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FacturaServiceImpl implements FacturaService {

    @Autowired
    private FacturaDao facturaDao;

    @Override
    public Factura getFactura(Factura factura) {
        return facturaDao.findXId(factura.getIdFactura()).orElse(null);
    }

    @Override
    public List<Factura> getFacturasByUserId(Usuario user) {
        
        //falta sp del backend
        
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void save(Factura factura) {
        
        facturaDao.upsert(factura.getIdFactura(), factura.getIdMonto(), factura.getIdUser());
        
    }

    @Override
    public void delete(Factura factura) {
        facturaDao.delete(factura.getIdFactura());
    }



}
