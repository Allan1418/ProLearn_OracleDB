package com.prolearn.controller;

import com.prolearn.domain.CapituloHijo;
import com.prolearn.domain.CapituloPadre;
import com.prolearn.domain.CapitulosEstruc;
import com.prolearn.domain.Curso;
import com.prolearn.service.CursoService;
import com.prolearn.service.CapitulosEstrucService;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
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
@RequestMapping("/curso")
public class CursoController {

    @Autowired
    private CursoService cursoService;
    
    @Autowired
    private CapitulosEstrucService capitulosEstrucService;

//    @GetMapping("/curso")
//    private String getCursos(Model model) {
//        var cursos = cursoService.getCursos();
//        model.addAttribute("cursos", cursos);
//        return "/curso/curso";
//    }
//    
//    @GetMapping("/eliminar/{idCurso}")
//    public String categoriaEliminar(Curso curso) {
//        cursoService.delete(curso);
//        return "redirect://";
//    }
//    
//    
//    @PostMapping("/guardar")
//    public String categoriaGuardar(Curso curso) {        
//        cursoService.save(curso);
//        return "redirect://";
//    }
//    
//    @GetMapping("/modificar/{idCurso}")
//    public String categoriaModificar(Curso curso, Model model) {
//        curso = cursoService.getCurso(curso);
//        model.addAttribute("categoria", curso);
//        return "//";
//    }  
    @GetMapping("/curso/{idCurso}")
    public String cursoMostrar(Curso curso, Model model) {
        curso = cursoService.getCurso(curso);

        List<CapitulosEstruc> lista = new ArrayList<>();

        for (CapituloPadre capituloPadre : capitulosEstrucService.getPadres(curso.getIdCurso())) {
            
            List<CapituloHijo> listaHijos = capitulosEstrucService.getHijos(curso.getIdCurso(), capituloPadre.getId());
            
            lista.add(new CapitulosEstruc(capituloPadre, listaHijos));
        }

        model.addAttribute("lista", lista);
        model.addAttribute("curso", curso);
        return "curso/curso";
    }

    

}
