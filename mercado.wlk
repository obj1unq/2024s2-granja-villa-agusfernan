import hector.*
import granja.*
import wollok.game.*

class Mercado {
    const property position = null
    var property monedas = null
    var property mercaderia = #{}
    const property image = "market.png"
  
    method agregarMercaderia() {
        mercaderia.addAll(hector.cosecha())
        monedas -= hector.oroDeCosecha()
    }

    method tieneSuficienteOro(valor) {
        return monedas >= valor
    }
    

}