
package com.prolearn.controller;

import com.prolearn.domain.Solicitud;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.prolearn.service.SolicitudService;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@Slf4j
@RequestMapping("/cuenta")
public class SolicitudController {
    
    @Autowired
    private SolicitudService solicitudService;
    
    @GetMapping("/recuperar")
    public String inicio(Model model){
        
        var solicitudes = solicitudService.getSolicitudes();
        model.addAttribute("solicitudes", solicitudes);
        model.addAttribute("totalSolicitudes",solicitudes.size());
        
        return "/cuenta/recuperar";
    }
    
//    @GetMapping("/nuevo")
//    public String solicitudNuevo(Solicitud solicitud) {
//        return "/solicitud/menu";
//    }
//
//    @PostMapping("/guardar")
//    public String solicitudGuardar(Solicitud solicitud) {
//        solicitudService.save(solicitud);
//        return "redirect:/solicitud/menu";
//    }
//
    @GetMapping("/eliminar/{idSolicitud}")
    public String solicitudEliminar(Solicitud solicitud) {
        solicitudService.delete(solicitud);
        return "redirect:/solicitud/crear";
    }
//
//    @GetMapping("/modificar/{idSolicitud}")
//    public String solicitudModificar(Solicitud solicitud, Model model) {
//        solicitud = solicitudService.getSolicitud(solicitud);
//        model.addAttribute("solicitud", solicitud);
//        return "/solicitud/menu";
//    }

}
