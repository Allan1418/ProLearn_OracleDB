
package com.prolearn.dao;

import com.prolearn.domain.Rol;
import java.util.Collection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;


public interface RolDao extends JpaRepository<Rol, Long>{
    
    @Procedure(name = "SPFindByNombreRol")
    Rol findByNombre(@Param("P_NOMBRE") String nombre);
    
    @Procedure(name = "SPFindByIdRol")
    Rol getXId(@Param("P_ID_ROL") Long idRol);
    
    
}
