import cultivos.*
import hector.*
import wollok.game.*
import posiciones.*

object granja {

    var property siembra = #{}

    method validarDentro(posicion) {
		return if (not self.estaDentro(posicion)) {
			hector.error("No puedo moverme fuera del tablero")
		}
	}

	method estaDentro(posicion) {
		return posicion.x().between(0, game.width() - 1) and posicion.y().between(0, game.height() - 1)
	}

    method sembrar(planta) {
        siembra.add(planta)
    }

    method validarSiHayAlgoSembrado(posicion) {
        return if (self.hayAlgoSembrado(posicion)) {
            hector.error("Ya hay una planta sembrada en esta posición")
        }
    }

    method validarSiPuedeRegar(posicion) {
        return if (not self.hayAlgoSembrado(posicion)) {
            hector.error("No hay planta para regar en esta posición")
        }
    }

    method hayAlgoSembrado(posicion) {
        return siembra.any({planta => self.esMismaPosicion(planta.position(), posicion)})
    }

    method plantaEn (posicion) {
        return siembra.find({planta => self.esMismaPosicion(planta.position(), posicion)})
    }

    method esMismaPosicion (posicionPlanta, posicion) {
        return posicionPlanta == posicion
    }

    method regar(posicion) {
        self.validarSiPuedeRegar(posicion)
        self.plantaEn(posicion).evolucionar()
    }

// Metodo que utiliza tomaco al evolucionar, osea al ser regado
    method siguientePosicionEnEjeYSiEsPosible(posicion) {
        // Primero valida que este dentro del tablero la siguiente posicion
        return if (not self.estaDentro(self.siguienteEnEjeY(posicion))) {
            posicion // Si no esta dentro, devuelve la posicion dada
        } else if (self.hayAlgoSembrado(self.siguienteEnEjeY(posicion))) {
            // Si en la posicion siguiente de la dada hay una planta, analiza la siguiente de esa
            self.siguientePosicionEnEjeYSiEsPosible(self.siguienteEnEjeY(posicion))
            } else {
                self.siguienteEnEjeY(posicion) // Si no hay nada sembrado, devuelve la posicion siguiente de la dada.
            }
    }

    method siguienteEnEjeY(posicion) {
        return game.at(posicion.x(), (posicion.y() + 1))
    }
}