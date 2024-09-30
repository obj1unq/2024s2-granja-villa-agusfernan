import wollok.game.*
import posiciones.*

object hector {
	var property position = game.center()
	const property image = "player.png"

	method mover(direccion) {
	  position = direccion.siguiente(self.position())
	}
	method sembrar(especie) {
		especie.position(self.position().x(), self.position().y())
	}
}