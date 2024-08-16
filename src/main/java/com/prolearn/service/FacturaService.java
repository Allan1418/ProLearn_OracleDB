package com.prolearn.service;

import com.prolearn.domain.Factura;
import java.util.List;

public interface FacturaService {
    void save(Factura factura);
    List<Factura> getFacturas();
    Factura getFacturaById(Long id);
    void delete(Factura factura);
}

