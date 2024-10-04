import wollok.game.*
import posiciones.*
import cultivos.*
import granja.*
import aspersor.*

object hector {
	var property position = game.center()
	const property image = "player.png"
	var property cosecha = []
	var property oro = 0
	var property aspersores = []

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

	// Cosecha

	method cosechar() {
		granja.cosechar(position)
	}

	// Venta

	method vender() {
		oro = self.oroDeCosecha()
		self.vaciarCosecha()
	}
	
	method oroDeCosecha() {
		return cosecha.sum({planta => planta.precio()})
	}

	method vaciarCosecha() {
		cosecha.clear()
	}

	method cantidadPlantasCosechadas() {
		return cosecha.size()
	}

	method infoCosecha() {
		return game.say(self, "Tengo " + oro + " monedas, y " + self.cantidadPlantasCosechadas() + " plantas para vender")
	}

	// Aspersores

	method agregarAspersor() {
		granja.validarSiHayPlantaParaAspersor(position)
		const aspersor = new Aspersor (position = position)
		game.addVisual(aspersor)
		aspersores.add(aspersor)
	}

	method activarAspersores() {
		aspersores.forEach({aspersor => aspersor.regarEnCadaPosicion()})
	}
}
