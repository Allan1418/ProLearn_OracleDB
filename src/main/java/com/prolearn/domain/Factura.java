package com.prolearn.domain;

import jakarta.persistence.*;
import lombok.Data;
import java.io.Serializable;
import java.sql.Date;

@Data
@Entity
@Table(name = "FIDE_FACTURA_TB")
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
    name = "SPFindXIdUserFT",
    procedureName = "FACTURA_GET_BYUSER_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_USER", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_RESULTADO", type = void.class)
    },
    resultClasses = { Factura.class }
)
@NamedStoredProcedureQuery(
    name = "SPFindAllFT",
    procedureName = "FACTURA_GETALL_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_FACTURAS", type = void.class)
    },
    resultClasses = { Factura.class }
)
@NamedStoredProcedureQuery(
    name = "SPCrearFT",
    procedureName = "FACTURA_CREAR_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_MONTO_ID", type = Long.class),    
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_USUARIO_ID", type = Long.class)    
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

    @Column(name = "USUARIO_ID")
    private Long idUser;
    
    @Column(name = "MONTO_ID")
    private Long idMonto;
    
    @Transient
    private Monto monto;
    
    @Column(name = "FECHA_PAGO")
    private Date fechaPago;
    
    @Column(name = "FECHA_EXPIRACION")
    private Date fechaExcp;

    public Factura() {
    }

    public Factura(Long idFactura, Long idUser, Long idMonto, Date fechaPago, Date fechaExcp) {
        this.idFactura = idFactura;
        this.idUser = idUser;
        this.idMonto = idMonto;
        this.fechaPago = fechaPago;
        this.fechaExcp = fechaExcp;
    }

    public Factura(Long idUser, Long idMonto, Date fechaPago, Date fechaExcp) {
        this.idUser = idUser;
        this.idMonto = idMonto;
        this.fechaPago = fechaPago;
        this.fechaExcp = fechaExcp;
    }
    
    
}