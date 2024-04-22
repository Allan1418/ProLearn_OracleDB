
package com.prolearn.dao;

import com.prolearn.domain.CapituloHijo;
import org.springframework.data.jpa.repository.JpaRepository;


public interface CapituloHijoDao extends JpaRepository<CapituloHijo, Long> {
    
    CapituloHijo findByIdAndCapituloPadreId(Long id, Long capituloPadreId);
    
}
