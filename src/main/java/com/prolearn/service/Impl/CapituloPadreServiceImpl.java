
package com.prolearn.service.Impl;

import com.prolearn.dao.CapituloHijoDao;
import com.prolearn.dao.CapituloPadreDao;
import com.prolearn.domain.*;
import com.prolearn.service.CapituloPadreService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CapituloPadreServiceImpl implements CapituloPadreService{

    @Autowired
    private CapituloPadreDao capituloPadreDao;
    
    @Autowired
    private CapituloHijoDao capituloHijoDao;
    
    @Override
    @Transactional(readOnly = true)
    public CapituloPadre getCapituloPadre(CapituloPadre capituloPadre) {
        capituloPadre = capituloPadreDao.findXId(capituloPadre.getId()).orElse(null);
//        if (capituloPadre != null) {
//            System.out.println("ID: " + capituloPadre.getId());
//            System.out.println("Nombre: " + capituloPadre.getNombre());
//            System.out.println("Número: " + capituloPadre.getNumero());
//        } else{
//            System.out.println("nuloooooooooooooooooooo");
//        }
        return capituloPadre;
    }

    @Override
    public void save(CapituloPadre capituloPadre, Curso curso) {
        capituloPadreDao.upsert(capituloPadre.getId(), capituloPadre.getNombre(), capituloPadre.getNumero(), curso.getIdCurso());
    }

    @Override
    public List<CapituloHijo> getCapitulosHijos(CapituloPadre capituloPadre) {
        return capituloHijoDao.findAllByCapituloPadreId(capituloPadre.getId());
    }

    @Override
    public void delete(CapituloPadre capituloPadre) {
        capituloPadreDao.delete(capituloPadre.getId());
    }
    
}
