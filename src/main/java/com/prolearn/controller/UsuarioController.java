
package com.prolearn.controller;

import com.prolearn.domain.Usuario;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.prolearn.service.UsuarioService;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@Slf4j
@RequestMapping("/cuenta")
public class UsuarioController {
    
    @Autowired
    private UsuarioService usuarioService;
    
    @GetMapping("/sesion")
    public String inicio(Model model){
        
        var usuarios = usuarioService.getUsuarios();
        model.addAttribute("usuarios", usuarios);
        model.addAttribute("totalUsuarios",usuarios.size());
        
        return "/cuenta/sesion";
    }
    
//    @GetMapping("/nuevo")
//    public String usuarioNuevo(Usuario usuario) {
//        return "/usuario/menu";
//    }
//
//    @PostMapping("/guardar")
//    public String usuarioGuardar(Usuario usuario) {
//        usuarioService.save(usuario);
//        return "redirect:/usuario/menu";
//    }
//
    @GetMapping("/eliminar/{idUsuario}")
    public String usuarioEliminar(Usuario usuario) {
        usuarioService.delete(usuario);
        return "redirect:/cuenta/sesion";
    }
//
//    @GetMapping("/modificar/{idUsuario}")
//    public String usuarioModificar(Usuario usuario, Model model) {
//        usuario = usuarioService.getUsuario(usuario);
//        model.addAttribute("usuario", usuario);
//        return "/usuario/menu";
//    }

}
