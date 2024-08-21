package com.prolearn.service;

import com.prolearn.domain.Factura;
import com.prolearn.domain.Usuario;
import java.util.List;

public interface FacturaService {
    
    public Factura getFactura(Factura factura);
    
    public List<Factura> getFacturasByUserId(Usuario user);
    
    public void save(Factura factura);
    
    public void delete(Factura factura);
}

