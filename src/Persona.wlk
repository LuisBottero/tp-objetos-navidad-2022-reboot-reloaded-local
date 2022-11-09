import Vacuna.*


class Persona {
	var property anticuerpos = 1  // De forma para no multiplicar por 0
	var property edad
	var property nombre
	var property vacunasAplicadas = []
	var property fechaInmunidad = new Date(day = 01, month = 01, year = 1900)
	var property fechaUltimaDosis = new Date(day = 01, month = 01, year = 1900)
	var property turno
	const ciudadDondeVive
	const ciudadesParticulares = ["Tierra del Fuego", "Santa Cruz", "Neuquén"]

	var property criterioEleccionVacuna =  cualquierosas
	
	

	method recibirDosis(vacuna) { 
		self.registraAplicacionDosis(vacuna)
		self.generaProteccion(vacuna) 
	}
	
	method generaProteccion(vacuna) { 
		self.anticuerpos(vacuna.anticuerpos(self))
		self.fechaInmunidad(vacuna.inmunidad(self))
	}	
	
	method registraAplicacionDosis(vacuna) { 
		self.fechaUltimaDosis(new Date())
		self.vacunasAplicadas().add(vacuna)
	}
	
	method nombrePar() = self.nombre().length().even()
	
	method esMayorDe(anios) = anios > self.edad()
	
	method personaEspeciale() = ciudadesParticulares.contains(ciudadDondeVive)
	
	method aceptaVacuna(vacuna) = criterioEleccionVacuna.aceptaVacuna(self,vacuna)


	
} 



object cualquierosas  {
	
	method aceptaVacuna(persona,vacuna) = true

}

object anticuerposas  {
	const anticuerposDeseados = 100000
	method aceptaVacuna(persona,vacuna) = vacuna.anticuerpos(persona) > anticuerposDeseados

}

object inmunidosasFijas  {
	const fechaLimiteInmunidad = new Date(day = 05 , month = 03, year = 2022)
	method aceptaVacuna(persona,vacuna) = persona.fechaInmunidad() > fechaLimiteInmunidad

}

object inmunidosasVariables  {
	var property mesesLimiteInmunidad
	method aceptaVacuna(persona,vacuna) = vacuna.inmunidad(persona) < mesesLimiteInmunidad 

}

 

 
