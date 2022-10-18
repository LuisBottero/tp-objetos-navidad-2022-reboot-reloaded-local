import personas.*
import regalos.*

// Nuestro personaje conoce a Pedro, Justina y Stefan, y a futuro quizás a más personas. Le
// interesa saber cuáles son los inconformistas, que son las personas a las que no les gusta
// ningún regalo.
object giftDealer {
	const regalosPosibles = [scalextric, yo_yo, balero]
	const personasConocidas = [stefan, justina, pedro]
	const historicoRegalos = []
	
	method conocerPersona(nuevaPersona) {
		personasConocidas.add(nuevaPersona)
	}
	
	method agregarRegalo(nuevoRegalo) {
		regalosPosibles.add(nuevoRegalo)
	}
	
	method quitarRegalo(regalo) {
		regalosPosibles.remove(regalo)
	}

	method quienesSonInconformistas() = (personasConocidas.filter { persona => regalosPosibles.all { regalo => !persona.eligeRegalo(regalo) } })
	
	// se selecciona el regalo más barato que le gusta a la persona, en caso de que ningún
	// regalo le guste debe generarse un nuevo tipo de regalo: un Voucher por $ 5.000 con
	// fecha de vencimiento a 3 meses de la ejecución del proceso. Un Voucher siempre se
	// considera valioso. Debe modelar esta nueva abstracción como crea conveniente. No
	// hay inconveniente en que un regalo se entregue a dos personas distintas, el manejo
	// de stock de regalos está fuera del alcance.
	method asignarRegalo(persona) {
		const regaloAsignado = self.obtenerRegaloAsignado(persona) 
		self.registrarHistorico(persona, regaloAsignado, new Date())
		return regaloAsignado
	}

	method obtenerRegaloAsignado(persona) {
		var regalos = (regalosPosibles.filter { regalo => persona.eligeRegalo(regalo) }).sortedBy({ regalo1, regalo2 => regalo1.cuantoCuesta() < regalo2.cuantoCuesta() })
		if (regalos.isEmpty()) { regalos = [voucher] }
		return regalos.first()
	}

	method asignarRegalo(persona, regalo, fecha) {
		self.registrarHistorico(persona, regalo, fecha)
	}
	
	// se debe registrar entonces el histórico, donde aparezca: la persona, el regalo y la
	// fecha en la que se hizo la operación. Dado que el costo de un regalo puede variar con
	// el tiempo, necesitamo guardar también el costo en el momento en que se ejecutó el proceso.
	method registrarHistorico(_persona, _regalo, _fecha) {
		historicoRegalos.add(new RegistroHistoricoRegalos(persona = _persona, regalo = _regalo, costo = _regalo.cuantoCuesta(), fecha = _fecha))
	}
	
	method verHistorico() = historicoRegalos
	
	// Queremos poder determinar cuál fue la persona que recibió más plata en regalos. Tener en
	// cuenta que a lo largo de la historia puede haber más de un registro en el histórico de regalos
	// recibidos. Dado este ejemplo:
	// ● Pedro recibió $ 5.000 en regalos el 15/12/2017
	// ● Stefan recibió $ 15.000 en regalos el 20/12/2017
	// ● Pedro recibió $ 13.000 en regalos el 16/12/2018
	// ● Stefan recibió $ 2.000 en regalos el 18/12/2018
	// Debe indicar que Pedro es la persona que más plata en regalos recibió ($ 18.000 vs. $ 17.000
	// de Stefan).
	method quienRecibioMasPlataEnRegalos() = personasConocidas.sortedBy({ persona1, persona2 => self.plataRecibidaEnRegalosPersona(persona1) > self.plataRecibidaEnRegalosPersona(persona2) }).first()
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