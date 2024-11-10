import musicosEInstrumentos.*

class Banda inherits Artista(estilos = integrantes.fold( integrantes.anyOne().estilos(), {estilosBuscados, estilosIntegrante => estilosIntegrante.estilos().intersection(estilosBuscados)})){
    const integrantes
    method tienenVocalista() = integrantes.any({integrante => integrante.instrumento() == voz})
    override method esSolista() = false

    method sumarIntegrante(nuevoIntegrante){
        self.validarCupo()
        self.validarVocalista(nuevoIntegrante)
        self.validarEstilos(nuevoIntegrante)

        integrantes.add(nuevoIntegrante)
    }

    method validarCupo(){
        if(integrantes.size() == 4){
            throw new Exception(message = "La banda no tiene cupos")
        }
    }

    method validarVocalista(nuevoIntegrante){
        if(nuevoIntegrante.instrumento() == voz and self.tienenVocalista()){
            throw new Exception(message = "La banda ya tiene vocalista")
        }
    }

    method validarEstilos(nuevoIntegrante){
        if(not nuevoIntegrante.estilosEnComun(self)){
            throw new Exception(message = "El integrante no toca estilos en común")
        }
    }

    override method calidad() = self.calidadPorEstilos() + self.mejorIntegrante().calidad() +integrantes.size() * 2
    method mejorIntegrante() = integrantes.max({integrante => integrante.calidad()})
}

const bandaMetalera = new Banda(integrantes = #{truquillo, riorio})
const bandaPopera = new Banda(integrantes = #{taylor, maikel, rengoEstar})