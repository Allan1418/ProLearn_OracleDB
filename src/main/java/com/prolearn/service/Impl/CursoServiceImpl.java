
package com.prolearn.service.Impl;

import com.prolearn.dao.CategoriaDao;
import com.prolearn.dao.CursoDao;
import com.prolearn.domain.Curso;
import com.prolearn.service.CursoService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CursoServiceImpl implements CursoService{
    
    @Autowired
    private CursoDao cursoDao; 
    
    @Autowired
    private CategoriaDao categoriaDao;
    

    @Override
    @Transactional(readOnly = true)
    public List<Curso> getCursosPublico() {
        var lista = cursoDao.getAllPublico();
        return lista;
    }

    @Override
    @Transactional(readOnly = true)
    public Curso getCurso(Curso curso) {
        
        curso = cursoDao.findXId(curso.getIdCurso()).orElse(null);
        curso.setCategoriaCurso(categoriaDao.findByid(curso.getCategoriaId()));
        
        return curso;
    }

    @Override
    @Transactional
    public Long save(Curso curso) {
        Long id = cursoDao.upsert(curso.getIdCurso(),
                curso.getNombreCurso(),
                curso.getDescrpCurso(),
                curso.getThumbnailCurso(),
                curso.getCategoriaId(),
                curso.getEstadoInt());
        
        return id;
    }

    @Override
    @Transactional
    public void delete(Curso curso) {
        cursoDao.delete(curso);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Curso> getCursosAdmin() {
        var lista = cursoDao.getAllAdmin();
        return lista;
    }
    
    
    
    
}
