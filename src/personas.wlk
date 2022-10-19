import regalos.*

// Stefan es desprendido y busca que el regalo no sea valioso pero que
// además cueste menos de un valor que él quiere configurar (por ejemplo $ 6.000).
object stefan {
	var valorMaximo = 6000
	
	method configurarValorRegalo(nuevoValor) {
		valorMaximo = nuevoValor
	}
	
	method eligeRegalo(regalo) = (!regalo.esValioso() && regalo.cuantoCuesta() < valorMaximo && regalo.esInteresante())
}

// Justina tiene 11 años. La edad es importante porque si es impar define
// que le gustan los regalos valiosos, en caso contrario cualquier regalo que cueste un
// valor que tenga 4 dígitos (por ejemplo un yo-yo que cueste $ 5.000 ó $ 6.500, el
// Scalextric base de $ 27.300 no le gustaría).
object justina {
	var edad = 11
	
	method cumpleAnios() {
		edad++
	}
	
	method regaloTieneValorDeseado(regalo) = (regalo.cuantoCuesta().toString().length() == 4)
		
	method quiereRegaloValioso() = edad.odd()

	method eligeRegalo(regalo) = regalo.esInteresante() && (if (self.quiereRegaloValioso()) { regalo.esValioso() } else { self.regaloTieneValorDeseado(regalo) })
}

// Tenemos a Pedro, que tiene amistades como a Justina y a Stefan. A la
// hora de elegir regalos elige el mismo regalo que su mejor amigo (en este caso,
// Justina es la mejor amiga, deben poder modificar la persona que es mejor amiga).
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
	
	method eligeRegalo(regalo) = mejorAmigue.eligeRegalo(regalo) && regalo.esInteresante()
}

// Queremos modelar a Nazarena que le puede gustar o no un regalo en base a un
// número al azar de 1 a 7: si el número es mayor a 4 le gustará, en caso contrario
// no le gustará. Sí, el regalo no importa.
object nazarena {
	var numeroRandomForzado = 0
	
	method forzarNumeroRandom(numero) {
		numeroRandomForzado = numero
	}
	
	method limpiarNumeroRandom() {
		numeroRandomForzado = 0
	}

	method eligeRegalo(regalo) = regalo.esInteresante() && ((if (numeroRandomForzado > 0) { numeroRandomForzado } else { new Range(start = 1, end = 7).anyOne() }) > 4)
}

// Queremos modelar a una persona genérica, que tiene las siguientes características:
// ● conocen su nombre y la fecha de nacimiento
// ● a una persona nacida antes de los ‘90 le gusta que el regalo cueste más de $ 25.000 o menos de $ 50.000 en caso contrario.
class Persona {
	var property nombre
	var property fechaNacimiento
	
	const fechaLimite =  new Date(day = 1, month = 1, year = 1990)
	const valorMinimo = 25000
	const valorMaximo = 50000
	
	method eligeRegalo(regalo) = regalo.esInteresante() && (if (fechaNacimiento < fechaLimite) { regalo.cuantoCuesta() > valorMinimo } else { regalo.cuantoCuesta() < valorMaximo })
}
