
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;


@Data
@Entity
@Table(name = "FIDE_CAPITULO_PADRE_TB")
@NamedStoredProcedureQuery(
    name = "SPFindXIdCP",
    procedureName = "CP_FINDBYID_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CAPITULO_PADRE", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_RESULTADO", type = void.class)
    },
    resultClasses = { CapituloPadre.class } 
)
@NamedStoredProcedureQuery(
    name = "SPFindAllXIdCursoCP",
    procedureName = "GET_CAP_PADRE_X_CURSO_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CURSO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CAPITULOS_PADRES", type = void.class)
    },
    resultClasses = { CapituloPadre.class } 
)
public class CapituloPadre implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CAPITULO_PADRE_TB_ID_CP_PK")
    private Long id;

    @Column(name = "NOMBRE_CAPITULO_PADRE")
    private String nombre;

    @Column(name = "NUMERO_CAPITULO_PADRE")
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
