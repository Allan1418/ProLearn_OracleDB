
package com.prolearn.service;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;
import com.prolearn.domain.Usuario;

public interface UsuarioService extends UserDetailsService{
    
    public void save(Usuario usuario);
    
    public void nuevo(Usuario usuario);
    
    public List<Usuario> getUsuarios();
    
    public Usuario getUsuario(Usuario usuario);
    
    public Usuario getUsuarioByEmail(String email);
    
    public void delete(Usuario usuario);
    
    
}
