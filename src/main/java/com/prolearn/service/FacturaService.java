package com.prolearn.service;

import com.prolearn.domain.Factura;
import java.util.List;

public interface FacturaService {
    
    public Factura getFactura(Factura factura);
    
    public List<Factura> getFacturasByUsuarioId(Long usuarioId);
    
    public void save(Factura factura);
    
    public void delete(Factura factura);
}

