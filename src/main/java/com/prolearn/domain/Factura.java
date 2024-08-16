package com.prolearn.domain;

import jakarta.persistence.*;
import lombok.Data;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "FACTURA_TB")
public class Factura implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "FACTURA_TB_ID_FACTURA_PK")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "usuario_id", referencedColumnName = "USUARIOS_TB_ID_USER_PK")
    private Usuario usuario;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "monto_id", referencedColumnName = "MONTO_TB_ID_MONTO_PK")
    private Monto monto;

    private Double montoTotal;

    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaPago;

    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaExpiracion;

    // Constructores, getters y setters son generados por Lombok
}