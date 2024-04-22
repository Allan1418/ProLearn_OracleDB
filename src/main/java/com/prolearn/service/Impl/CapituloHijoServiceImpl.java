
package com.prolearn.service.Impl;

import com.prolearn.dao.CapituloHijoDao;
import com.prolearn.domain.CapituloHijo;
import com.prolearn.service.CapituloHijoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CapituloHijoServiceImpl implements CapituloHijoService{

    @Autowired
    private CapituloHijoDao capituloHijoDao;
    
    @Override
    @Transactional(readOnly = true)
    public CapituloHijo getCapituloHijo(Long id) {
        CapituloHijo capituloHijo = capituloHijoDao.findById(id).orElse(null);
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
    
}
