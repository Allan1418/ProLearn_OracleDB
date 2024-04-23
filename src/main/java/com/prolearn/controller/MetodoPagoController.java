
package com.prolearn.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/metodoPago/")
public class MetodoPagoController {
    
    @GetMapping("/metodoPago")
    public String politicaPrivacidad() {
        
        return "/metodoPago/metodoPago";
    }

}
