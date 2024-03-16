
package com.prolearn.controller;

import com.prolearn.domain.Crear;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.prolearn.service.CrearService;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@Slf4j
@RequestMapping("/cuenta")
public class CrearController {
    
    @Autowired
    private CrearService crearService;
    
    @GetMapping("/crear")
    public String inicio(Model model){
        
        var creados = crearService.getCreados();
        model.addAttribute("creados", creados);
        model.addAttribute("totalCreados",creados.size());
        
        return "/cuenta/crear";
    }
    
//    @GetMapping("/nuevo")
//    public String crearNuevo(Crear crear) {
//        return "/crear/menu";
//    }
//
//    @PostMapping("/guardar")
//    public String crearGuardar(Crear crear) {
//        crearService.save(crear);
//        return "redirect:/crear/menu";
//    }
//
    @GetMapping("/eliminar/{idCrear}")
    public String crearEliminar(Crear crear) {
        crearService.delete(crear);
        return "redirect:/cuenta/crear";
    }
//
//    @GetMapping("/modificar/{idNewCuenta}")
//    public String crearModificar(Crear crear, Model model) {
//        crear = crearService.getCrear(crear);
//        model.addAttribute("crear", crear);
//        return "/crear/menu";
//    }

}
