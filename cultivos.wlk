import hector.*
import wollok.game.*
import granja.*

class Maiz {
	var property position = null
	var property estado = 0
	
	method image() {
		return if (estado == 0) {
			"corn_baby.png"
		} else {
			"corn_adult.png"
		}
	}

	method evolucionar() {
		self.validarEvolucion()
		estado = 1
	}

	method validarEvolucion() {
		return if (self.esAdulta()) {
			hector.error("La planta no puede evolucionar, ya es adulta")
		}
	}

	method esAdulta() {
		return estado == 1
	}

	method sePuedeCosechar() {
		return self.esAdulta()
	}

	method precio() {
		return 150
	}

}

class Trigo {
	var property position = null
	var property estado = 0
	
	method image() {
		return "wheat_" + estado + ".png"
	}

	method evolucionar() {
		return if (estado == 0) {
			estado = 1
		} else if (estado == 1) {
			estado = 2
		} else if (estado == 2) {
			estado = 3
		} else {
			estado = 0
		}
	}

	method validarEvolucion() {
	 	// ESTA POR POLIMORFISMO, PORQUE EL TRIGO SIEMPRE EVOLUCIONA NO ES NECESARIO VALIDAR
	}

	method esAdulta() {
		// ESTA POR POLIMORFISMO, NO SE USA
	}

	method sePuedeCosechar() {
		return estado >= 2
	}

	method precio() {
		return (estado - 1) * 100
	}
}

class Tomaco {
	var property position = null
	var property estado = 0
	
	method image() {
		return if (estado == 0) {
			"tomaco_baby.png"
		} else {
			"tomaco.png"
		}
	}
	method evolucionar() {
		self.validarEvolucion()
		position = granja.siguientePosicionEnEjeYSiEsPosible(position)
		estado = 1
	}

	method validarEvolucion() {
		return if (self.esAdulta()) {
			hector.error("La planta no puede evolucionar, ya es adulta")
		}
	}

	method esAdulta() {
		return estado == 1
	}

	method sePuedeCosechar() {
		return estado >= 0 // Para que pueda cosecharlo siempre
	}

	method precio() {
		return 80
	}
}