// El constructor primario integra la declaración de propiedades
class Persona(val nombre: String, val edad: Int)

// Con cuerpo adicional
class Persona2(val nombre: String, val edad: Int) {
    fun presentarse() = "Soy $nombre y tengo $edad años"
    fun esMayorDeEdad() = edad >= 18
}

fun main() {
    val p = Persona("Ana", 28)
    println(p.nombre)   // Ana
    println(p.edad)     // 28

    val p2 = Persona2("Luis", 17)
    println(p2.presentarse())     // Soy Luis y tengo 17 años
    println(p2.esMayorDeEdad())   // false
}