package com.prolearn.dao;

import com.prolearn.domain.Factura;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface FacturaDao extends JpaRepository<Factura, Long> {
   
    @Procedure(name = "FACTURA_GET_BYID_SP")
    Optional<Factura> findById(@Param("P_ID_FACTURA") Long id);

    @Procedure(name = "FACTURA_GETALL_BY_CURSO_SP")
    List<Factura> findAllByCursoId(@Param("P_ID_CURSO") Long idCurso);

    @Procedure(name = "FACTURA_UPSERT_SP")
    void upsert(@Param("P_ID_FACTURA") Long idFactura, 
                @Param("P_USUARIO_ID") Long usuarioId, 
                @Param("P_MONTO_ID") Long montoId);

    @Procedure(name = "FACTURA_DELETE_SP")
    void delete(@Param("P_ID_FACTURA") Long idFactura);

    public List<Factura> getFacturasByUsuarioId(Long usuarioId);
}

