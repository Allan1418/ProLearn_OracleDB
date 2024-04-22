/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.prolearn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/Footer")
public class FooterController {
    
    @GetMapping("/politicaPrivacidad")
    public String politicaPrivacidad() {
        
        return "/Footer/politicaPrivacidad";
    }
    
    @GetMapping("/avisoLegal")
    public String avisoLegal() {
        
        return "/Footer/avisoLegal";
    }
    
    @GetMapping("/condiContratacion")
    public String condiContratacionl() {
        
        return "/Footer/condiContratacion";
    }
    
    @GetMapping("/cookies")
    public String cookies() {
        
        return "/Footer/cookies";
    }
}
