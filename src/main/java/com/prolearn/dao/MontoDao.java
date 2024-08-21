package com.prolearn.dao;

import com.prolearn.domain.Monto;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface MontoDao extends JpaRepository<Monto, Long> {

    @Procedure(name = "MONTO_GET_BYID_SP")
    Optional<Monto> findById(@Param("P_ID_MONTO") Long id);

    @Procedure(name = "MONTO_GETALL_BY_TIPO_SUSCRIPCION_SP")
    List<Monto> findAllByTipoSuscripcion(@Param("P_TIPO_SUSCRIPCION") String tipoSuscripcion);

    @Procedure(name = "MONTO_UPSERT_SP")
    void upsert(@Param("P_ID_MONTO") Long idMonto,
            @Param("P_TIPO_SUSCRIPCION") String tipoSuscripcion);

    @Procedure(name = "MONTO_DELETE_SP")
    void delete(@Param("P_ID_MONTO") Long idMonto);
}
