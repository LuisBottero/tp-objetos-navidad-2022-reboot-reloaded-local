
const factroInflacionRegalo = 1.0

object scalextric {
	var precio = 27300 * factroInflacionRegalo
	const costoParaSerVarioso = 27500
	const componentes = [auto,auto]
	
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
	
	method costoParaSerVarioso() {
		return costoParaSerVarioso
	}
	
	method precioComponentes() { return componentes.sum( { componente => componente.precio() } ) }

	method esValioso() {
		return self.precioComponentes() + self.precio() > self.costoParaSerVarioso() 
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
