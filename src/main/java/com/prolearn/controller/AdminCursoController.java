
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
    
    @Autowired
    private FirebaseStorageService firebaseStorageService;

    
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
    
    @PostMapping("/newCapituloHijo/{idCurso}/{id}")
    public String newCapituloHijo(Curso curso, 
                                    CapituloPadre capituloPadre, 
                                    CapituloHijo capituloHijo, 
                                    @RequestParam("videoNuevo")MultipartFile video, 
                                    Model model) {
        
        curso = cursoService.getCurso(curso);
        capituloPadre = capituloPadreService.getCapituloPadre(capituloPadre);
        
        capituloHijo.setId(0L);
        capituloHijo.setCapituloPadreId(capituloPadre.getId());
        
        Long newId = capituloHijoService.save(capituloHijo, curso);
        System.out.println(newId);
        
        
        if (!video.isEmpty()) {
            
            capituloHijo.setId(newId);
            capituloHijo = capituloHijoService.getCapituloHijo(capituloHijo);
            
            String DirecCarpt = curso.getIdCurso().toString();
            Long idFirebase = Long.valueOf(curso.getIdCurso().toString() + capituloHijo.getId().toString());
            
            String url = firebaseStorageService.cargaArchivo(video,
                    DirecCarpt, 
                        idFirebase, 
                 video.getContentType());
            
            capituloHijo.setVideo(url);
            capituloHijoService.save(capituloHijo, curso);
        }
        
        
        return "redirect:/adminCurso/detalleCapitulos/" + curso.getIdCurso() + "/" + capituloPadre.getId();
    }
}
