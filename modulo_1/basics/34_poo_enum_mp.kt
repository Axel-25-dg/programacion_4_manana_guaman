enum class DificultadLeccion(val descripcion: String, val xpRecompensa: Int) {
    PRINCIPIANTE("Conceptos basicos", 50),
    ELEMENTAL("Frases cotidianas", 100),
    INTERMEDIO("Conversacion fluida", 200),
    AVANZADO("Analisis literario", 500);

    fun esRetoDificil(): Boolean = this == AVANZADO
}

fun main() {
    val dificultad = DificultadLeccion.INTERMEDIO
    println("Nivel: $dificultad")
    println("Descripcion: ${dificultad.descripcion}")
    println("XP a ganar: ${dificultad.xpRecompensa}")

    val mensaje = when (dificultad) {
        DificultadLeccion.PRINCIPIANTE -> "Ideal para empezar hoy."
        DificultadLeccion.ELEMENTAL -> "Un buen paso adelante."
        DificultadLeccion.INTERMEDIO -> "Manten la concentracion."
        DificultadLeccion.AVANZADO -> "¡Un verdadero desafio!"
    }
    println(mensaje)

    println("¿Es un reto dificil? ${dificultad.esRetoDificil()}")
}
