package com.prolearn.service;

import com.prolearn.domain.Monto;
import java.util.List;

public interface MontoService {
    void save(Monto monto);
    List<Monto> getMontos();
    Monto getMontoById(Long id);
    void delete(Monto monto);
}