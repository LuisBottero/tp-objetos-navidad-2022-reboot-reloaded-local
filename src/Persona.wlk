object stefan {
	var valorMaximoRegalo = 6000
	
	method valorMaximoRegalo() { return valorMaximoRegalo }

	method valorMaximoRegalo(_valor) { valorMaximoRegalo = _valor}
	
	method esRegaloPreferido(regalo) {
		return regalo.esValioso().negate() and self.valorAceptableDe(regalo)
	}
	
	method valorAceptableDe(regalo) {
		return regalo.precio() < self.valorMaximoRegalo()
	}
	
	method inconformista(regalos) {
		return regalos.all({regalo => self.esRegaloPreferido(regalo).negate()})
	}
	
	
}

object justina {
	var edad = 11
	
	method edad() { return edad }
	
	method edad(_edad) { edad = _edad }
	
	method valorAceptableDe(regalo) {
		return regalo.precio().toString().length() == 4
	}

	method esRegaloPreferido(regalo) {
		return (regalo.esValioso() and self.edad().odd()) || self.valorAceptableDe(regalo)
	}	
	
	method inconformista(regalos) {
		return regalos.all({regalo => self.esRegaloPreferido(regalo).negate()})
	}
	
}

object pedro {
	const amistades = []
	var mejorAmigo = justina
	
	method agregarAmistad(amistad) {
		amistades.add(amistad)
	}
	
	method amistades() {
		return amistades
	}
	
	method mejorAmigo(_persona) {
		mejorAmigo = _persona
	}
	
	method mejorAmigo() {
		return mejorAmigo
	}	
	
	method esRegaloPreferido(regalo) {
		return self.mejorAmigo().esRegaloPreferido(regalo)
	}
	
	method inconformista(regalos) {
		return regalos.all({regalo => self.esRegaloPreferido(regalo).negate()})
	}
	
}
