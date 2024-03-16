package com.prolearn.dao;

import com.prolearn.domain.Curso;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CursoDao extends JpaRepository<Curso, Long> {

}
