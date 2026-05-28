class ProgresoCurso(porcentaje: Double) {
    var porcentaje: Double = porcentaje
        set(value) {
            require(value in 0.0..100.0) { "El porcentaje debe estar entre 0 y 100" }
            field = value
        }

    val completado: Boolean
        get() = porcentaje >= 100.0

    val estado: String
        get() = when {
            porcentaje == 0.0 -> "No iniciado"
            porcentaje < 30.0 -> "Principiante"
            porcentaje < 70.0 -> "Intermedio"
            porcentaje < 100.0 -> "Avanzado"
            else -> "Completado"
        }
}

fun main() {
    val curso = ProgresoCurso(25.0)
    println("Progreso: ${curso.porcentaje}% - Estado: ${curso.estado}")

    curso.porcentaje = 75.0
    println("Nuevo Progreso: ${curso.porcentaje}% - Estado: ${curso.estado}")
    
    curso.porcentaje = 100.0
    println("Completado? ${curso.completado}")
}
