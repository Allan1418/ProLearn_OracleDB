
package com.prolearn.controller;

import com.prolearn.domain.*;
import com.prolearn.service.*;
import com.prolearn.domain.CapitulosEstruc;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/adminCurso")
public class AdminCursoController {
    
    //arreglar metodos:
    //-l detalleCurso(Curso curso, Model model)
    //-l detalleCapituloPadre(Curso curso, CapituloPadre capituloPadre, Model model)
    //saveCapituloPadre(CapituloPadre capituloPadre)
    
    @Autowired
    private CursoService cursoService;
    
    @Autowired
    private CategoriaService categoriaService;
    
    @Autowired
    private CapituloPadreService capituloPadreService;
    
    @Autowired
    private CapituloHijoService capituloHijoService;
    
    @Autowired
    private CapitulosEstrucService capitulosEstrucService;
    
    @Autowired
    private HttpSession session;

    
    @GetMapping("/listarCursos")
    public String listarCursos(Model model) {
        
        var cursos = cursoService.getCursosAdmin();
        model.addAttribute("cursos", cursos);
        
        //var categorias = categoriaService.getCategorias();
        //model.addAttribute("categorias", categorias);
        
        return "/adminCurso/listarCursos";
    }
    
    @GetMapping("/detalleCurso/{idCurso}")
    public String detalleCurso(Curso curso, Model model) {
        
        curso = cursoService.getCurso(curso);
        model.addAttribute("curso", curso);
        
        List<CapituloPadre> listaPadres = capitulosEstrucService.getPadres(curso.getIdCurso());
        model.addAttribute("ListaPadres", listaPadres);
        
        return "/adminCurso/detalleCurso";
    }
    
    @GetMapping("/detalleCapitulos/{idCurso}/{id}")
    public String detalleCapituloPadre(Curso curso, CapituloPadre capituloPadre, Model model) {
        
        curso = cursoService.getCurso(curso);
        
        capituloPadre = capituloPadreService.getCapituloPadre(capituloPadre);
        
        List<CapituloHijo> listaHijos = capitulosEstrucService.getHijos(curso.getIdCurso(), capituloPadre.getId());
        
        //session.setAttribute(("curso-"+capituloPadre.getId()), curso);
        
        model.addAttribute("capituloPadre", capituloPadre);
        model.addAttribute("listaHijos", listaHijos);
        
        
        
        
        return "/adminCurso/detalleCapitulos";
    }
    
    @GetMapping("/detalleCapituloHijo/{id}")
    public String detalleCapituloHijo(CapituloHijo capituloHijo, Model model) {
        
        
        capituloHijo = capituloHijoService.getCapituloHijo(capituloHijo);
        
        model.addAttribute("capituloHijo", capituloHijo);
        
        
        
        
        return "/adminCurso/detalleCapituloHijo";
    }
    
    @Deprecated
    @PostMapping("/save-capituloHijo")
    public String saveCapituloHijo(CapituloHijo capituloHijo) {
        
        
//        
//        if (capituloHijo != null) {
//            System.out.println("ID: " + capituloHijo.getId());
//            System.out.println("Nombre: " + capituloHijo.getNombre());
//            System.out.println("Video: " + capituloHijo.getVideo());
//            System.out.println("Número: " + capituloHijo.getNumero());
//            System.out.println("Capítulo padre: " + capituloHijo.getCapituloPadre().getNombre());
//        } else{
//            System.out.println("nuloooooooooooooooooooo");
//        }
        
        
        
        capituloHijoService.save(capituloHijo);
        
        Long id = capituloHijo.getCapituloPadre().getId();
        
        Curso curso = (Curso) session.getAttribute("curso-" + capituloHijo.getCapituloPadre().getId());
        Long idCurso = curso.getIdCurso();
        
        return "redirect:/adminCurso/detalleCapitulos/" + idCurso + "/" + id;
    }
    
//    @PostMapping("/save-capituloPadre")
//    public String saveCapituloPadre(CapituloPadre capituloPadre) {
//        
//        //Long id = capituloPadre.getId();
//        Long id;
//        
//        Curso curso = (Curso) session.getAttribute("curso-" + capituloPadre.getId());
//        Long idCurso = curso.getIdCurso();
//        
//        //---
//        
//        List<CapituloHijo> listaHijosCurso = curso.getCapitulosHijos();
//        List<CapituloHijo> listaHijosPadre = capituloPadreService.getCapitulosHijos(capituloPadre);
//        
//        listaHijosPadre.removeIf(capituloHijo -> listaHijosCurso.contains(capituloHijo));
//        
//        
//        if (listaHijosPadre.isEmpty()) {
//            capituloPadreService.save(capituloPadre);
//            id = capituloPadre.getId();
//        }else{
//            
//            CapituloPadre nuevoPadre = new CapituloPadre(capituloPadre.getNombre(), capituloPadre.getNumero());
//            capituloPadreService.save(nuevoPadre);
////            System.out.println("####" + nuevoPadre.getId());
////            System.out.println("####" + nuevoPadre.getNumero());
////            System.out.println("####" + nuevoPadre.getNombre());
//            
//            for (CapituloHijo i : listaHijosCurso) {
//                
//                if (i.getCapituloPadre().getId().equals(capituloPadre.getId())) {
//                    i.setCapituloPadre(nuevoPadre);
//                    capituloHijoService.save(i);
//                }
//                
//                
//            }
//            id = nuevoPadre.getId();
//            
//        }
//        
//        
//        
//        
//        //capituloPadreService.save(capituloPadre);
//        
//        return "redirect:/adminCurso/detalleCapitulos/" + idCurso + "/" + id;
//    }
    
    @Deprecated
    @GetMapping("/deleteCapituloHijo/{id}")
    public String deleteCapituloHijo(CapituloHijo capituloHijo, Model model) {
        
        capituloHijo = capituloHijoService.getCapituloHijo(capituloHijo);
        
        Long id = capituloHijo.getCapituloPadre().getId();
        
        Curso curso = (Curso) session.getAttribute("curso-" + capituloHijo.getCapituloPadre().getId());
        Long idCurso = curso.getIdCurso();
        
        capituloHijo.setCapituloPadre(null);
        capituloHijo = capituloHijoService.getCapituloHijo(capituloHijo);
        
        capituloHijoService.delete(capituloHijo);
        
        return "redirect:/adminCurso/detalleCapitulos/" + idCurso + "/" + id;
    }
    
    
    @PostMapping("/detalleCurso/{idCurso}")
    public String newCapituloPadre(Curso curso, CapituloPadre capituloPadre, Model model) {
        
        capituloPadre.setId(0L);
        
        capituloPadreService.save(capituloPadre, curso);
        
        return "redirect:/adminCurso/detalleCurso/" + curso.getIdCurso();
    }
    
    
    @GetMapping("/deleteCapituloPadre/{idCurso}/{id}")
    public String deleteCapituloPadre(Curso curso, CapituloPadre capituloPadre, Model model) {
        
        curso = cursoService.getCurso(curso);
        capituloPadre = capituloPadreService.getCapituloPadre(capituloPadre);
        
        capituloPadreService.delete(capituloPadre);
        
        
        return "redirect:/adminCurso/detalleCurso/" + curso.getIdCurso();
    }
    
    @PostMapping("/save-capituloPadre/{idCurso}")
    public String saveCapituloPadre(Curso curso, CapituloPadre capituloPadre, Model model) {
        
        curso = cursoService.getCurso(curso);
        
        capituloPadreService.save(capituloPadre, curso);
        
        return "redirect:/adminCurso/detalleCapitulos/" + curso.getIdCurso() + "/" + capituloPadre.getId();
    }
}
