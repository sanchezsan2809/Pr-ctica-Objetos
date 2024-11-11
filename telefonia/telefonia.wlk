class Linea{
    const numTelefono
    const property packs 
    const property consumos

    method consumosEntreFechas(fechaInicial, fechaFinal) = consumos.filter {consumo=> consumo.fecha().between(fechaInicial, fechaFinal)}

    method costoPromedio(fechaInicial, fechaFinal){
        return self.costoTotalConsumos(self.consumosEntreFechas(fechaInicial, fechaFinal)) / self.consumosEntreFechas(fechaInicial, fechaFinal).size()
    }
    method costoTotalConsumos(coleccionConsumos) = coleccionConsumos.sum({consumo => consumo.costo()})    
    method costoUltimosTreintaDias() = self.costoTotalConsumos(self.consumosEntreFechas(new Date(),new Date().minusDays(30)))

    method agregarPack(pack) = packs.add(pack)
}

class Consumo{
    const property fecha
    method costo()
    method esConsumoInternet()
}

class ConsumoInternet inherits Consumo{
    const property cantMegas
    const precios = preciosInternet
    override method costo() = cantMegas * precios.precioPorMega()
    override method esConsumoInternet() = true
}

object preciosInternet{var property precioPorMega = 0.1}


class ConsumoTelefono inherits Consumo{
    const property duracionLlamada
    const precios = preciosLlamadas    
    override method costo(){
        if (duracionLlamada <= 30){
            return precios.precioFijo()
        }else{
            return precios.precioFijo() + self.precioExtra()
        }
    }
    method precioExtra() = (duracionLlamada - 30) * precios.precioPorSegundo()

    override method esConsumoInternet() = false
}

object preciosLlamadas{
    var property precioFijo = 1
    var property precioPorSegundo = 0.05
}

class Pack{
    const beneficio 
    const vencimiento
    method validarVencimiento(consumo) = consumo.fecha() < vencimiento
    method satisface(consumo) = beneficio.satisface(consumo) and self.validarVencimiento(consumo)
}

class CreditoDisponible{
    const credito
    method satisface(consumo) = credito > consumo.costo()
}

class BeneficioInternet{
    method validarConsumoInternet(consumo) = consumo.esConsumoInternet()
}

class BeneficioLlamadas{
    method validarConsumoLlamada(consumo) = !consumo.esConsumoInternet()
}

class MegasLibres inherits BeneficioInternet{
    var megas
    method satisface(consumo) = self.validarConsumoInternet(consumo) and (megas > consumo.cantMegas())
    
}

object llamadasGratis inherits BeneficioLlamadas{
    method satisface(consumo) = self.validarConsumoLlamada(consumo)
}

object internetIlimitadoFindes inherits BeneficioInternet{
    method satisface(consumo) = self.validarConsumoInternet(consumo)
}