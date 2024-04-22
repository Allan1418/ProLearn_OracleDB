
package com.prolearn.domain;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import lombok.Data;


@Data
public class CapitulosEstruc {
    
    private CapituloPadre capituloPadre;
    private List<CapituloHijo> capitulosHijos;

    public CapitulosEstruc(CapituloPadre capituloPadre, List<CapituloHijo> capitulosHijos) {
        this.capituloPadre = capituloPadre;
        this.capitulosHijos = capitulosHijos;
    }

    public CapitulosEstruc() {
    }
    
    
    public static List<CapituloPadre> getListaCapituloPadre(Curso curso) {
        List<CapituloPadre> listaCapituloPadre = new ArrayList<>();
        for (CapituloHijo hijo : curso.getCapitulosHijos()) {
            if (!listaCapituloPadre.contains(hijo.getCapituloPadre())) {
                listaCapituloPadre.add(hijo.getCapituloPadre());
            }
        }
        // Sort ListaCapituloPadre by numero
        listaCapituloPadre.sort(Comparator.comparingInt(CapituloPadre::getNumero));
        return listaCapituloPadre;
    }
}
