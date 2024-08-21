
package com.prolearn.controller;

import com.prolearn.domain.Usuario;
import com.prolearn.service.CursoService;
import com.prolearn.service.Impl.UserAlreadyExistAuthenticationException;
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
        var cursos = cursoService.getCursosPublico();
        model.addAttribute("cursos", cursos);
        
        
        return "index";
    }
    
    @GetMapping("/signup")
    public String mostrarSignup() {
        return "signup";
    }
    
    @PostMapping("/signup")
    public String guardarUsuario(@ModelAttribute("usuario") Usuario usuario, Model model) {
        try {
            usuarioService.nuevo(usuario);
            return "redirect:/";
        } catch (UserAlreadyExistAuthenticationException e) {
            model.addAttribute("error", e.getMessage());
            usuario.setPassword(null);
            model.addAttribute("usuarioViejo", usuario);
            return "signup";
        }
    }
    
}
