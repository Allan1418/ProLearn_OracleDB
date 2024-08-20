package com.prolearn.controller;

import com.prolearn.domain.Factura;
import com.prolearn.domain.Usuario;
import com.prolearn.domain.Monto;
import com.prolearn.service.FacturaService;
import com.prolearn.service.MontoService;
import com.prolearn.service.UsuarioService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@Controller
@RequestMapping("/factura")
public class FacturaController {

    @Autowired
    private FacturaService facturaService;

    @Autowired
    private UsuarioService usuarioService;

    @Autowired
    private MontoService montoService;

    @Autowired
    private HttpSession session;

    @GetMapping("/listarFacturas")
    public String listarFacturas(Model model) {
        Factura factura = null;
        var facturas = facturaService.getFactura(factura);
        model.addAttribute("facturas", facturas);
        return "/adminFactura/listarFacturas";
    }

    @GetMapping("/detalleFactura/{idFactura}")
    public String detalleFactura(@RequestParam("idFactura") Long idFactura, Model model) {
        Factura factura = facturaService.getFactura(new Factura(idFactura));
        model.addAttribute("factura", factura);
        return "/adminFactura/detalleFactura";
    }

    @PostMapping("/saveFactura")
    public String saveFactura(Factura factura, Model model) {
        facturaService.save(factura);
        return "redirect:/adminFactura/listarFacturas";
    }

    @GetMapping("/deleteFactura/{idFactura}")
    public String deleteFactura(@RequestParam("idFactura") Long idFactura, Model model) {
        Factura factura = facturaService.getFactura(new Factura(idFactura));
        facturaService.delete(factura);
        return "redirect:/adminFactura/listarFacturas";
    }
}