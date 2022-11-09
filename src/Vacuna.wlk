import Persona.*


class Vacuna {
	
	const limiteEdadCosto = 30
	const costoInicial = 1000
	const incrementoPorAnio = 50

	method anticuerpos(persona)
	
	method inmunidad(persona) 

	method costo(persona) = if (persona.esMayorDe(limiteEdadCosto)) costoInicial else costoInicial + (persona.edad() * incrementoPorAnio) + self.costoExtra(persona)
	
	method costoExtra(persona)
	
}

class Paifer inherits Vacuna {
	const factorAnticuerpos = 10
	const edadLimiteInmunidad = 40
	const edadLimiteCosto = 18
	const costoExtraMayorAEdadLimiteCosto = 100
	const costoExtraMenorAEdadLimiteCosto = 400

	override method anticuerpos(persona) = persona.anticuerpos() * factorAnticuerpos 
	
	override method inmunidad(persona) {
		const inmunidad = new Date()
		return if (persona.edad() > edadLimiteInmunidad) inmunidad.plusMonths(6) else inmunidad.plusMonths(9)
	}
	
	override method costoExtra(persona) = if (persona.esMayorDe(edadLimiteCosto)) costoExtraMenorAEdadLimiteCosto else costoExtraMayorAEdadLimiteCosto 
	
}

class Larussa inherits Vacuna {
	
	var property compuestos = []
	const factorAnticuerpos = 20
	const costoExtra = 100
	
	override method anticuerpos(persona) = self.procesarAnticuerpos(persona)
	
	override method inmunidad(persona) = new Date(day = 03, month = 03, year = 2022)
	
	method transformaFactoresDeCompuestosEnAnticuerpos(persona) = (self.compuestos().map { compuesto => compuesto * persona.anticuerpos()}).sum()
	
	method transformaFactoresDeCompuestosEnCostoExtra() = (self.compuestos().map { compuesto => compuesto * costoExtra}).sum()
	
	method procesarAnticuerpos(persona) {
		const limiteDeInticuerpos = persona.anticuerpos() + factorAnticuerpos
		const anticuerposGenerados = self.transformaFactoresDeCompuestosEnAnticuerpos(persona)
		return if (anticuerposGenerados >  limiteDeInticuerpos) limiteDeInticuerpos else anticuerposGenerados
	}
	
	override method costoExtra(persona) = self.transformaFactoresDeCompuestosEnCostoExtra()

}

class AstraLaVistaZeneca inherits Vacuna  {
	
	const anticuerpos = 10000
	const costoExtra = 2000	
	
	override method anticuerpos(persona) = anticuerpos
	
	override method inmunidad(persona) {
		const inmunidad = new Date()
		return if (persona.nombrePar()) inmunidad.plusMonths(6) else inmunidad.plusMonths(7)
	}
	
	override method costoExtra(persona) = if (persona.personaEspeciale()) costoExtra else 0

}


class Combineta inherits Vacuna  {
	
	var property vacunas = []
	const costoExtra = 100	
	
	override method anticuerpos(persona) = vacunas.min( { vacuna => vacuna.anticuerpos(persona) } )
	
	override method inmunidad(persona)= vacunas.max( { vacuna => vacuna.inmunidad(persona) } )

	override method costoExtra(persona) = vacunas.sum{ vacuna => vacuna.costo(persona) } + (costoExtra * vacunas.length())

}