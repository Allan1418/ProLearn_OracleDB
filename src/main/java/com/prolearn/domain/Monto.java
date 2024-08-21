package com.prolearn.domain;

import jakarta.persistence.*;
import lombok.Data;
import java.io.Serializable;

@Data
@Entity
@Table(name = "FIDE_MONTO_TB")
@NamedStoredProcedureQuery(
    name = "SPFindXIdMT",
    procedureName = "MONTO_GET_BYID_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_MONTO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_RESULTADO", type = void.class)
    },
    resultClasses = { Monto.class }
)
@NamedStoredProcedureQuery(
    name = "SPFindAllXTipoSuscripcionMT",
    procedureName = "MONTO_GETALL_BY_TIPO_SUSCRIPCION_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_TIPO_SUSCRIPCION", type = String.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_MONTOS", type = void.class)
    },
    resultClasses = { Monto.class }
)
@NamedStoredProcedureQuery(
    name = "SPUpsertMT",
    procedureName = "MONTO_UPSERT_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_MONTO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_TIPO_SUSCRIPCION", type = String.class)
    }
)
@NamedStoredProcedureQuery(
    name = "SPDeleteMT",
    procedureName = "MONTO_DELETE_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_MONTO", type = Long.class)
    }
)
public class Monto implements Serializable {
    
    private static final long serialVersionUID = 1L;

    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "MONTO_TB_ID_MONTO_PK")
    private Long idMonto;

    @Column(name = "MONTO")
    private Double monto;
    
    @Column(name = "NOMBRE")
    private String nombre;
    
    @Column(name = "ESTADO_PUBLICO_MONTO")
    private boolean estado;
    
    
    
    
}