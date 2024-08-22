package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;

@Data
@Entity
@Table(name = "FIDE_ROL_TB")
@NamedStoredProcedureQuery(
    name = "SPFindByNombreRol",
    procedureName = "ROL_GETBY_NOMBRE_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_NOMBRE", type = String.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOR", type = void.class)
    },
    resultClasses = { Rol.class} 
)
@NamedStoredProcedureQuery(
    name = "SPFindByIdRol",
    procedureName = "ROL_GETBY_ID_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_ROL", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOR", type = void.class)
    },
    resultClasses = { Rol.class} 
)
@NamedStoredProcedureQuery(
    name = "SPFindAllRol",
    procedureName = "ROL_GET_BYALL_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOR", type = void.class)
    },
    resultClasses = { Rol.class} 
)
public class Rol implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ROL_TB_ID_ROL_PK")
    private Long idRol;
    
    @Column(name = "NOMBRE")
    private String nombre;

    public Rol(Long idRol, String nombre) {
        this.idRol = idRol;
        this.nombre = nombre;
    }

    public Rol(String nombre) {
        this.nombre = nombre;
    }

    public Rol() {
    }

}
