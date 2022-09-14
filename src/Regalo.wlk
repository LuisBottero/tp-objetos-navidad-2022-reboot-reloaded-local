
const factroInflacionRegalo = 1.0

object scalextric {
	var precio = 27300 * factroInflacionRegalo
	const costoParaSerValioso = 27500
	const componentes = []
	
	method precio() { return precio }
	
	method precio(_precio) { precio = _precio }
	
	method agregarComponente(componente) {
		componentes.add(componente)
	}
	
	method componentes() {
		return componentes
	}
	
	method quitarComponente(componente) {
		componentes.remove(componente)
	}
	
	method costoParaSerValioso() {
		return costoParaSerValioso
	}
	
	method precioComponentes() { return componentes.sum( { componente => componente.precio() } ) }

	method esValioso() {
		return self.precioComponentes() + self.precio() > self.costoParaSerValioso() 
	}
	
}

object auto {
	var precio = 5250

	method precio() { return precio }
	
	method precio(_precio) { precio = _precio }

	method esValioso() {
		return true 
	}
}


object yoYoRussell {
	var color = "Azul"
	const precioBase = 5000
	
	method precioBase() { return precioBase }
	
	method precio() { return self.precioBase() + self.precioDiferencial() }
	
	method precioDiferencial() {return if (self.color() == "Rojo" || self.color() == "Azul") 1500 else 0}
	
	method color() { return color }
	
	method color(_color) { color = _color }
	
	method pintar(_color) {color = _color}
	
	method esValioso() {
		return self.color() == "Azul" || self.color() == "Amarillo"
	}
}


object balero {
	var adorno = false
	const precioBase = 14100
		
	method tieneAdorno() {return adorno}
	
	method agregarAdorno() {adorno = true}

	method quitarAdorno() {adorno = false}
	
	method precioBase() { return precioBase }
	
	method precioDiferencial() {return if (self.tieneAdorno()) 1900 else 0}
	
	method precio() { return self.precioBase() + self.precioDiferencial() }

	method esValioso() {
		return self.tieneAdorno()
	}
	
	
}

