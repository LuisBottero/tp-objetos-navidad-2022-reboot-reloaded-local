import regalos.*

object stefan {
	var valorMaximo = 6000
	
	method configurarValorRegalo(nuevoValor) {
		valorMaximo = nuevoValor
	}
	
	method eligeRegalo(regalo) = (regalo.esInteresante() && (!regalo.esValioso() && regalo.cuantoCuesta() < valorMaximo))
}

object justina {
	var edad = 11
	const digitosValorDeseado = 4
	
	method cumpleAnios() {
		edad++
	}
	
	method regaloTieneValorDeseado(regalo) = (regalo.cuantoCuesta().toString().length() == digitosValorDeseado)
		
	method quiereRegaloValioso() = edad.odd()

	method eligeRegalo(regalo) = (regalo.esInteresante() && (if (self.quiereRegaloValioso()) { regalo.esValioso() } else { self.regaloTieneValorDeseado(regalo) }))
}

object pedro {
	const amigues = [justina, stefan]
	var mejorAmigue = justina
	
	method cambiarMejorAmigue(nuevoMejorAmigue) {
		if (amigues.contains(nuevoMejorAmigue)) {
			mejorAmigue = nuevoMejorAmigue
		}
	}
	
	method agregarAmigue(amigue) {
		amigues.add(amigue)
	}
	
	method eliminarAmigue(amigue) {
		amigues.remove(amigue)
	}
	
	method eligeRegalo(regalo) = (regalo.esInteresante() && mejorAmigue.eligeRegalo(regalo))
}

object nazarena {
	var numeroRandomForzado = 0
	
	method forzarNumeroRandom(numero) {
		numeroRandomForzado = numero
	}
	
	method limpiarNumeroRandom() {
		numeroRandomForzado = 0
	}

	method eligeRegalo(regalo) = (regalo.esInteresante() && ((if (numeroRandomForzado > 0) { numeroRandomForzado } else { new Range(start = 1, end = 7).anyOne() }) > 4))
}

class Persona {
	var property nombre
	var property fechaNacimiento
	
	const fechaLimite =  new Date(day = 1, month = 1, year = 1990)
	const valorMinimo = 25000
	const valorMaximo = 50000
	
	method eligeRegalo(regalo) = (regalo.esInteresante() && (if (fechaNacimiento < fechaLimite) { regalo.cuantoCuesta() > valorMinimo } else { regalo.cuantoCuesta() < valorMaximo }))
}
