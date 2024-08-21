package com.prolearn.dao;

import com.prolearn.domain.Factura;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.query.Procedure;
import org.springframework.data.repository.query.Param;

public interface FacturaDao extends JpaRepository<Factura, Long> {
   
    @Procedure(name = "SPFindXIdFT")
    Optional<Factura> findXId(@Param("P_ID_FACTURA") Long id);

    @Procedure(name = "SPFindAllFT")
    List<Factura> findAll();

    @Procedure(name = "SPUpsertFT")
    void upsert(@Param("P_ID_FACTURA") Long idFactura, 
                @Param("P_MONTO_ID") Long montoId, 
                @Param("P_USUARIO_ID") Long usuarioId);
                

    @Procedure(name = "FACTURA_DELETE_SP")
    void delete(@Param("P_ID_FACTURA") Long idFactura);

}

