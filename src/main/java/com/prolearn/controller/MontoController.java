package com.prolearn.controller;

import com.prolearn.domain.Monto;
import com.prolearn.service.MontoService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/monto")
public class MontoController {

    @Autowired
    private MontoService montoService;
    
    @GetMapping("/listarMontos")
    public String listarMontos(Model model) {
        Monto monto = null;
        var montos = montoService.getMonto(monto);
        model.addAttribute("montos", montos);
        return "/adminMonto/listarMontos";
    }
    
    @GetMapping("/detalleMonto/{idMonto}")
    public String detalleMonto(Monto monto, Model model) {
        monto = montoService.getMonto(monto);
        model.addAttribute("monto", monto);
        return "/adminMonto/detalleMonto";
    }
    
    @PostMapping("/detalleMonto/{idMonto}")
    public String newMonto(Monto monto, Model model) {
        monto.setId(0L);
        montoService.save(monto);
        return "redirect:/adminMonto/detalleMonto/" + monto.getId();
    }
    
    @GetMapping("/deleteMonto/{idMonto}")
    public String deleteMonto(Monto monto, Model model) {
        monto = montoService.getMonto(monto);
        montoService.delete(monto);
        return "redirect:/adminMonto/listarMontos";
    }
    
    @PostMapping("/save-monto/{idMonto}")
    public String saveMonto(Monto monto, Model model) {
        montoService.save(monto);
        return "redirect:/adminMonto/detalleMonto/" + monto.getId();
    }
}