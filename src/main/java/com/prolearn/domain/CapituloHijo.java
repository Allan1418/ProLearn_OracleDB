
package com.prolearn.domain;

import com.prolearn.dao.CapituloPadreDao;
import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;


@Data
@Entity
@Table(name = "FIDE_CAPITULO_HIJO_TB")
@NamedStoredProcedureQuery(
    name = "SPFindXIdCH",
    procedureName = "CH_FINDBYID_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CAPITULO_HIJO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_RESULTADO", type = void.class)
    },
    resultClasses = { CapituloHijo.class } 
)
public class CapituloHijo implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CAPITULO_HIJO_TB_ID_CH_PK")
    private Long id;

    @Column(name = "NOMBRE_CAPITULO_HIJO")
    private String nombre;
    
    @Column(name = "video_capitulo")
    private String video;

    @Column(name = "NUMERO_CAPITULO_HIJO")
    private int numero;
    
    @Transient
    private CapituloPadre capituloPadre;
    
    @Column(name = "ID_CAPITULO_PADRE")
    private Long capituloPadreId;
    
    public CapituloHijo() {
    }

    public CapituloHijo(String nombre, String video, int numero, Long capituloPadreId) {
        this.nombre = nombre;
        this.video = video;
        this.numero = numero;
        this.capituloPadreId = capituloPadreId;
    }

    public CapituloHijo(Long id, String nombre, String video, int numero, Long capituloPadreId) {
        this.id = id;
        this.nombre = nombre;
        this.video = video;
        this.numero = numero;
        this.capituloPadreId = capituloPadreId;
    }
    
    
    
}
