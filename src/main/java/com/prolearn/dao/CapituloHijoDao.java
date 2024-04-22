
package com.prolearn.dao;

import com.prolearn.domain.CapituloHijo;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;


public interface CapituloHijoDao extends JpaRepository<CapituloHijo, Long> {
    
    CapituloHijo findByIdAndCapituloPadreId(Long id, Long capituloPadreId);
    
    List<CapituloHijo> findAllByCapituloPadreId(Long capituloPadreId);
    
}
