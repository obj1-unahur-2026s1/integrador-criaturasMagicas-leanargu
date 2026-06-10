//CRIATURAS
class Criatura{
  var rolEnElParque
  var poderMagico

  method poderMagico() = poderMagico
  method astucia() = 0
  method rolEnElParque() = rolEnElParque
  method esFormidable() = self.esAstuta() or self.esExtraordinaria()
  
  method esAstuta()
  method esExtraordinaria() = rolEnElParque.esExtraordinaria(self)

  method poderOfensivo() = (poderMagico * 10) + rolEnElParque.poderExtra()

  method perderPoderMagico(){
    poderMagico = poderMagico * 0.85
  }
  method ritual(){
    rolEnElParque = rolEnElParque.hacerRitualDeCambioDeRol()
  }

}
class Duende inherits Criatura{
  override method poderOfensivo() = super() * 1.1
  override method esAstuta() = false
}
class Hada inherits Criatura{
  var kilometrosQuePuedeVolar = 2
  var astucia

  override method esAstuta() = astucia > 50
  method kilometrosQuePuedeVolar() = kilometrosQuePuedeVolar

  method aumentarKilometraje(kilometros){
    kilometrosQuePuedeVolar = (kilometrosQuePuedeVolar + kilometros).min(25)
  }
  method cambiarAstucia(nuevaAstucia){ astucia = nuevaAstucia }
  
  override method esExtraordinaria() = super() and kilometrosQuePuedeVolar > 10
}

//ROLES
class Domador{
  const mascotas = []

  method entrenar(mascota){
    mascotas.add(mascota)
  }
  method poderExtra() = 150 * self.cantidadDeMascotasConCuernos()

  method cantidadDeMascotasConCuernos() = mascotas.count({mascota => mascota.tieneCuernos()})
  method esExtraordinaria(unaCriatura){
    return self.tienePoderMagicoExtraordinario(unaCriatura) and self.todasLasMascotasSonVeteranas()
  }
  method tienePoderMagicoExtraordinario(unaCriatura) = unaCriatura.poderMagico() >= 15
  method todasLasMascotasSonVeteranas() = mascotas.all({mascota => mascota.esVeterana()})
  method hacerRitualDeCambioDeRol(){
    if(!self.cantidadDeMascotasConCuernos() > 0)
      self.error("No se puede hacer el ritual, no hay mascotas con cuernos")
    return hechicero
  }
}
object hechicero{
  method poderExtra() = 0
  method esExtraordinaria(unaCriatura) = true
  method hacerRitualDeCambioDeRol() = guardián
}
object guardián{
  method poderExtra() = 100
  method esExtraordinaria(unaCriatura) = unaCriatura.poderMagico() > 50
  method hacerRitualDeCambioDeRol() = new Domador(
    mascotas=[new Mascota(edad=1, tieneCuernos=true)]
    )
}

//EXTRA
//Mascota pertenece al domador
class Mascota{
  const edad
  const tieneCuernos

  method esVeterana() = edad >= 10
  method tieneCuernos() = tieneCuernos
}

class Colonia{
  const criaturas = []
  method criaturas() = criaturas
  method poderOfensivo() = criaturas.sum({criatura => criatura.poderOfensivo()})

  method agregarCriatura(criatura){ criaturas.add(criatura) }

  method atacarA(unArea){
    if(self.poderOfensivo() > unArea.poderDefensivo()){
      unArea.esUsurpada(self)
    } else {
      criaturas.forEach({criatura => criatura.perderPorcentajePoderMagico()})
    }
  }
  
}

class Area{
  const colonia

  method poderDefensivo()
  method criaturasFormidables() = colonia.criaturas().count({criatura => criatura.esFormidable()})
  
}

class Castillo inherits Area{
  override method poderDefensivo() = 200 * self.criaturasFormidables()
}

class Claro inherits Area{
  override method poderDefensivo() = 100 + colonia.poderOfensivo()
}
