
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;
import lombok.Data;


@Data
@Entity
@Table(name = "FIDE_CURSOS_TB")
public class Curso implements Serializable {
    
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CURSOS_TB_ID_CUR_PK")
    private Long idCurso;
    
    
    
    @Column(name = "nombre_curso")
    private String nombreCurso;
    
    @Column(name = "descrp_curso")
    private String descrpCurso;
    
    @Column(name = "estado_curso")
    private boolean estadoCurso;
    
    @Column(name = "thumbnail_curso")
    private String thumbnailCurso;
    
    @ManyToOne
    @JoinColumn(name = "categoria_curso")
    private Categoria categoriaCurso;
    
    
    @ManyToMany(fetch = FetchType.EAGER,cascade = CascadeType.ALL)
    @JoinTable(
            name = "FIDE_CAPITULO_X_CURSO_TB",
            joinColumns = @JoinColumn(name = "id_curso"),
            inverseJoinColumns = @JoinColumn(name = "id_capitulo")
    )
    private List<CapituloHijo> capitulosHijos;
    

    public Curso() {
    }

    public Curso(String nombreCurso, String descrpCurso, boolean estadoCurso, String thumbnailCurso, Categoria categoriaCurso, List<CapituloHijo> capitulosHijos) {
        this.nombreCurso = nombreCurso;
        this.descrpCurso = descrpCurso;
        this.estadoCurso = estadoCurso;
        this.thumbnailCurso = thumbnailCurso;
        this.categoriaCurso = categoriaCurso;
        this.capitulosHijos = capitulosHijos;
    }

    public Curso(Long idCurso, String nombreCurso, String descrpCurso, boolean estadoCurso, String thumbnailCurso, Categoria categoriaCurso, List<CapituloHijo> capitulosHijos) {
        this.idCurso = idCurso;
        this.nombreCurso = nombreCurso;
        this.descrpCurso = descrpCurso;
        this.estadoCurso = estadoCurso;
        this.thumbnailCurso = thumbnailCurso;
        this.categoriaCurso = categoriaCurso;
        this.capitulosHijos = capitulosHijos;
    }
    
    
    
}
