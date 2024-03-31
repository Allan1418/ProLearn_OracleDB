package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;

@Data
@Entity
@Table(name = "rol")
public class Rol implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_rol")
    private Long idRol;
    private String nombre;
    
    @Column(name = "id_usuario")
    private Long idUsuario;

    public Rol(Long idRol, String nombre, Long idUsuario) {
        this.idRol = idRol;
        this.nombre = nombre;
        this.idUsuario = idUsuario;
    }

    public Rol() {
    }
    
    

}
