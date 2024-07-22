
package com.prolearn.dao;

import com.prolearn.domain.CapituloHijo;
import java.util.List;
import java.util.function.Function;
import org.springframework.data.domain.Example;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.FluentQuery;
import org.springframework.data.repository.query.Param;


public interface CapituloHijoDao extends JpaRepository<CapituloHijo, Long> {
    
    CapituloHijo findByIdAndCapituloPadreId(Long id, Long capituloPadreId);
    
    List<CapituloHijo> findAllByCapituloPadreId(Long capituloPadreId);

    @Override
    @Procedure(name = "PROLEARN.CH_FINDBYID_SP")
    public <S extends CapituloHijo, R> R findBy(@Param("P_ID_CAPITULO_HIJO") Example<S> example, Function<FluentQuery.FetchableFluentQuery<S>, R> queryFunction);
    
    
    
}
