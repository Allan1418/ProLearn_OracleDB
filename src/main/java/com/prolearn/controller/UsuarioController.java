package com.prolearn.controller;

import com.prolearn.domain.Usuario;
import com.prolearn.service.FirebaseStorageService;
import com.prolearn.service.UsuarioService;
import com.prolearn.service.Impl.FirebaseStorageServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/UsrSinCuenta")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/despSesion")
    public String despSesion(Model model) {

        return null;
    }

    @Autowired
    private FirebaseStorageServiceImpl FirebaseStorageService;
}
