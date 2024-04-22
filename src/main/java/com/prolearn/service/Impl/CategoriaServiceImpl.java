
package com.prolearn.service.Impl;

import com.prolearn.dao.CategoriaDao;
import com.prolearn.domain.Categoria;
import com.prolearn.service.CategoriaService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CategoriaServiceImpl implements CategoriaService{
    
    @Autowired
    private CategoriaDao categoriaDao;

    @Override
    @Transactional(readOnly = true)
    public List<Categoria> getCategorias() {
        return categoriaDao.findAll();
    }

    @Override
    @Transactional(readOnly = true)
    public Categoria getCategoria(Long id) {
        return categoriaDao.findById(id).orElse(null);
    }

    @Override
    @Transactional()
    public void save(Categoria categoria) {
        categoriaDao.save(categoria);
    }

    @Override
    @Transactional()
    public void delete(Long id) {
        categoriaDao.deleteById(id);
    }
    
}
