
package com.prolearn.dao;

import com.prolearn.domain.Curso;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface CursoDao extends JpaRepository<Curso, Long>{
    
    @Procedure(name = "SPFindXIdCurso")
    Optional<Curso> findXId(@Param("P_ID_CURSO") Long id);
    
}
