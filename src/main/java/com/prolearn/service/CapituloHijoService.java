
package com.prolearn.service;

import com.prolearn.domain.CapituloHijo;
import com.prolearn.domain.Curso;


public interface CapituloHijoService {
    
    public CapituloHijo getCapituloHijo(CapituloHijo capituloHijo);
    
    public void save(CapituloHijo capituloHijo, Curso curso);
    
    public void delete(CapituloHijo capituloHijo);
    
}
