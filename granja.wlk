import cultivos.*
import hector.*
import wollok.game.*
import posiciones.*
import mercado.*

object granja {
    var property mercados = #{}
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

    method validarSiPuedePlantar(posicion) {
        return if (self.hayAlgoSembrado(posicion)) {
            hector.error("Ya hay una planta sembrada en esta posición")
        } else if (self.hayMercadoEn(posicion)) {
            hector.error("No puedo plantar en esta posición, hay un mercado")
        }
    }

    method validarSiPuedeRegar(posicion) {
        return if (not self.hayAlgoSembrado(posicion)) {
            hector.error("No hay planta para regar en esta posición")
        }
    }

    method validarSiPuedeCosechar(posicion) {
        return if (not self.hayAlgoSembrado(posicion)) {
            hector.error("No hay planta para cosechar en esta posición")
        }
    }

    method validarSiPuedePonerAspersor(posicion) { // Hace lo mismo que validarSiHaySembrado y validarSiEstaEnMercado pero quiero otro mensaje!
        return if ( self.hayAlgoSembrado(posicion)) {
            hector.error("No puedo colocar el aspersor en esta posición, hay una planta")
        } else if (self.hayMercadoEn(posicion)) {
            hector.error("No puedo colocar el aspersor en esta posición, hay un mercado")
        }
    }

    method validarSiEstaEnMercado(posicion) {
        return if (not self.hayMercadoEn(posicion)) {
            hector.error("No puedo vender ya que no estoy en un Mercado")
        }  
    }

    method validarSiPuedeVenderEn(posicion, valor) {
        return if (not self.mercadoEn(posicion).tieneSuficienteOro(valor)) {
            hector.error ("El mercado no tiene suficiente oro para comprar mi cosecha")
        }
    }

    method mercadoEn(posicion) {
        return mercados.find({mercado => self.esMismaPosicion(mercado.position(), posicion)})
    }

    method hayAlgoSembrado(posicion) {
        return siembra.any({planta => self.esMismaPosicion(planta.position(), posicion)})
    }

    method plantaEn (posicion) {
        return siembra.find({planta => self.esMismaPosicion(planta.position(), posicion)})
    }

    method esMismaPosicion (posicionObjeto, posicion) {
        return posicionObjeto == posicion
    }

    method hayMercadoEn(posicion) {
        return mercados.any({mercado => self.esMismaPosicion(mercado.position(), posicion)})
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
            // Si en la posicion siguiente de la dada hay una planta, se queda en el lugar (esto lo evalua por la condicion de no poder tener 2 plantas en el mismo lugar)
            posicion
            } else {
                self.siguienteEnEjeY(posicion) // Si no hay nada sembrado, devuelve la posicion siguiente de la dada.
            }
    }

    method siguienteEnEjeY(posicion) {
        return game.at(posicion.x(), (posicion.y() + 1))
    }

    method cosechar(posicion) {
        self.validarSiPuedeCosechar(posicion)
        self.validarSiEstaListaParaCosechar(posicion)
        hector.cosecha().add(self.plantaEn(posicion)) // Agrega la planta a la lista de cosechas de Hector
        game.removeVisual(self.plantaEn(posicion)) // Remueve la visual del juego de la planta que esta en la posicion, que es la cosechada
        siembra.remove(self.plantaEn(posicion)) // La borra de la lista de siembra de la granja, por lo que me volvera a permitir sembrar en la posicion.
    }

    method validarSiEstaListaParaCosechar(posicion) {
        return if (not self.plantaEn(posicion).sePuedeCosechar()) {
            hector.error("La planta no esta lista para ser cosechada")
        }
    }
    
    method agregarMercados() {
        const mercado1 = new Mercado (position = game.at(9, 9), monedas = 10000)
        const mercado2 = new Mercado (position = game.at(0, 9), monedas = 2500)
        mercados.add(mercado1)
        mercados.add(mercado2)
        game.addVisual(mercado2)
        game.addVisual(mercado1)

    }

    method mercadoCompra(posicion) {
        return self.mercadoEn(posicion).agregarMercaderia()
    }

}