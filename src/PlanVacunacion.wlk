import Vacuna.*
import Persona.*

object planVacunacion {
	const mensajeNoVacunado = "La vacuna solicitada no es aplicable para la persona: "
	var property personas = []
	var property vacunas = []
	
	method costoDelPlanInicialDeVacunacion() = (personas.map {persona => self.vacunasQueElijeUnaPersona(persona).costo(persona)}).sum()
	
	method vacunasQueElijeUnaPersona(persona) = ((vacunas.filter { vacuna => persona.aceptaVacuna(vacuna) }).sortedBy{ vacuna1, vacuna2 => vacuna1.costo(persona) < vacuna2.costo(persona) } ).first()
	
	method vacunar(persona,vacuna) { if (persona.aceptaVacuna(vacuna)) persona.recibirDosis(vacuna) else persona.error(mensajeNoVacunado).concat(persona.nombre()) }
	 
}

