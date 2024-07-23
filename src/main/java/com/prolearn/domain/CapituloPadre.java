
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;


@Data
@Entity
@Table(name = "FIDE_CAPITULO_PADRE_TB")
public class CapituloPadre implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CAPITULO_PADRE_TB_ID_CP_PK")
    private Long id;

    @Column(name = "nombre_capitulo")
    private String nombre;

    @Column(name = "numero_capitulo")
    private int numero;
    
    
    public CapituloPadre() {
    }

    public CapituloPadre(String nombre, int numero) {
        this.nombre = nombre;
        this.numero = numero;
    }

    public CapituloPadre(Long id, String nombre, int numero) {
        this.id = id;
        this.nombre = nombre;
        this.numero = numero;
    }
    
    
    
    
}
