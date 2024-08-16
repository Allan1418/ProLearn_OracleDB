package com.prolearn.domain;

import jakarta.persistence.*;
import lombok.Data;
import java.io.Serializable;

@Data
@Entity
@Table(name = "MONTO_TB")
public class Monto implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MONTO_TB_ID_MONTO_PK")
    private Long id;

    private Double monto;

    @ManyToOne
    @JoinColumn(name = "factura_id", referencedColumnName = "FACTURA_TB_ID_FACTURA_PK")
    private Factura factura;

    // Constructor vacío
    public Monto() {
    }

    // Constructor con parámetros
    public Monto(Double monto, Factura factura) {
        this.monto = monto;
        this.factura = factura;
    }
}