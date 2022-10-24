import personas.*
import regalos.*

object giftDealer2 {
	var regalosPosibles = [scalextric, yo_yo, balero]
	const personasConocidas = [stefan, justina, pedro]
	const historicoRegalos = []
	var actualCriterioSeleccionRegalo = new CriterioElMasBarato(nombre = "elMasBarato", regalos = regalosPosibles, persona = null)
	
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
	
	method verActualCriterioSeleccionRegalo() = actualCriterioSeleccionRegalo
	
	method cambiarCriterioSeleccionRegalo(criterio) {
		actualCriterioSeleccionRegalo = criterio
	}

	method quienesSonInconformistas() = (personasConocidas.filter { persona => regalosPosibles.all { regalo => !persona.eligeRegalo(regalo) } })
	
	method asignarRegalo(persona) {
		const regaloAsignado = if (actualCriterioSeleccionRegalo.nombre() == "alAzar") {
			(new CriterioAlAzar(nombre = "alAzar", regalos = regalosPosibles, persona = persona).obtenerRegalo())
		}
		else if (actualCriterioSeleccionRegalo.nombre() == "elPrimeroQueNoLeGusta") { 
			(new CriterioElPrimeroQueNoLeGusta(nombre = "elPrimeroQueNoLeGusta", regalos = regalosPosibles, persona = persona).obtenerRegalo())
		}
		else {
			(new CriterioElMasBarato(nombre = "elMasBarato", regalos = regalosPosibles, persona = persona).obtenerRegalo())
		}
		
		self.registrarHistorico(persona, regaloAsignado, new Date())
		return regaloAsignado
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


// Opcion 2

class Criterio {
	var property nombre
	var property regalos
	var property persona
	
	method obtenerRegalo()

}

class CriterioAlAzar inherits Criterio {
	
	override method obtenerRegalo() = regalos.anyOne()
	
}

class CriterioElMasBarato inherits Criterio {

	
	override method obtenerRegalo() {
		const regalos = (regalos.filter { regalo => persona.eligeRegalo(regalo) }).sortedBy({ regalo1, regalo2 => regalo1.cuantoCuesta() < regalo2.cuantoCuesta() })//	    if (regaloObtenido == null)  { regaloObtenido = voucher }
		if (regalos.size() == 0) {return voucher} 
		return regalos.first()
	}
		
}

class CriterioElPrimeroQueNoLeGusta inherits Criterio {
	
	override method obtenerRegalo() {
		const regalos =  (regalos.filter { regalo => !persona.eligeRegalo(regalo) })
		if (regalos.size() == 0) {return voucher} 
		return regalos.first()
	}
		
}



	


