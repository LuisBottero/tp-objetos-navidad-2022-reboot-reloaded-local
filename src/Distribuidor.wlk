import Persona.*
import Regalo.*

object giftDealer {
	const personas = [pedro,justina,stefan]
	const regalos = []
	
	method personas() {
		return personas
	}

	method agregarPersonas(_persona) {
		personas.add(_persona)
	}
	
	method regalos() {
		return regalos
	}

	method agregarRegalo(_regalo) {
		regalos.add(_regalo)
	}
	
	method inconformistas() {
		return self.personas().filter( { persona => persona.inconformista(self.regalos()) } )
	}
}
