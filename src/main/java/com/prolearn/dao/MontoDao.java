package com.prolearn.dao;

import com.prolearn.domain.Monto;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface MontoDao extends JpaRepository<Monto, Long> {

    @Procedure(name = "SPFindXIdMT")
    Optional<Monto> findById(@Param("P_ID_MONTO") Long id);

    @Procedure(name = "SPFindAllPublico")
    List<Monto> findAllPublico();
    
    @Procedure(name = "SPFindAllAdmin")
    List<Monto> findAllAdmin();

    @Procedure(name = "SPUpsertMT")
    void upsert(@Param("P_ID_MONTO") Long idMonto,
            @Param("P_NOMBRE") String nombrre,
            @Param("P_DESCUENTO") int descuento,
            @Param("P_MONTO_SIN_DESCUENTO") Double montoSinDescuento,
            @Param("P_ESTADO_PUBLICO") boolean estado);

    @Procedure(name = "SPDeleteMT")
    void delete(@Param("P_ID_MONTO") Long idMonto);
}
