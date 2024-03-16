
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

@Data
@Entity
@Table(name="Contrasenas")
public class Solicitud implements Serializable{
    
    private static final long serialVersionUID =1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_solicitud")
    private long idSolicitud;
    
    private String correo_electronico;

    
    public Solicitud(){
    }

    public Solicitud(long idSolicitud, String correo_electronico) {
        this.idSolicitud = idSolicitud;
        this.correo_electronico = correo_electronico;
    }

    
    
}
