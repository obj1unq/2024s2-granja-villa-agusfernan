import hector.*
import granja.*
import wollok.game.*

class Aspersor {
    var property position = null
    const posicionesARegar = [game.at(position.x() + 1, position.y()), game.at(position.x() - 1, position.y()), game.at(position.x(), position.y() + 1), game.at(position.x(), position.y() - 1)]
    // posicionesARegar tiene las posiciones limitrofes en las que tiene que regar el aspersor
    
    method image() {
        return "aspersor.png"
    }

    method regarEnCadaPosicion() {
        posicionesARegar.forEach({posicion => self.regarPlantaEn(posicion)}) // Riega en cada posicion de la lista de posiciones
    }

    method regarPlantaEn(posicion) {
        if (self.puedoRegarEn_(posicion)) {
            granja.plantaEn(posicion).evolucionar() // Hace la accion de regar la planta en esa posicion
        }
    }

    method puedoRegarEn_(posicion) { // Verifico directamente si se puede regar en esa posicion sin usar la validacion ya hecha en granja porque no quiero excepciones
        return granja.hayAlgoSembrado(posicion)
    }
    // Ver porque con el aspersor en el caso del Maiz y del Tomaco no para de tirar la excepcion de que no puede evolucionar
}