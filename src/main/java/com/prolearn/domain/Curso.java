
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;


@Data
@Entity
@Table(name = "cursos")
public class Curso implements Serializable {
    
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_curso")
    private Long idCurso;
    
    
    
    @Column(name = "nombre_curso")
    private String nombreCurso;
    
    @Column(name = "descrp_curso")
    private String descrpCurso;
    
    @Column(name = "estado_curso")
    private boolean estadoCurso;
    
    @Column(name = "thumbnail_curso")
    private String thumbnailCurso;
    
    //cambiar a llave foranea
    @Column(name = "categoria_curso")
    private String categoria_curso;
    
    //referencia a futuro para llaves foraneas
    //-------
    //@OneToMany
    //@JoinColumn(name = "id_categoria", updatable = false)
    //List<Producto> productos;

    public Curso() {
    }
    
    
    public Curso(Long idCurso, String nombreCurso, String descrpCurso, boolean estadoCurso, String thumbnailCurso, String categoria_curso) {
        this.idCurso = idCurso;
        this.nombreCurso = nombreCurso;
        this.descrpCurso = descrpCurso;
        this.estadoCurso = estadoCurso;
        this.thumbnailCurso = thumbnailCurso;
        this.categoria_curso = categoria_curso;
    }
    
    
    
}
