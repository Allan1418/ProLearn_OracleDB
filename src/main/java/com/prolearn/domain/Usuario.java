package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.Collection;
import lombok.Data;

@Data
@Entity
@Table(name = "usuarios", uniqueConstraints = @UniqueConstraint(columnNames = "email"))
public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    private String nombre;

    private String apellidos;

    private String email;

    private String password;

    
    //Revisar con tablas mysql!!!!!!!
    @ManyToMany(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
    @JoinTable(
            name = "usuarios_roles",
            joinColumns = @JoinColumn(name = "usuario_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "rol_id", referencedColumnName = "id")
    )
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
