
package com.prolearn.controller;

import com.prolearn.domain.*;
import com.prolearn.service.*;
import com.prolearn.domain.CapitulosEstruc;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/adminCurso")
public class AdminCursoController {
    
    @Autowired
    private CursoService cursoService;
    
    @Autowired
    private CategoriaService categoriaService;
    
    @Autowired
    private CapituloPadreService capituloPadreService;
    
    @GetMapping("/listarCursos")
    public String listarCursos(Model model) {
        
        var cursos = cursoService.getCursos();
        model.addAttribute("cursos", cursos);
        
        var categorias = categoriaService.getCategorias();
        model.addAttribute("categorias", categorias);
        
        return "/adminCurso/listarCursos";
    }
    
    @GetMapping("/detalleCurso/{idCurso}")
    public String detalleCurso(Curso curso, Model model) {
        
        curso = cursoService.getCurso(curso);
        model.addAttribute("curso", curso);
        
        List<CapituloPadre> listaPadres = CapitulosEstruc.getListaCapituloPadre(curso);
        model.addAttribute("ListaPadres", listaPadres);
        
        return "/adminCurso/detalleCurso";
    }
    
    @GetMapping("/detalleCapitulos/{idCurso}/{id}")
    public String detalleCapituloPadre(Curso curso, CapituloPadre capituloPadre, Model model) {
        
        curso = cursoService.getCurso(curso);
        
        capituloPadre = capituloPadreService.getCapituloPadre(capituloPadre);
        CapituloPadre padreLamnda = capituloPadre;
        
        List<CapituloHijo> listaHijos = curso.getCapitulosHijos();
        listaHijos.removeIf(ch ->!ch.getCapituloPadre().getNombre().equals(padreLamnda.getNombre()));
        
        model.addAttribute("capituloPadre", capituloPadre);
        model.addAttribute("listaHijos", listaHijos);
        
        
        
        
        return "/adminCurso/detalleCapitulos";
    }
    
    
}
