class Empleado{
    const habilidades //    Un conjunto
    var salud
    const subordinados //   Un conjunto
    const misionesCompletadas

    method saludCritica()
    method incapacitado() = salud < self.saludCritica()
    method puedeUsarHabilidad(habilidad) = (!self.incapacitado() and habilidades.contains(habilidad)) or (subordinados.any({subordinado => subordinado.puedeUsarHabilidad(habilidad)}))
    method completarMisionIndividual(mision){
        self.validarHabilidadesMision(mision)
        salud -= mision.peligrosidad()
        self.validarSobrevivencia(mision)
    }
    method completarMisionGrupal(mision){
        salud -= mision.peligrosidad() / 3
        self.validarSobrevivencia(mision)
    }
    method tieneHabilidadesMision(mision) = mision.habilidadesRequeridas().forEach({habilidad => self.puedeUsarHabilidad(habilidad)})
    method validarHabilidadesMision(mision){
        if(!self.tieneHabilidadesMision(mision)){
            throw new Exception(message = "No tiene las habilidades para completar la misión")
        }
    } 
    method validarSobrevivencia(mision){
        if (salud > 0){
            misionesCompletadas.add(mision)
        }
    }
}

class Equipo{
    const integrantes
    method completarMisionGrupal(mision) {
        self.validarHabilidadesMision(mision)
        integrantes.forEach({integrante => integrante.completarMisionGrupal(mision)})
    }
    method validarHabilidadesMision(mision){
        if(!integrantes.any({integrante => integrante.tieneHabilidadesMision(mision)})){
            throw new Exception(message = "No se puede completar la misión por falta de habilidades")
        }
    } 

}

class Espia inherits Empleado{
    override method saludCritica() = 15
    method aprenderHabilidad(habilidad) = habilidades.add(habilidad)
    method aprenderHabilidadesMision(mision) = mision.habilidadesRequeridas().forEach({habilidad => self.aprenderHabilidad(habilidad)})

    override method validarSobrevivencia(mision){
        super(mision)
        if(salud > 0){
            self.aprenderHabilidadesMision(mision)
        }
    }
}

class Oficinista inherits Empleado{
    var estrellas
    override method saludCritica() = 40 - 5 * estrellas
    override method validarSobrevivencia(mision){
        super(mision)
        if(salud > 0){
            estrellas += 1
        }
    }
    method puedeSerEspia() = estrellas == 3
}


class Mision{
    const property habilidadesRequeridas
    const property peligrosidad
}