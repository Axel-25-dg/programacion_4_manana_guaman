class PuntoInmutable(val x: Double, val y: Double)   // solo lectura

class Contador(var valor: Int = 0) {                  // lectura y escritura
    fun incrementar() { valor++ }
    fun resetear()    { valor = 0 }
}

// Sin val/var — parámetro del constructor, NO propiedad
// Solo accesible dentro del bloque init
class Temporal(nombre: String) {
    val nombreUpper = nombre.uppercase()
    // nombre no existe fuera de aquí
}