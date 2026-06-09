class Criatura{
  method poderMagico() = 0
  method astucia() = 0
  method rolEnElParque() = rolEnElParque
  //poderOfensivo() = (poderMagico() * 10) + rol.poderExtra()
  var rolEnElParque

  method cambiarRol(rol){
    rolEnElParque = rol
  }
}

//duende
  //poderOfensivo = super(Criatura.poderOfensivo()) + 10%



/*
  Hechicero: No recibe ningún extra.
  Domador: Recibe un extra de 150 unidades por cada mascota mitólogica 
  que tiene cuernos.
*/


class Domador{
  const mascotas = []

  method entrenar(mascota){
    mascotas.add(mascota)
  }
}

class Mascota{
  var edad = 0
  var tieneCuernos = false
}

//Hada
  //kilometrosQuePuedeVolar() var
    //cuando nacen -> 2KM
    //pueden ir aumentando su kilometraje
    //maximo 25

class Hada inherits Criatura{
  method kilometrosQuePuedeVolar() = kilometrosQuePuedeVolar
  var kilometrosQuePuedeVolar = 2

  method aumentarKilometraje(kilometros){
    kilometrosQuePuedeVolar = (kilometrosQuePuedeVolar + kilometros).min(25)
  }
}
