class Entrada{
  const property banda// espera un objeto de clase "banda"
  const property anio
  const property mes
  const property dia

  method precio() = 1000 + productora.impuesto()
} 
class Asistente{
  const property abono
  var property historialEntrada = [] 
  var property dineroDisponible 

  method precioAPagar(entrada) = entrada.precio()
  method comprarEntrada(entrada){
    if(dineroDisponible>= self.precioAPagar(entrada)){
      dineroDisponible -= self.precioAPagar(entrada)
      historialEntrada.add(entrada)
      entrada.banda().venderEntrada()
    }
    else{
      self.error("No hay dinero suficiente")
    }
  }
  method entradasAnioPasado() = historialEntrada.filter({ e => e.anio() == new Date().year() - 1 })
  method nombreEntradas() = historialEntrada.map({n => n.banda().nombre()}) 
}// si el asistente es fan, se hace new new Asistente(abono = "Fan"), ya que no tiene nada distinto como para crear una clase aparte
class AsistenteVip inherits Asistente(abono = "Vip"){
  var property porcentajeDescuento
  
  override method precioAPagar(entrada) = entrada.precio() * (1-porcentajeDescuento)
  method bonificar(){ 
  porcentajeDescuento += 0.01
  }
}
class Banda{
  const property nombre 
  var property entradasVendidas = 0

  method venderEntrada(){ 
  entradasVendidas += 1
  }
  method canon() = 1000000
  method gastoExtra() 
  method presupuesto() = self.canon() + self.gastoExtra() 
  method popularidad()
  
}
class BandaDeRock inherits Banda{
  var property cantidadSolos

  override method gastoExtra() = 10000
  override method popularidad() = 100 * cantidadSolos
}
class BandaDeTrap inherits Banda{
  var property tieneHielo

  override method popularidad(){
    if(tieneHielo){
      return 1000
    }
    else{
      return 0
    }
  }
  override method gastoExtra() = 0
  override method canon() = 1000000 * self.popularidad()
} 
class BandaIndie inherits Banda{
  var property cantidadInstrumentos

  method largoDelNombre() = nombre.size()
  override method popularidad() = 3.14 * self.largoDelNombre()
  override method gastoExtra() = 500 * cantidadInstrumentos
} 

object productora{ 
  var property bandasQueTocan = [facilB, laCoja]
  var property asistentes = [maria, juan, ana]
  var property impuesto = 200

  method presupuestoBandas() = bandasQueTocan.sum({b=>b.presupuesto()})
  method cantidadRecaudadoEntradas() = asistentes.sum({ a => a.historialEntrada().sum({ e => e.precio() }) })
  method gananciaTotal () = self.cantidadRecaudadoEntradas() - self.presupuestoBandas() 

  method cantidadEntradasVendidas() = asistentes.sum({ a => a.historialEntrada().size() })

  method bandaMasPopular() = bandasQueTocan.max({ b => b.entradasVendidas() })
  } 

  //bandas de ejemplo y asistentes 
  // Bandas
  const facilB = new BandaDeTrap(nombre = "Fácil B", tieneHielo = true)
  const laCoja = new BandaDeRock(nombre = "La Coja", cantidadSolos = 3)

  // Entradas
  const entradaFacilB = new Entrada(banda = facilB, anio = 2026, mes = 12, dia = 5)
  const entradaLaCoja = new Entrada(banda = laCoja, anio = 2025, mes = 11, dia = 20)

  // Asistentes 
  const maria = new Asistente(abono = "Fan", dineroDisponible = 5000)
  const juan  = new AsistenteVip(porcentajeDescuento = 0.10, dineroDisponible = 5000)
  const ana   = new Asistente(abono = "Fan", dineroDisponible = 5000)
