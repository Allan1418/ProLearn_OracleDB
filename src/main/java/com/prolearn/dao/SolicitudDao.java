package com.prolearn.dao;

import com.prolearn.domain.Solicitud;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SolicitudDao extends JpaRepository<Solicitud, Long> {

}
