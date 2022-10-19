// Una pista de Scalextric, que sale 27.300 pesos por ahora (se ajusta con la inflación).
// Viene con 2 autos. Se le puede agregar autos extra y cada uno tiene un costo adicional de 5.250 pesos.
// Este regalo es valioso si el costo total excede los 27.500 pesos (considerando los autos extra).

//Prueba SSH
object scalextric {
	const precioBase = 27300
	const precioLimiteValioso = 27500
	const adicionalAuto = 5250
	var autosAdicionales = 0
	var property marca = "scalextric"
	
	method agregarAuto() {
		autosAdicionales += 1
	}
	
	method quitarAuto() {
		if (autosAdicionales > 0) {
			autosAdicionales -= 1
		}
	}
	
	method esValioso() = (self.cuantoCuesta() > precioLimiteValioso)
	
	method cuantoCuesta() = (precioBase + (autosAdicionales * adicionalAuto))
	
	method marcaConCantidadLetrasPar() = marca.length().even()	
	
	method esInteresante() = self.marcaConCantidadLetrasPar() && self.esValioso()
	
}

// Un Yo-Yo Russell, de color azul, aunque se puede pintar de otros colores.
// El Yo-Yo de color azul o amarillo es valioso.
// El costo de un yo-yo es de $ 5.000, al que se le suman $ 1.500 si es rojo o azul.
object yo_yo {
	var color = "azul"
	const precioBase = 5000
	const adicionalColor = 1500
	const coloresCaros = ["azul", "rojo"]
	const coloresValiosos = ["azul", "amarillo"]
	var property marca = "rusell"
	const colorInteresnte = "rojo"

	method colorActual() = color

	method elegirColor(nuevoColor) {
		color = nuevoColor
	}

	method esValioso() = coloresValiosos.contains(color)
	
	method cuantoCuesta() = (precioBase + (if (coloresCaros.contains(color)) adicionalColor else 0))
	
	method marcaConCantidadLetrasPar() = marca.length().even()
	
	method esInteresante() = self.marcaConCantidadLetrasPar() && (self.colorActual() != colorInteresnte)
	
}

// Un balero de madera al que le podemos agregar o quitar un adorno metálico (solo uno).
// Los baleros con adornos son valiosos.
// El costo de un balero es de $ 14.100, al que se le suman $ 1.900 si tiene adorno metálico.
object balero {
	const precioBase = 14100
	const adicionalAdornoMetalico = 1900
	var tieneAdornoMetalico = false
	var property marca = "balerino"	
	const valorInteresnte = 1500	
	
	method tieneAdornoMetalico() = tieneAdornoMetalico

	method agregarAdornoMetalico() {
		tieneAdornoMetalico = true
	}
	
	method quitarAdornoMetalico() {
		tieneAdornoMetalico = false
	}
	
	method esValioso() = tieneAdornoMetalico
	
	method cuantoCuesta() = (precioBase + (if (tieneAdornoMetalico) adicionalAdornoMetalico else 0))
	
	method marcaConCantidadLetrasPar() = marca.length().even()
	
	method esInteresante() = self.marcaConCantidadLetrasPar() && (self.cuantoCuesta() > valorInteresnte)	
		
}

// Nos interesa modelar la ropa (zapatillas, jeans, remeras, vestidos, etc.) como regalo que tiene
// el siguiente comportamiento
// ● tienen una marca
// ● una fecha de confección
// ● un valor base
// Al valor base le agregan $ 5.000 si la marca es “Jordache”, “Feraldy” o “Charro” (pueden
// agregarse nuevas marcas a futuro). Luego, si la fecha de confección tiene más de 90 días, se
// le descuenta el 20% como “liquidación”
class Ropa {
	var property marca
	var property fechaConfeccion
	var property valorBase
	
	const marcasConAdicional = ["Jordache", "Feraldy", "Charro"]
	const adicionalMarca = 5000
	const fechaLiquidacion = new Date().minusDays(90)
	const descuentoLiquidacion = 0.2
	const valorInteresnte = 5000	
	
	method agregarMarcaConAdicional(_marca) {
		marcasConAdicional.add(_marca)
	}
	
	method esValioso() = true //Para que funcione el polimorfismo de todos los regalos
	
	method cuantoCuesta() {
		var precio = valorBase
		if (marcasConAdicional.contains(marca)) precio += adicionalMarca
		if (fechaConfeccion < fechaLiquidacion) precio *= (1 - descuentoLiquidacion)
		return precio
	}
	method marcaConCantidadLetrasPar() = marca.length().even()
	
	method esInteresante() = self.marcaConCantidadLetrasPar() && (self.cuantoCuesta() - valorBase) < valorInteresnte 
	
	
}

object voucher {
	const importe = 5000
	const fechaVencimiento = new Date().plusMonths(3)
	var property marca = "boxbig"	
	
	method esValido(fecha) = fechaVencimiento > fecha // Ojo limite creo que es Valido para >=
	
	method esValioso() = true
	
	method cuantoCuesta() = importe

	method marcaConCantidadLetrasPar() = marca.length().even()
	
	method estaVencido() = new Date() - fechaVencimiento > 0
	
	method esInteresante() = self.marcaConCantidadLetrasPar() && !self.estaVencido()
		
}