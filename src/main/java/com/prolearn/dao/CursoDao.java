
package com.prolearn.dao;

import com.prolearn.domain.Curso;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface CursoDao extends JpaRepository<Curso, Long>{
    
    @Procedure(name = "SPFindXIdCurso")
    Optional<Curso> findXId(@Param("P_ID_CURSO") Long id);
    
    @Procedure(name = "SPFindAllPublicoCurso")
    List<Curso> getAllPublico();
    
    @Procedure(name = "SPFindAllAdminCurso")
    List<Curso> getAllAdmin();
    
    @Procedure(name = "SPUpsertCU")
    Long upsert(
            @Param("P_ID_CURSO") Long idCurso,
            @Param("P_NOMBRE_CURSO") String nombre,
            @Param("P_DESCRP_CURSO") String descrp,
            @Param("P_THUMBNAIL_CURSO") String thumbnailCurso,
            @Param("P_CATEGORIA_CURSO") Long idCategoria,
            @Param("P_ESTADO_PUBLICO") int estadoPublico
    );
    
    @Procedure(name = "SPDeleteCU")
    void delete(@Param("P_ID_CURSO")Long idCurso);
    
    @Procedure(name = "SPCrearRelCursoUser")
    void crearRelUserCurso(@Param("P_ID_CURSO")Long idCurso, @Param("P_ID_USUARIO") Long idUser);
    
    @Procedure(name = "SPFindAllXUserCurso")
    List<Curso> getAllXUser(@Param("P_ID_USUARIO") Long idUser);
}
