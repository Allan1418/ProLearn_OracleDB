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
    private UsuarioService usuarioService;

    @Autowired
    private HttpSession session;

    @Autowired
    private FirebaseStorageService firebaseStorageService;

    @GetMapping("/listarCursos")
    public String listarCursos(Model model) {

        var cursos = cursoService.getCursosAdmin();
        model.addAttribute("cursos", cursos);

        List<Categoria> categorias = categoriaService.getCategorias();
        model.addAttribute("categorias", categorias);
        
        model.addAttribute("curso", new Curso()); 

        return "/adminCurso/listarCursos";
    }

    @PostMapping("/newCurso")
    public String newCurso(Curso curso, @RequestParam("imagenNuevo")MultipartFile imagen, Model model) {
        
//        System.out.println("ID del curso: " + curso.getIdCurso());
//        System.out.println("Nombre del curso: " + curso.getNombreCurso());
//        System.out.println("Descripción del curso: " + curso.getDescrpCurso());
//        System.out.println("Estado del curso: " + curso.isEstadoCurso());
//        System.out.println("URL de la miniatura del curso: " + curso.getThumbnailCurso());
//        System.out.println("ID de la categoría del curso: " + curso.getCategoriaId());
        
        curso.setIdCurso(0L);
        Long newId = cursoService.save(curso);

        if (!imagen.isEmpty()) {

            curso.setIdCurso(newId);
            curso = cursoService.getCurso(curso);

            String DirecCarpt = curso.getIdCurso().toString();
            Long idFirebase = curso.getIdCurso();

            String url = firebaseStorageService.cargaArchivo(imagen,
                    DirecCarpt,
                    "image",
                    idFirebase,
                    imagen.getContentType());

            curso.setThumbnailCurso(url);
            
            //System.out.println("-------------inicia");
            cursoService.save(curso);
            //System.out.println("-------------finaliza");
        }
        
        
        return "redirect:/adminCurso/listarCursos";
    }
    
    @PostMapping("/editarCurso/{idCurso}")
    public String saveCurso(Curso curso, @RequestParam("imagenNuevo")MultipartFile imagen, Model model) {
        
        if (!imagen.isEmpty()) {

            
            String DirecCarpt = curso.getIdCurso().toString();
            Long idFirebase = curso.getIdCurso();

            String url = firebaseStorageService.cargaArchivo(imagen,
                    DirecCarpt,
                    "image",
                    idFirebase,
                    imagen.getContentType());

            curso.setThumbnailCurso(url);

        }
        
        cursoService.save(curso);

        return "redirect:/adminCurso/detalleCurso/" + curso.getIdCurso();
    }
    
    @GetMapping("/deleteCurso/{idCurso}")
    public String deleteCurso(Curso curso, Model model) {

        curso = cursoService.getCurso(curso);

        cursoService.delete(curso);

        return "redirect:/adminCurso/listarCursos";
    }

    @GetMapping("/detalleCurso/{idCurso}")
    public String detalleCurso(Curso curso, Model model) {

        curso = cursoService.getCurso(curso);
        model.addAttribute("curso", curso);

        List<CapituloPadre> listaPadres = capitulosEstrucService.getPadres(curso.getIdCurso());
        model.addAttribute("ListaPadres", listaPadres);

        List<Categoria> categorias = categoriaService.getCategorias();
        model.addAttribute("categorias", categorias);

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

    @GetMapping("/detalleCapituloHijo/{idCurso}/{id}")
    public String detalleCapituloHijo(Curso curso, CapituloHijo capituloHijo, Model model) {

        capituloHijo = capituloHijoService.getCapituloHijo(capituloHijo);
        curso = cursoService.getCurso(curso);

        model.addAttribute("capituloHijo", capituloHijo);
        model.addAttribute("curso", curso);

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
        //System.out.println(newId);

        
        if (!video.isEmpty()) {

            capituloHijo.setId(newId);
            capituloHijo = capituloHijoService.getCapituloHijo(capituloHijo);

            String DirecCarpt = curso.getIdCurso().toString();
            Long idFirebase = Long.valueOf(curso.getIdCurso().toString() + capituloHijo.getId().toString());

            String url = firebaseStorageService.cargaArchivo(video,
                    DirecCarpt,
                    "video",
                    idFirebase,
                    video.getContentType());

            capituloHijo.setVideo(url);
            capituloHijoService.save(capituloHijo, curso);
        }

        
        return "redirect:/adminCurso/detalleCapitulos/" + curso.getIdCurso() + "/" + capituloPadre.getId();
    }

    @PostMapping("/detalleCapituloHijo/{idCurso}/{id}")
    public String saveCapituloHijo(Curso curso,
            CapituloHijo capituloHijo,
            @RequestParam("videoNuevo")MultipartFile video, 
            Model model) {

        curso = cursoService.getCurso(curso);

//        System.out.println("ID: " + capituloHijo.getId());
//        System.out.println("Nombre: " + capituloHijo.getNombre());
//        System.out.println("Video: " + capituloHijo.getVideo());
//        System.out.println("Número: " + capituloHijo.getNumero());
//        System.out.println("ID Capítulo Padre: " + capituloHijo.getCapituloPadreId());
        
        
        if (!video.isEmpty()) {

            
            String DirecCarpt = curso.getIdCurso().toString();
            Long idFirebase = Long.valueOf(curso.getIdCurso().toString() + capituloHijo.getId().toString());

            String url = firebaseStorageService.cargaArchivo(video,
                    DirecCarpt,
                    "video",
                    idFirebase,
                    video.getContentType());

            capituloHijo.setVideo(url);

        }

        capituloHijoService.save(capituloHijo, curso);

        return "redirect:/adminCurso/detalleCapitulos/" + curso.getIdCurso() + "/" + capituloHijo.getCapituloPadreId();
    }

    
    @GetMapping("/deleteCapituloHijo/{idCurso}/{id}")
    public String deleteCapituloHijo(Curso curso, CapituloHijo capituloHijo, Model model) {

        curso = cursoService.getCurso(curso);
        capituloHijo = capituloHijoService.getCapituloHijo(capituloHijo);

        Long idPadre = capituloHijo.getCapituloPadreId();

        capituloHijoService.delete(capituloHijo);

        return "redirect:/adminCurso/detalleCapitulos/" + curso.getIdCurso() + "/" + idPadre;
    }
    
    @GetMapping("/listarUsuarios")
    public String listarUsuarios(Model model) {
        
        List<Usuario> usuarios = usuarioService.getUsuarios();
        model.addAttribute("usuarios", usuarios);
        
        List<Rol> roles = usuarioService.getAllRoles();
        model.addAttribute("roles", roles);

        return "/adminCurso/listarUsuarios";
    }
    
    @PostMapping("/listarUsuarios/{id}/{idRol}")
    public String cambioRol(Usuario usuario, Rol rol, Model model) {
        
        usuario = usuarioService.getUsuario(usuario);
        rol = usuarioService.getRolByIdRol(rol);
        
        usuarioService.cambiarRolAdmin(usuario, rol);

        return "/adminCurso/listarUsuarios";
    }
    
}
