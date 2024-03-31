
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;


@Data
@Entity
@Table(name = "usuarios")
public class Usuario implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Long idUsuario;
    
    
    
    private String nombre;
    
    private String apellidos;
    
    private String username;
    
    private String password;
    
    @OneToMany
    @JoinColumn(name = "id_usuario")
    List<Rol> roles;
    
    
    public Usuario(){
        
    }

    public Usuario(Long idUsuario, String nombre, String apellidos, String username, String password, List<Rol> roles) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.username = username;
        this.password = password;
        this.roles = roles;
    }

    
    
}
