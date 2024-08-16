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

    @GetMapping("/listado")
    public String listado(Model model) {
        List<Monto> montos = montoService.getMontos();
        model.addAttribute("montos", montos);
        return "/monto/listado";
    }

    @GetMapping("/nuevo")
    public String nuevoMonto(Model model) {
        model.addAttribute("monto", new Monto());
        return "/monto/modifica";
    }

    @PostMapping("/guardar")
    public String guardarMonto(@ModelAttribute Monto monto) {
        montoService.save(monto);
        return "redirect:/monto/listado";
    }

    @GetMapping("/eliminar/{idMonto}")
    public String eliminarMonto(@PathVariable("idMonto") Long idMonto) {
        Monto monto = montoService.getMontoById(idMonto);
        if (monto != null) {
            montoService.delete(monto);
        }
        return "redirect:/monto/listado";
    }
}