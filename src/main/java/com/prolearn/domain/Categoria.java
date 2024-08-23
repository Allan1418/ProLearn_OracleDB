
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;


@Data
@Entity
@Table(name = "FIDE_CATEGORIAS_TB")
@NamedStoredProcedureQuery(
    name = "findByIdCat",
    procedureName = "CATEGORIA_GET_BYID_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CATEGORIA", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CATEGORIA", type = void.class)
    },
    resultClasses = Categoria.class 
)
@NamedStoredProcedureQuery(
    name = "findAllCat",
    procedureName = "CATEGORIA_GETALL_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOR", type = void.class)
    },
    resultClasses = Categoria.class 
)
@NamedStoredProcedureQuery(
    name = "SPUpsertCat",
    procedureName = "CATEGORIA_UPSERT_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CATEGORIA", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_NOMBRE_CATEGORIA", type = String.class)
    }
)
@NamedStoredProcedureQuery(
    name = "SPDeleteCat",
    procedureName = "CATEGORIA_DELET_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CATEGORIA", type = Long.class),
    }
)
public class Categoria implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CATEGORIAS_TB_ID_CAT_PK")
    private Long id;

    @Column(name = "nombre_categoria")
    private String nombre;

    
    
    public Categoria(String nombre) {
        this.nombre = nombre;
    }

    public Categoria(Long id, String nombre) {
        this.id = id;
        this.nombre = nombre;
    }

    public Categoria() {
    }
    
    
    
    
}
