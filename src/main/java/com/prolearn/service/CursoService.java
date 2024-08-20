
package com.prolearn.service;

import com.prolearn.domain.Curso;
import java.util.List;

public interface CursoService {
    
    public List<Curso> getCursosPublico();
    
    public List<Curso> getCursosAdmin();

    public Curso getCurso(Curso curso);
    
    public Long save(Curso curso);
    
    public void delete(Curso curso);
    
}
