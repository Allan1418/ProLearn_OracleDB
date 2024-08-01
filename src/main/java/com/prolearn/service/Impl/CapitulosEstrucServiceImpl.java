
package com.prolearn.service.Impl;

import com.prolearn.dao.CapituloHijoDao;
import com.prolearn.dao.CapituloPadreDao;
import com.prolearn.domain.CapituloHijo;
import com.prolearn.domain.CapituloPadre;
import com.prolearn.service.CapitulosEstrucService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CapitulosEstrucServiceImpl implements CapitulosEstrucService {
    
    @Autowired
    private CapituloHijoDao capituloHijoDao;
    @Autowired
    private CapituloPadreDao capituloPadreDao;

    @Override
    @Transactional(readOnly = true)
    public List<CapituloPadre> getPadres(Long idCurso) {
        
        List<CapituloPadre> listaPadres = capituloPadreDao.findAllXCursoID(idCurso);
        
        return listaPadres;
    }

    @Override
    @Transactional(readOnly = true)
    public List<CapituloHijo> getHijos(Long idCurso, Long idCapituloPadre) {
        
        List<CapituloHijo> listaHijos = capituloHijoDao.findAllByCapituloPadreIdYCursoId(idCapituloPadre, idCurso);
        
        return listaHijos;
    }
    
}
