package com.prolearn.controller;


import com.prolearn.domain.*;
import com.prolearn.service.*;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.CurrentSecurityContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/vistaPerfilUser")
public class VistaPerfilController {

    @Autowired
    private CursoService cursoService;
    
    @Autowired
    private UsuarioService usuarioService;
    
    @Autowired
    private FacturaService facturaService;
  
    @GetMapping("/info")
    public String mostrar(Model model, @CurrentSecurityContext(expression = "authentication?.name") String username) {
        
        Usuario usuario = usuarioService.getUsuarioByEmail(username);
        if (usuario == null) {
            return "redirect:/index";
        }
        
        model.addAttribute("usuario", usuario);

        List<Curso> cursos = cursoService.getCursosByUser(usuario);
        model.addAttribute("cursos", cursos);
        
        List<Factura> facturas = facturaService.getFacturasByUserId(usuario);
        model.addAttribute("facturas", facturas);
        
        
        return "/vistaPerfilUser/info";
    }

    

}
