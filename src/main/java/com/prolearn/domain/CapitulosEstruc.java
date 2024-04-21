
package com.prolearn.domain;

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
    
    
    
}
