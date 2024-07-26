
package com.prolearn.service;

import com.prolearn.domain.*;
import java.util.List;


public interface CapitulosEstrucService {
    
    public List<CapituloPadre> getPadres(Long idCurso);
    
    public List<CapituloHijo> getHijos(Long idCurso, Long idCapituloPadre);
    
}
