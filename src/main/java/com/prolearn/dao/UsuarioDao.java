
package com.prolearn.dao;

import com.prolearn.domain.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UsuarioDao extends JpaRepository<Usuario, Long>{
    
    Usuario findByEmail(String email);
    
}
