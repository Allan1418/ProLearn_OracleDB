
package com.prolearn.controller;

import com.prolearn.domain.CapituloHijo;
import com.prolearn.service.CapituloHijoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/visualVideos")
public class VideoController {
    
    @Autowired
    private CapituloHijoService capituloHijoService;
    
    @GetMapping("/visualVideos/{id}")
    public String mostrarVideo(@PathVariable Long id, Model model) {
        
        CapituloHijo capituloHijo = capituloHijoService.getCapituloHijo(id);
        
//        if (capituloHijo != null) {
//            System.out.println("ID: " + capituloHijo.getId());
//            System.out.println("Nombre: " + capituloHijo.getNombre());
//            System.out.println("Video: " + capituloHijo.getVideo());
//            System.out.println("Número: " + capituloHijo.getNumero());
//            System.out.println("Capítulo padre: " + capituloHijo.getCapituloPadre().getNombre());
//        } else{
//            System.out.println("nuloooooooooooooooooooo");
//        }
        
        
        
        model.addAttribute("capituloHijo", capituloHijo);
        return "visualVideos/visualVideos";
    }
    
}
