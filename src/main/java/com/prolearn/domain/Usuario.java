
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

@Data
@Entity
@Table(name="Usuarios")
public class Usuario implements Serializable{
    
    private static final long serialVersionUID =1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_usuario")
    private long idUsuario;
    
    private String nombre_completo;
    private String correo_electronico;
    private String contrasena;
    private String rol;

    
    
    public Usuario(){
    }

    public Usuario(long idUsuario, String nombre_completo, String correo_electronico, String contrasena, String rol) {
        this.idUsuario = idUsuario;
        this.nombre_completo = nombre_completo;
        this.correo_electronico = correo_electronico;
        this.contrasena = contrasena;
        this.rol = rol;
    }

    

    
}
