
package com.prolearn.dao;

import com.prolearn.domain.CapituloHijo;
import com.prolearn.domain.CapituloPadre;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;


public interface CapituloPadreDao extends JpaRepository<CapituloPadre, Long> {
    
    @Procedure(name = "SPFindXIdCP")
    Optional<CapituloPadre> findXId(@Param("P_ID_CAPITULO_PADRE") Long id);
    
}
