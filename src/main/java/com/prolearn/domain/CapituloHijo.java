
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;


@Data
@Entity
@Table(name = "FIDE_CAPITULO_HIJO_TB")
public class CapituloHijo implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CAPITULO_HIJO_TB_ID_CH_PK")
    private Long id;

    @Column(name = "nombre_capitulo")
    private String nombre;
    
    @Column(name = "video_capitulo")
    private String video;

    @Column(name = "numero_capitulo")
    private int numero;
    
    @ManyToOne(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
    @JoinColumn(name = "id_capitulo_padre")
    private CapituloPadre capituloPadre;
    

    public CapituloHijo() {
    }

    public CapituloHijo(String nombre, String video, int numero, CapituloPadre capituloPadre) {
        this.nombre = nombre;
        this.video = video;
        this.numero = numero;
        this.capituloPadre = capituloPadre;
    }

    public CapituloHijo(Long id, String nombre, String video, int numero, CapituloPadre capituloPadre) {
        this.id = id;
        this.nombre = nombre;
        this.video = video;
        this.numero = numero;
        this.capituloPadre = capituloPadre;
    }
    
    
    
}
