
package com.prolearn.dao;

import com.prolearn.domain.CapituloHijo;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;
import org.springframework.data.domain.Example;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.FluentQuery;
import org.springframework.data.repository.query.Param;
import org.springframework.jdbc.core.SqlOutParameter;


public interface CapituloHijoDao extends JpaRepository<CapituloHijo, Long> {
    
    CapituloHijo findByIdAndCapituloPadreId(Long id, Long capituloPadreId);
    
    List<CapituloHijo> findAllByCapituloPadreId(Long capituloPadreId);

    @Procedure(name = "SPFindXIdCH")
    Optional<CapituloHijo> findXId(@Param("P_ID_CAPITULO_HIJO") Long id);
    
    
    @Procedure(name = "SPFindAllXIdCursoYIdCapPadreCH")
    List<CapituloHijo> findAllByCapituloPadreIdYCursoId(@Param("P_ID_CAPITULO_PADRE")Long capituloPadreId, @Param("P_ID_CURSO")Long cursoId);
    
    @Procedure(name = "SPUpsertCH")
    Long upsert(@Param("P_ID_HIJO")Long idHijo, 
                @Param("P_ID_CAPITULO_PADRE")Long idPadre, 
                @Param("P_NOMBRE_CAPITULO")String nombre, 
                @Param("P_NUMERO_CAPITULO")int numero, 
                @Param("P_VIDEO_CAPITULO")String video, 
                @Param("P_ID_CURSO")Long idCurso);
    
    @Procedure(name = "SPDeleteCH")
    void delete(@Param("P_ID_HIJO")Long idHijo);
    
}
