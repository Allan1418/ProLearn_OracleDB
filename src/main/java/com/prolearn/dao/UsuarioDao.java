
package com.prolearn.dao;

import com.prolearn.domain.Usuario;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface UsuarioDao extends JpaRepository<Usuario, Long>{
    
    @Procedure(name = "SPFindXEmailUser")
    Optional<Usuario> findByEmail(@Param("P_EMAIL") String email);
    
    @Procedure(name = "USUARIO_FINDALL_SP")
    List<Usuario> getAll();
    
    @Procedure(name = "SPFindByIdUser")
    Optional<Usuario> getXId(@Param("P_ID_USER") Long idUser);
    
    @Procedure(name = "SPUpsertUser")
    Long upsert(
            @Param("P_ID_USUARIO") Long idUsuario,
            @Param("P_NOMBRE") String nombre,
            @Param("P_APELLIDOS") String apellidos,
            @Param("P_EMAIL") String email,
            @Param("P_PASSWORD") String password,
            @Param("P_ROL_ID") Long rolId
    );
    
}
