
package com.prolearn.dao;

import com.prolearn.domain.Rol;
import org.springframework.data.jpa.repository.JpaRepository;


public interface RolDao extends JpaRepository<Rol, Long>{
    
    Rol findByNombre(String nombre);
    
}
