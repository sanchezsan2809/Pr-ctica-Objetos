import musicosEInstrumentos.*
import bandas.*

class Recital{
    const duracion  //  en minutos
    const artista
    const artistaInvitado
    const cantidadGente

    method iniciarRecital(){
        var nuevasGroupies = artista.calidad() / 100 * cantidadGente
        if(duracion < 60){
            nuevasGroupies -= nuevasGroupies * 0.03
        } 

        artista.sumarGroupies(nuevasGroupies)
        if(!artista.esSolista()){
            artista.mejorIntegrante().sumarGroupies(nuevasGroupies / 2)
        }
    }

}