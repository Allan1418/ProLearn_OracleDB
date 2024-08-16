package com.prolearn.dao;

import com.prolearn.domain.Monto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MontoDao extends JpaRepository<Monto, Long> {
   
}