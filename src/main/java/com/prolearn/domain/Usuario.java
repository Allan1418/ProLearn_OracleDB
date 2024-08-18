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
public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "USUARIOS_TB_ID_USER_PK")
    private Long id;

    private String nombre;

    private String apellidos;

    private String email;

    private String password;

    
//    //Revisar con tablas mysql!!!!!!!
//    @ManyToMany(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
//    @JoinTable(
//            name = "FIDE_USUARIO_ROL_TB",
//            joinColumns = @JoinColumn(name = "usuario_id", referencedColumnName = "USUARIOS_TB_ID_USER_PK"),
//            inverseJoinColumns = @JoinColumn(name = "rol_id", referencedColumnName = "ROL_TB_ID_ROL_PK")
//    )
    @Transient
    private Collection<Rol> roles;

    public Usuario() {

    }

    public Usuario(Long idUsuario, String nombre, String apellidos, String username, String password, Collection<Rol> roles) {
        this.id = idUsuario;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.email = username;
        this.password = password;
        this.roles = roles;
    }

    public Usuario(String nombre, String apellidos, String username, String password, Collection<Rol> roles) {
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.email = username;
        this.password = password;
        this.roles = roles;
    }

}
