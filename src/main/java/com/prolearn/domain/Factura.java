package com.prolearn.domain;

import jakarta.persistence.*;
import lombok.Data;
import java.io.Serializable;
import java.sql.Time;
import java.util.Date;

@Data
@Entity
@NamedStoredProcedureQuery(
    name = "SPFindXIdFT",
    procedureName = "FACTURA_GET_BYID_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_FACTURA", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_RESULTADO", type = void.class)
    },
    resultClasses = { Factura.class }
)
@NamedStoredProcedureQuery(
    name = "SPFindAllXIdCursoFT",
    procedureName = "FACTURA_GETALL_BY_CURSO_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CURSO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_FACTURAS", type = void.class)
    },
    resultClasses = { Factura.class }
)
@NamedStoredProcedureQuery(
    name = "SPUpsertFT",
    procedureName = "FACTURA_UPSERT_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_FACTURA", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_MONTO", type = Double.class)    
    }
)
@NamedStoredProcedureQuery(
    name = "SPDeleteFT",
    procedureName = "FACTURA_DELETE_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_FACTURA", type = Long.class)
    }
)

public class Factura implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "FACTURA_TB_ID_FACTURA_PK")
    private Long idFactura;

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

    public Factura(Long idFactura) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}