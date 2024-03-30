
package com.prolearn.service;

import com.prolearn.domain.Usuario;
//import java.util.List;

public interface UsuarioService {
    
    //no se agrega getUsuarios
    
    public Usuario getUsuario(Usuario usuario);
    
    public void save(Usuario usuario);
    
    public void delete(Usuario usuario);
    
    Usuario findByCorreoAndContra(String correoUsuario, String contraUsuario);
}
