
package com.prolearn.dao;

import com.prolearn.domain.CapituloHijo;
import com.prolearn.domain.CapituloPadre;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;


public interface CapituloPadreDao extends JpaRepository<CapituloPadre, Long> {
    
    @Procedure(name = "SPFindXIdCP")
    Optional<CapituloPadre> findXId(@Param("P_ID_CAPITULO_PADRE") Long id);
    
    
    @Procedure(name = "SPFindAllXIdCursoCP")
    List<CapituloPadre> findAllXCursoID(@Param("P_ID_CURSO")Long idCurso);
    
    @Procedure(name = "SPUpsertCP")
    void upsert(@Param("P_ID_CAPITULO_PADRE")Long idPadre, 
                @Param("P_NOMBRE_CAPITULO_PADRE")String nombre, 
                @Param("P_NUMERO_CAPITULO_PADRE")int numero, 
                @Param("P_ID_CURSO")Long idCurso);
    
    @Procedure(name = "SPDeleteCP")
    void delete(@Param("P_ID_CAPITULO_PADRE")Long idPadre);
}
