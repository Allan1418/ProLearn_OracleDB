package com.prolearn.controller;

import com.prolearn.domain.Factura;
import com.prolearn.domain.Usuario;
import com.prolearn.domain.Monto;
import com.prolearn.service.FacturaService;
import com.prolearn.service.UsuarioService;
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

    @GetMapping("/listado")
    public String listado(Model model) {
        var facturas = facturaService.getFacturas();
        model.addAttribute("facturas", facturas);
        return "/factura/listado";
    }

    @GetMapping("/nuevo")
    public String nuevaFactura(Model model) {
        model.addAttribute("factura", new Factura());
        model.addAttribute("usuarios", usuarioService.getUsuarios());
        return "/factura/modifica";
    }

@PostMapping("/guardar")
public String guardarFactura(@ModelAttribute Factura factura, @RequestParam("usuarioId") Long usuarioId) {
    Usuario usuario = new Usuario();
    usuario.setId(usuarioId);
    usuario = usuarioService.getUsuario(usuario);
    factura.setUsuario(usuario);
    factura.setFechaPago(new Date());
    factura.setFechaExpiracion(calcularFechaExpiracion());
    factura.setMonto(new Monto()); // Inicializa la propiedad monto con un objeto Monto vacío
    facturaService.save(factura);
    return "redirect:/factura/listado";
}

    private Date calcularFechaExpiracion() {
        // Lógica para calcular la fecha de expiración de la factura (puede depender de tu negocio)
        return new Date(); // Placeholder
    }

    @GetMapping("/eliminar/{idFactura}")
    public String eliminarFactura(@PathVariable("idFactura") Factura factura) {
        facturaService.delete(factura);
        return "redirect:/factura/listado";
    }
}
