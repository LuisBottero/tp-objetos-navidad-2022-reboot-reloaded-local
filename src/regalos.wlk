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
	
	method esInteresante() = (marca.size().even() && self.esValioso())
}

object yo_yo {
	var color = "azul"
	const precioBase = 5000
	const adicionalColor = 1500
	const coloresCaros = ["azul", "rojo"]
	const coloresValiosos = ["azul", "amarillo"]
	var property marca = "rusell"
	const colorNoInteresante = "rojo"
	
	method colorActual() = color

	method elegirColor(nuevoColor) {
		color = nuevoColor
	}

	method esValioso() = coloresValiosos.contains(color)
	
	method cuantoCuesta() = (precioBase + (if (coloresCaros.contains(color)) adicionalColor else 0))
	
	method esInteresante() = (marca.size().even() && color != colorNoInteresante)
}

object balero {
	const precioBase = 14100
	const adicionalAdornoMetalico = 1900
	var tieneAdornoMetalico = false
	var property marca = "balerino"
	const precioInteresante = 15000
	
	method tieneAdornoMetalico() = tieneAdornoMetalico

	method agregarAdornoMetalico() {
		tieneAdornoMetalico = true
	}
	
	method quitarAdornoMetalico() {
		tieneAdornoMetalico = false
	}
	
	method esValioso() = tieneAdornoMetalico
	
	method cuantoCuesta() = (precioBase + (if (tieneAdornoMetalico) adicionalAdornoMetalico else 0))
	
	method esInteresante() = (marca.size().even() && self.cuantoCuesta() > precioInteresante)
}

class Ropa {
	var property marca
	var property fechaConfeccion
	var property valorBase
	
	const marcasConAdicional = ["Jordache", "Feraldy", "Charro"]
	const adicionalMarca = 5000
	const fechaLiquidacion = new Date().minusDays(90)
	const descuentoLiquidacion = 0.2
	const valorMaximoInteresante = 5000
	
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
	
	method esInteresante() = (marca.size().even() && (self.cuantoCuesta() - valorBase) < valorMaximoInteresante)
}

object voucher {
	const importe = 5000
	var property fechaVencimiento = new Date().plusMonths(3)
	var property marca = "boxbig"
	
	method esValido(fecha) = fechaVencimiento > fecha
	
	method esValioso() = true
	
	method cuantoCuesta() = importe
	
	method esInteresante() = (marca.size().even() && self.esValido(new Date()))
}