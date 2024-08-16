
package com.prolearn.service;

import com.prolearn.domain.CapituloHijo;
import com.prolearn.domain.CapituloPadre;
import com.prolearn.domain.Curso;
import java.util.List;


public interface CapituloPadreService {
    
    public CapituloPadre getCapituloPadre(CapituloPadre capituloPadre);
    
    public List<CapituloHijo> getCapitulosHijos(CapituloPadre capituloPadre);
    
    public void save(CapituloPadre capituloPadre, Curso curso);
    
    public void delete(CapituloPadre capituloPadre);
    
}
