
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

@Data
@Entity
@Table(name="Crear")
public class Crear implements Serializable{
    
    private static final long serialVersionUID =1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_crear")
    private long idCrear;
    
    private String nombre_usuario;
    private String apellid_usuario;
    private String correo_electronico;
    private String contraseña;

    
    public Crear(){
    }
    
    
    public Crear(long idCrear, String nombre_usuario, String apellid_usuario, String correo_electronico, String contraseña) {
        this.idCrear = idCrear;
        this.nombre_usuario = nombre_usuario;
        this.apellid_usuario = apellid_usuario;
        this.correo_electronico = correo_electronico;
        this.contraseña = contraseña;
    }

    
    
}
