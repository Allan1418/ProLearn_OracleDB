
package com.prolearn.controller;

import com.prolearn.domain.Monto;
import com.prolearn.domain.Usuario;
import com.prolearn.service.FacturaService;
import com.prolearn.service.MontoService;
import com.prolearn.service.UsuarioService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.CurrentSecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/metodoPago/")
public class MetodoPagoController {

    @Autowired
    private MontoService montoService;

    @Autowired
    private FacturaService facturaService;
    
    @Autowired
    private UsuarioService usuarioService;

    

    @GetMapping("/planesCurso")
    public String mostrarMontos(Model model) {

        List<Monto> montos = montoService.getMontosPublico();
        model.addAttribute("montos", montos);

        return "/metodoPago/planesCurso";
    }

    @PostMapping("/listarPlanes/{idMonto}")
    public String crearFactura(Model model, Monto monto, @CurrentSecurityContext(expression = "authentication?.name") String username) {

        monto = montoService.getMonto(monto);
        
        Usuario usuario = usuarioService.getUsuarioByEmail(username);
        if (usuario == null) {
            model.addAttribute("error", "algo salio mal procesando el pago!");
            return "redirect:/metodoPago/planesCurso";
        }
        
        if (usuario.getRol().getNombre().equals("ROLE_PREMIUM")) {
            model.addAttribute("error", "Ya eres usuario premium!");
            return "redirect:/metodoPago/planesCurso";
        }
        
        if (usuario.getRol().getNombre().equals("ROLE_ADMIN")) {
            model.addAttribute("error", "Eres administrador, ya tienes acceso a todo!");
            return "redirect:/metodoPago/planesCurso";
        }

        System.out.println("------------------------------"+ monto.getIdMonto());
        System.out.println("------------------------------"+ usuario.getId());
        facturaService.crear(monto, usuario);

        return "redirect:/index";
    }

}
