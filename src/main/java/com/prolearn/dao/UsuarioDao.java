
package com.prolearn.dao;

import com.prolearn.domain.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface UsuarioDao extends JpaRepository<Usuario, Long>{
    
    @Procedure(name = "SPFindXEmailUser")
    Usuario findByEmail(@Param("P_EMAIL") String email);
    
}
