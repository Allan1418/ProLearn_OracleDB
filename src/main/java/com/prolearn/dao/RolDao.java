
package com.prolearn.dao;

import com.prolearn.domain.Rol;
import java.util.Collection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;


public interface RolDao extends JpaRepository<Rol, Long>{
    
    Rol findByNombre(String nombre);
    
    @Procedure(name = "SPFindAllXIdUser")
    Collection<Rol> findAllByIdUser(@Param("P_USUARIO_ID")Long idUser);
    
}
