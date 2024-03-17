
package com.prolearn.service;

import com.prolearn.domain.Curso;
import java.util.List;

public interface CursoService {
    
    public List<Curso> getCursos(boolean activo);

    public Curso getCurso(Curso curso);
    
    public void save(Curso curso);
    
    public void delete(Curso curso);
    
}
