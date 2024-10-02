import wollok.game.*
import posiciones.*
import cultivos.*
import granja.*

object hector {
	var property position = game.center()
	const property image = "player.png"

	method mover(direccion) {
		const siguiente = direccion.siguiente(position)
		granja.validarDentro(siguiente)
		position = siguiente
	}

	// Sembrar 

	method sembrarMaiz() {
		granja.validarSiHayAlgoSembrado(position)
		const maiz = new Maiz(position = position)
		granja.sembrar(maiz)
		game.addVisual(maiz) 
	}

	method sembrarTomaco() {
		granja.validarSiHayAlgoSembrado(position)
		const tomaco = new Tomaco (position = position)
		granja.sembrar(tomaco)
		game.addVisual(tomaco)
	}

	method sembrarTrigo() {
		granja.validarSiHayAlgoSembrado(position)
		const trigo = new Trigo (position = position)
		granja.sembrar(trigo)
		game.addVisual(trigo)
	}

	// Regar
	method regar() {
		granja.regar(position)

	} 
}