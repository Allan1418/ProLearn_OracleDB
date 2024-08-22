
package com.prolearn.dao;

import com.prolearn.domain.Categoria;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface CategoriaDao extends JpaRepository<Categoria, Long> {
    
    @Procedure(name = "findByIdCat")
    public Categoria findByid(@Param( "P_ID_CATEGORIA" )Long id);
    
    @Procedure(name = "findAllCat")
    public List<Categoria> getAllCat();
    
    @Procedure(name = "SPUpsertCat")
    public void upsert(@Param( "P_ID_CATEGORIA" )Long id, @Param( "P_NOMBRE_CATEGORIA" )String nombre);
    
    @Procedure(name = "SPDeleteCat")
    public void delete(@Param( "P_ID_CATEGORIA" )Long id);
    
}
