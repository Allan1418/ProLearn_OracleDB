
package com.prolearn.controller;

import com.prolearn.domain.Curso;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import com.prolearn.service.CursoService;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
@Slf4j
@RequestMapping("/cuenta")
public class CursoController {
    
    @Autowired
    private CursoService cursoService;
    
    @GetMapping("/menu")
    public String inicio(Model model){
        
        var cursos = cursoService.getCursos();
        model.addAttribute("cursos", cursos);
        model.addAttribute("totalCursos",cursos.size());
        
        return "/cuenta/menu";
    }
    
//    @GetMapping("/nuevo")
//    public String cursoNuevo(Curso curso) {
//        return "/curso/menu";
//    }
//
//    @PostMapping("/guardar")
//    public String cursoGuardar(Curso curso) {
//        cursoService.save(curso);
//        return "redirect:/curso/menu";
//    }
//
    @GetMapping("/eliminar/{idCurso}")
    public String cursoEliminar(Curso curso) {
        cursoService.delete(curso);
        return "redirect:/cuenta/menu";
    }
//
//    @GetMapping("/modificar/{idCurso}")
//    public String cursoModificar(Curso curso, Model model) {
//        curso = cursoService.getCurso(curso);
//        model.addAttribute("curso", curso);
//        return "/curso/menu";
//    }

}
