interface Evaluable {
    fun evaluar(): Int
    val nombreActividad: String
}

class EjercicioVocabulario(val palabrasAcertadas: Int) : Evaluable {
    override val nombreActividad = "Vocabulario"
    override fun evaluar(): Int = palabrasAcertadas * 10
}

class EjercicioEscucha(val precision: Double) : Evaluable {
    override val nombreActividad = "Comprension Auditiva"
    override fun evaluar(): Int = (precision * 100).toInt()
}

class EjercicioGramatica(val errores: Int) : Evaluable {
    override val nombreActividad = "Gramatica"
    override fun evaluar(): Int = if (errores == 0) 150 else if (errores < 3) 100 else 50
}

fun procesarActividad(actividad: Evaluable) {
    println("Evaluando: ${actividad.nombreActividad}...")
    val puntaje = actividad.evaluar()
    println("Puntaje obtenido: $puntaje XP")
}

fun main() {
    val actividades: List<Evaluable> = listOf(
        EjercicioVocabulario(15),
        EjercicioEscucha(0.85),
        EjercicioGramatica(1),
        EjercicioGramatica(0)
    )

    actividades.forEach { procesarActividad(it) }
}
