package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;

@Data
@Entity
@Table(name = "FIDE_ROL_TB")
@NamedStoredProcedureQuery(
    name = "SPFindAllXIdUser",
    procedureName = "ROLES_POR_USUARIO_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_USUARIO_ID", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOR", type = void.class)
    },
    resultClasses = { Rol.class} 
)
public class Rol implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ROL_TB_ID_ROL_PK")
    private Long idRol;
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
