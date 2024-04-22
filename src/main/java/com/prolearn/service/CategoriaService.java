package com.prolearn.service;

import com.prolearn.domain.Categoria;
import java.util.List;

public interface CategoriaService {


    public List<Categoria> getCategorias();

    public Categoria getCategoria(Long id);

    public void save(Categoria categoria);

    public void delete(Long id);
}
