
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;


@Data
@Entity
@Table(name = "FIDE_CURSOS_TB")
@NamedStoredProcedureQuery(
    name = "SPFindXIdCurso",
    procedureName = "CURSO_GET_BYID_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CURSO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOS", type = void.class)
    },
    resultClasses = { Curso.class } 
)
@NamedStoredProcedureQuery(
    name = "SPFindAllPublicoCurso",
    procedureName = "CURSOS_GETALL_PUBLICO_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOR", type = void.class)
    },
    resultClasses = { Curso.class } 
)
@NamedStoredProcedureQuery(
    name = "SPFindAllAdminCurso",
    procedureName = "CURSOS_GETALL_ADMIN_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.REF_CURSOR, name = "P_CURSOR", type = void.class)
    },
    resultClasses = { Curso.class } 
)
@NamedStoredProcedureQuery(
    name = "SPUpsertCU",
    procedureName = "CURSO_UPSERT_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CURSO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_NOMBRE_CURSO", type = String.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_DESCRP_CURSO", type = String.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_THUMBNAIL_CURSO", type = String.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_CATEGORIA_CURSO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ESTADO_PUBLICO", type = Integer.class),
        @StoredProcedureParameter(mode = ParameterMode.OUT, name = "P_ID_RESULTADO", type = Long.class)
    }
)
@NamedStoredProcedureQuery(
    name = "SPDeleteCU",
    procedureName = "CURSO_DELET_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CURSO", type = Long.class),
    }
)
@NamedStoredProcedureQuery(
    name = "SPCrearRelCursoUser",
    procedureName = "INSERTAR_RELACION_USUARIO_CURSO_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_CURSO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_USUARIO", type = Long.class)
    }
)
@NamedStoredProcedureQuery(
    name = "SPFindAllXUserCurso",
    procedureName = "OBTENER_CURSOS_USUARIO_SP",
    parameters = {
        @StoredProcedureParameter(mode = ParameterMode.IN, name = "P_ID_USUARIO", type = Long.class),
        @StoredProcedureParameter(mode = ParameterMode.OUT, name = "P_CURSOR_CURSOS", type = void.class)
    },
    resultClasses = { Curso.class } 
)
public class Curso implements Serializable {
    
    private static final long serialVersionUID = 1L;

    @Id
    //@GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CURSOS_TB_ID_CUR_PK")
    private Long idCurso;
    
    
    
    @Column(name = "nombre_curso")
    private String nombreCurso;
    
    @Column(name = "descrp_curso")
    private String descrpCurso;
    
    @Column(name = "estado_publico")
    private boolean estadoCurso;
    
    @Column(name = "thumbnail_curso")
    private String thumbnailCurso;
    
    @Transient
    private Categoria categoriaCurso;
    
    @Column(name = "CATEGORIA_CURSO")
    private Long categoriaId;
    
    

    public Curso() {
    }

    public Curso(String nombreCurso, String descrpCurso, boolean estadoCurso, String thumbnailCurso, Long categoriaId) {
        this.nombreCurso = nombreCurso;
        this.descrpCurso = descrpCurso;
        this.estadoCurso = estadoCurso;
        this.thumbnailCurso = thumbnailCurso;
        this.categoriaId = categoriaId;
    }

    public Curso(Long idCurso, String nombreCurso, String descrpCurso, boolean estadoCurso, String thumbnailCurso, Long categoriaId) {
        this.idCurso = idCurso;
        this.nombreCurso = nombreCurso;
        this.descrpCurso = descrpCurso;
        this.estadoCurso = estadoCurso;
        this.thumbnailCurso = thumbnailCurso;
        this.categoriaId = categoriaId;
    }
    
    
    public int getEstadoInt(){
        return (this.estadoCurso) ? 1 : 0;
    }
    
    
}
