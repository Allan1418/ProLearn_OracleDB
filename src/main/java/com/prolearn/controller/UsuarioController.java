
package com.prolearn.controller;

import com.prolearn.domain.Usuario;
import com.prolearn.service.UsuarioService;
import com.prolearn.service.FirebaseStorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;


@Controller
@RequestMapping("/usuario")
public class UsuarioController {
    
    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/login")
    public String mostrarFormularioDeInicioSesion(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "login";
    }

    @PostMapping("/login")
    public String iniciarSesion(Usuario usuario) {
        //a
        
        
        
        return "redirect:/";
    }

    @GetMapping("/registro")
    public String mostrarFormularioDeRegistro(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "registro";
    }

    @PostMapping("/registro")
    public String registrarCuentaDeUsuario(Usuario usuario) {
        usuarioService.save(usuario);
        return "redirect:/usuario/listado";
    }

    @GetMapping("/usuario/listado")
    public String listado(Model model) {
        var usuarios = usuarioService.getUsuarios();
        model.addAttribute("usuarios", usuarios);
        model.addAttribute("totalUsuarios", usuarios.size());
        return "/usuario/listado";
    }

    @GetMapping("/usuario/nuevo")
    public String usuarioNuevo(Model model) {
        model.addAttribute("usuario", new Usuario());
        return "/usuario/modifica";
    }

    @PostMapping("/usuario/guardar")
    public String usuarioGuardar(Usuario usuario) {
        usuarioService.save(usuario);
        return "redirect:/usuario/listado";
    }

    @GetMapping("/usuario/eliminar/{idUsuario}")
    public String usuarioEliminar(@PathVariable("idUsuario") Usuario usuario) {
        usuarioService.delete(usuario);
        return "redirect:/usuario/listado";
    }

    @GetMapping("/usuario/modificar/{idUsuario}")
    public String usuarioModificar(@PathVariable("idUsuario") Usuario usuario, Model model) {
        model.addAttribute("usuario", usuario);
        return "/usuario/modifica";
    }
    
    
}
