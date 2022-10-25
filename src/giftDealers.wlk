import personas.*
import regalos.*

object giftDealer {
	var regalosPosibles = [scalextric, yo_yo, balero]
	const personasConocidas = [stefan, justina, pedro]
	const historicoRegalos = []
	const criteriosSeleccionRegalo = ["el más barato", "al azar", "el primero que no le gusta"]
	var actualCriterioSeleccionRegalo = "el más barato"
	
	method conocerPersona(nuevaPersona) {
		personasConocidas.add(nuevaPersona)
	}
	
	//Para Testing
	method cambiarRegalosPosibles(regalos) {
		regalosPosibles = regalos
	}
	
	method agregarRegalo(nuevoRegalo) {
		regalosPosibles.add(nuevoRegalo)
	}
	
	method quitarRegalo(regalo) {
		regalosPosibles.remove(regalo)
	}
	
	method cambiarCriterioSeleccionRegalo(criterio) {
		if (!criteriosSeleccionRegalo.contains(criterio)) throw new Exception(message = "El criterio de selección no es válido")
		actualCriterioSeleccionRegalo = criterio
	}
	
	method verActualCriterioSeleccionRegalo() = actualCriterioSeleccionRegalo

	method quienesSonInconformistas() = (personasConocidas.filter { persona => regalosPosibles.all { regalo => !persona.eligeRegalo(regalo) } })
	
	method asignarRegalo(persona) {
		const regaloAsignado = if (actualCriterioSeleccionRegalo == "al azar") {
			self.obtenerUnRegaloAlAzar(persona)
		}
		else if (actualCriterioSeleccionRegalo == "el primero que no le gusta") { 
			self.obtenerElPrimerRegaloDeLosQueNoLeGustan(persona)
		}
		else {
			self.obtenerElRegaloMasBarato(persona)
		}
		self.registrarHistorico(persona, regaloAsignado, new Date())
		return regaloAsignado
	}

	method obtenerElRegaloMasBarato(persona) {
		var regalos = (regalosPosibles.filter { regalo => persona.eligeRegalo(regalo) }).sortedBy({ regalo1, regalo2 => regalo1.cuantoCuesta() < regalo2.cuantoCuesta() })
		if (regalos.isEmpty()) { regalos = [voucher] }
		return regalos.first()
	}
	
	method obtenerUnRegaloAlAzar(persona) = regalosPosibles.anyOne()
	
	method obtenerElPrimerRegaloDeLosQueNoLeGustan(persona) {
		var regalos = (regalosPosibles.filter { regalo => !persona.eligeRegalo(regalo) })
		if (regalos.isEmpty()) { regalos = [voucher] }
		return regalos.first()
	}	

	method forzarRegalo(persona, regalo) {
		self.registrarHistorico(persona, regalo, new Date())
	}
	
	method registrarHistorico(_persona, _regalo, _fecha) {
		historicoRegalos.add(new RegistroHistoricoRegalos(persona = _persona, regalo = _regalo, costo = _regalo.cuantoCuesta(), fecha = _fecha))
	}
	
	method verHistorico() = historicoRegalos

	//Resolución con SORT	
	method quienRecibioMasPlataEnRegalos() = personasConocidas.sortedBy({ persona1, persona2 => self.plataRecibidaEnRegalosPersona(persona1) > self.plataRecibidaEnRegalosPersona(persona2) }).first()
	//Resolución con FOLD
	//method quienRecibioMasPlataEnRegalos() = personasConocidas.fold(personasConocidas.first(), { persona1, persona2 => self.compararQuienRecibioMasPlata(persona1, persona2) })
	//method compararQuienRecibioMasPlata(persona1, persona2) = (if (self.plataRecibidaEnRegalosPersona(persona2) > self.plataRecibidaEnRegalosPersona(persona1)) { persona2 } else { persona1 })
	
	method plataRecibidaEnRegalosPersona(persona) = (self.verHistoricoPersona(persona)).sum { registro => registro.costo() }
	
	method verHistoricoPersona(persona) = historicoRegalos.filter { registro => registro.persona() == persona }
}

class RegistroHistoricoRegalos {
	var property persona
	var property regalo
	var property costo
	var property fecha
}