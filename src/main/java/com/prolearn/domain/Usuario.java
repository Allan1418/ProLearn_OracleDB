package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Collection;
import lombok.Data;

@Data
@Entity
@Table(name = "FIDE_USUARIOS_TB", uniqueConstraints = @UniqueConstraint(columnNames = "email"))
@NamedStoredProcedureQuery(
    name = "SPFindXEmailUser",
    procedureName = "USUARIO_GET_BY_EMAIL_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_EMAIL", type = String.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOR", type = void.class)
    },
    resultClasses = { Usuario.class} 
)
@NamedStoredProcedureQuery(
    name = "SPFindAllUser",
    procedureName = "USUARIO_FINDALL_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOR", type = void.class)
    },
    resultClasses = { Usuario.class} 
)
@NamedStoredProcedureQuery(
    name = "SPFindByIdUser",
    procedureName = "USUARIO_GET_BYID_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_USER", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOR", type = void.class)
    },
    resultClasses = { Usuario.class} 
)
@NamedStoredProcedureQuery(
    name = "SPUpsertUser",
    procedureName = "USUARIO_UPSERT_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_USUARIO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_NOMBRE", type = String.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_APELLIDOS", type = String.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_EMAIL", type = String.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_PASSWORD", type = String.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ROL_ID", type = Long.class)
    }
)
public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "USUARIOS_TB_ID_USER_PK")
    private Long id;

    @Column(name = "NOMBRE")
    private String nombre;

    @Column(name = "APELLIDOS")
    private String apellidos;

    @Column(name = "EMAIL")
    private String email;

    @Column(name = "PASSWORD")
    private String password;

    @Column(name = "ROL_ID")
    private Long idRol;
    
    @Transient
    private Rol rol;

    public Usuario() {

    }

    public Usuario(Long idUsuario, String nombre, String apellidos, String username, String password, Long idRol) {
        this.id = idUsuario;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.email = username;
        this.password = password;
        this.idRol = idRol;
    }

    public Usuario(String nombre, String apellidos, String username, String password, Long idRol) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.email = username;
        this.password = password;
        this.idRol = idRol;
    }

}
