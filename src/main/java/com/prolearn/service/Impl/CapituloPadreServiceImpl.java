
package com.prolearn.service.Impl;

import com.prolearn.dao.CapituloPadreDao;
import com.prolearn.domain.CapituloPadre;
import com.prolearn.service.CapituloPadreService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CapituloPadreServiceImpl implements CapituloPadreService{

    @Autowired
    private CapituloPadreDao capituloPadreDao;
    
    @Override
    @Transactional(readOnly = true)
    public CapituloPadre getCapituloPadre(CapituloPadre capituloPadre) {
        capituloPadre = capituloPadreDao.findById(capituloPadre.getId()).orElse(null);
//        if (capituloPadre != null) {
//            System.out.println("ID: " + capituloPadre.getId());
//            System.out.println("Nombre: " + capituloPadre.getNombre());
//            System.out.println("Número: " + capituloPadre.getNumero());
//        } else{
//            System.out.println("nuloooooooooooooooooooo");
//        }
        return capituloPadre;
    }
    
}
