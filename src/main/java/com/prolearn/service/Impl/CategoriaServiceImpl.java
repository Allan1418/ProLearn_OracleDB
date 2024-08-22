
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
        return categoriaDao.getAllCat();
    }

    @Override
    @Transactional(readOnly = true)
    public Categoria getCategoria(Categoria categoria) {
        return categoriaDao.findById(categoria.getId()).orElse(null);
    }

    @Override
    @Transactional()
    public void save(Categoria categoria) {
        categoriaDao.upsert(categoria.getId(), categoria.getNombre());
    }

    @Override
    @Transactional()
    public void delete(Categoria categoria) {
        categoriaDao.delete(categoria.getId());
    }
    
}
