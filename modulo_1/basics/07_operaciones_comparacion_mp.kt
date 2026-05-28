fun main() {
    println("Comparacion de Rendimiento de Estudiante")
    val puntajeExamen = 85
    val puntajeMinimoAprobacion = 70
    val rachaActual = 15
    val metaRacha = 30

    println("Puntaje Examen: $puntajeExamen")
    println("Puntaje Minimo: $puntajeMinimoAprobacion")
    println("Aprobo el examen? ${puntajeExamen >= puntajeMinimoAprobacion}")

    println("Racha actual: $rachaActual dias")
    println("Meta alcanzada? ${rachaActual >= metaRacha}")

    val precisionEstudianteA = 92.5
    val precisionEstudianteB = 92.5
    println("Precisiones iguales? ${precisionEstudianteA == precisionEstudianteB}")

    val nivelRequerido = 5
    val nivelActual = 3
    println("Nivel suficiente para el curso avanzado? ${nivelActual >= nivelRequerido}")
    
    val erroresPermitidos = 3
    val erroresCometidos = 4
    println("Leccion fallida por exceso de errores? ${erroresCometidos > erroresPermitidos}")
}
