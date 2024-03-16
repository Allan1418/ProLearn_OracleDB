
package com.prolearn.service;

import com.prolearn.domain.Curso;
import java.util.List;


public interface CursoService {
    
    // Se obtiene un listado de cursos en un List
    public List<Curso> getCursos();
    
   // Se obtiene un Curso, a partir del id de un curso
    public Curso getCurso(Curso curso);
    
    // Se inserta un nuevo curso si el id del curso esta vacío
    // Se actualiza un curso si el id del curso NO esta vacío
    public void save(Curso curso);
    
    // Se elimina el curso que tiene el id pasado por parámetro
    public void delete(Curso curso);
}