
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
        model.addAttribute("capituloHijo", capituloHijo);
        return "visualVideos/visualVideos";
    }
    
}
