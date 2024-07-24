
package com.prolearn.dao;

import com.prolearn.domain.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface CategoriaDao extends JpaRepository<Categoria, Long> {
    
    @Procedure(name = "findByIdCat")
    public Categoria findByid(@Param( "P_ID_CATEGORIA" )Long id);
    
}
