class Artista{
    const property estilos //    Un conjunto
    var property groupies = 0
    method esSolista()
    method sumarGroupies(nuevasGroupies){groupies += nuevasGroupies}
    method calidad()
    method conoceEstilo(estiloBuscado) = estilos.contains(estiloBuscado)
    method calidadPorEstilos() = estilos.size() * 5
    method estaPegado() = groupies > 20000
}

class Musico inherits Artista{
    var instrumento
    method instrumento() = instrumento
    method estilosEnComun(banda) = self.estilos().any({estilo => banda.conoceEstilo(estilo)})
    override method esSolista() = true
    override method calidad() = self.calidadPorEstilos() + self.calidadPorInstrumento()
    method calidadPorInstrumento() = instrumento.puntajeCalidad(self)
}

class Instrumento{
    const puntajeBase
    method puntajeCalidad(musico) = puntajeBase + self.puntajeCalidadExtra(musico)
    method puntajeCalidadExtra(musico)
}

class GuitarraCriolla inherits Instrumento(puntajeBase = 10){
    var cuerdasSanas
    override method puntajeCalidadExtra(musico) = cuerdasSanas 
}

class GuitarraElectrica inherits Instrumento(puntajeBase = 15){
    var amplificador
    override method puntajeCalidadExtra(musico) = amplificador.potencia()
}

 class InstrumentoDeEstilo inherits Instrumento{
    const estilo
    const extraPorEstilo
    method puntajeExtraPorEstilo(musico){
        if(musico.conoceEstilo(estilo)){
            return extraPorEstilo
        }
        return 0
    }
}

class Bajo inherits InstrumentoDeEstilo(puntajeBase = 5, estilo = "metal", extraPorEstilo = 2){
    const color
    method puntajeExtraPorColor(){
        if(color == "rojo"){
            return 5
        }
        return 0
    }
    override method puntajeCalidadExtra(musico) = self.puntajeExtraPorEstilo(musico) + self.puntajeExtraPorColor()
}

object bateria inherits InstrumentoDeEstilo(puntajeBase = 10, estilo = "rock", extraPorEstilo = 10){
    override method puntajeCalidadExtra(musico) = self.puntajeExtraPorEstilo(musico)
}

object voz inherits Instrumento(puntajeBase = puntosVocalistas.puntajeCalidad()){
    override method puntajeCalidadExtra(musico) = 0
}

object puntosVocalistas{
    method puntajeCalidad() = 16
}


//  Modelado

const taylor = new Musico(
    instrumento = voz,
    estilos = #{"pop", "rock", "country"}
)

const maikel = new Musico(
    instrumento = voz,
    estilos = #{"pop", "soul"}
)

const riorio = new Musico(
    instrumento = new GuitarraElectrica(amplificador = amplificadorMarshal),
    estilos = #{"metal", "heavy metal"}
)

object amplificadorMarshal{ method potencia() = 7}

const hellMusic = new Musico(
    instrumento = voz,
    estilos = #{"metal", "death metal"}
)

const truquillo = new Musico(
    instrumento = new Bajo(color = "rojo"),
    estilos = #{"rock", "metal"}
)

const emiliaViernes = new Musico(
    instrumento = voz,
    estilos = #{"cumbia uruguaya", "pop"}
)

const rengoEstar = new Musico(
    instrumento = bateria,
    estilos = #{"rock", "pop"}
)

