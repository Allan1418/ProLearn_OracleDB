
package com.prolearn.service.Impl;

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
    

    @Override
    @Transactional(readOnly = true)
    public List<Curso> getCursosPublico() {
        var lista = cursoDao.getAllPublico();
        return lista;
    }

    @Override
    @Transactional(readOnly = true)
    public Curso getCurso(Curso curso) {
        return cursoDao.findXId(curso.getIdCurso()).orElse(null);
    }

    @Override
    @Transactional
    public void save(Curso curso) {
        cursoDao.save(curso);
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
