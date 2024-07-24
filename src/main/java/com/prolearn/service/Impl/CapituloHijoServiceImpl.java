
package com.prolearn.service.Impl;

import com.prolearn.dao.*;
import com.prolearn.domain.CapituloHijo;
import com.prolearn.service.CapituloHijoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CapituloHijoServiceImpl implements CapituloHijoService{

    @Autowired
    private CapituloHijoDao capituloHijoDao;
    @Autowired
    private CategoriaDao categoriaDao;
    
    @Override
    @Transactional(readOnly = true)
    public CapituloHijo getCapituloHijo(CapituloHijo capituloHijo) {
        capituloHijo = capituloHijoDao.findById(capituloHijo.getId()).orElse(null);
        
        //ejemplo de impl de SP con categora
        System.out.println(categoriaDao.findByid(1L).getNombre());
        
//        if (capituloHijo != null) {
//            System.out.println("ID: " + capituloHijo.getId());
//            System.out.println("Nombre: " + capituloHijo.getNombre());
//            System.out.println("Video: " + capituloHijo.getVideo());
//            System.out.println("Número: " + capituloHijo.getNumero());
//            System.out.println("Capítulo padre: " + capituloHijo.getCapituloPadre().getNombre());
//        } else{
//            System.out.println("nuloooooooooooooooooooo");
//        }
        return capituloHijo;
    }

    @Override
    public void save(CapituloHijo capituloHijo) {
        capituloHijoDao.save(capituloHijo);
    }

    @Override
    public void delete(CapituloHijo capituloHijo) {
        capituloHijoDao.delete(capituloHijo);
    }
    
}
