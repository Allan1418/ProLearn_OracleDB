
package com.prolearn.domain;

import jakarta.persistence.*;
import java.io.Serializable;
import lombok.Data;

@Data
@Entity
@Table(name="Cursos")
public class Curso implements Serializable{
    
    private static final long serialVersionUID =1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_curso")
    private long idCurso;
    
    private String nombre_curso;
    private String descrp_curso;
    private String ruta_imagen;
    
    public Curso(){
    }

    public Curso(long idCurso, String nombre_curso, String descrp_curso, String ruta_imagen) {
        this.idCurso = idCurso;
        this.nombre_curso = nombre_curso;
        this.descrp_curso = descrp_curso;
        this.ruta_imagen = ruta_imagen;
    }

    
}
