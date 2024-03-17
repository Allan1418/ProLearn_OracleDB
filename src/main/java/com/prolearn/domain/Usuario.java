
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
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
    
    
    
    @Column(name = "nombre_usuario")
    private String nombreUsuario;
    
    @Column(name = "apellidos_usuario")
    private String apellidosUsuario;
    
    @Column(name = "correo_usuario")
    private String correoUsuario;
    
    @Column(name = "contra_usuario")
    private String contraUsuario;
    
    
    
    
    public Usuario(){
        
    }

    public Usuario(Long idUsuario, String nombreUsuario, String apellidosUsuario, String correoUsuario, String contraUsuario) {
        this.idUsuario = idUsuario;
        this.nombreUsuario = nombreUsuario;
        this.apellidosUsuario = apellidosUsuario;
        this.correoUsuario = correoUsuario;
        this.contraUsuario = contraUsuario;
    }
    
    
    
}
