
package com.prolearn.controller;

import com.prolearn.domain.Usuario;
import com.prolearn.service.CursoService;
import com.prolearn.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/")
public class indexController {
    
    @Autowired
    private CursoService cursoService;
    
    @Autowired
    private UsuarioService usuarioService;
    
    
    @GetMapping("/")
    public String getCursos(Model model) {
        var cursos = cursoService.getCursos();
        model.addAttribute("cursos", cursos);
        
        
        return "index";
    }
    
    @GetMapping("/signup")
    public String mostrarSignup() {
        return "signup";
    }
    
    @PostMapping("/signup")
    public String guardarUsuario(@ModelAttribute("usuario") Usuario usuario) {
       
        usuarioService.save(usuario);
        
        return "redirect:/";
    }
    
}
