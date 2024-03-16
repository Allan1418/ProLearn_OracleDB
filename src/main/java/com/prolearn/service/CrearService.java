
package com.prolearn.service;

import com.prolearn.domain.Crear;
import java.util.List;


public interface CrearService {
    
    // Se obtiene un listado de creados en un List
    public List<Crear> getCreados();
    
   // Se obtiene un Crear, a partir del id de un crear
    public Crear getCrear(Crear crear);
    
    // Se inserta un nuevo crear si el id del crear esta vacío
    // Se actualiza un crear si el id del crear NO esta vacío
    public void save(Crear crear);
    
    // Se elimina el crear que tiene el id pasado por parámetro
    public void delete(Crear crear);
}