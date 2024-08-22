package com.prolearn.service;

import com.prolearn.domain.Monto;
import java.util.List;

public interface MontoService {
    public Monto getMonto(Monto monto);
    
    public List<Monto> getMontosPublico();
    
    public List<Monto> getMontosAdmin();
    
    public void save(Monto monto);
    
    public void delete(Monto monto);
}