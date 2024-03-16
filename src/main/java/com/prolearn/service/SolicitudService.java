
package com.prolearn.service;

import com.prolearn.domain.Solicitud;
import java.util.List;


public interface SolicitudService {
    
    // Se obtiene un listado de Solicitudes en un List
    public List<Solicitud> getSolicitudes();
    
   // Se obtiene un Solicitud, a partir del id de un solicitud
    public Solicitud getSolicitud(Solicitud solicitud);
    
    // Se inserta un nuevo solicitud si el id del solicitud esta vacío
    // Se actualiza un solicitud si el id del solicitud NO esta vacío
    public void save(Solicitud solicitud);
    
    // Se elimina el solicitud que tiene el id pasado por parámetro
    public void delete(Solicitud solicitud);
}