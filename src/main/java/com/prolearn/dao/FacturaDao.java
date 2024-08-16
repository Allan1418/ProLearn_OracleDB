

package com.prolearn.dao;

import com.prolearn.domain.Factura;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FacturaDao extends JpaRepository<Factura, Long> {
    // Aquí puedes añadir métodos personalizados si es necesario
}

