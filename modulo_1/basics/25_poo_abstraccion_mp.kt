fun main() {
    println("Abstraccion de Lecciones mediante Utilidades")
    val lecciones = listOf("Basico 1", "Basico 2", "Intermedio 1", "Intermedio 2", "Avanzado 1")
    
    val leccionesMayusculas = lecciones.map { it.uppercase() }
    println("Lecciones normalizadas: $leccionesMayusculas")

    val soloIntermedio = lecciones.filter { it.contains("Intermedio") }
    println("Filtro nivel intermedio: $soloIntermedio")

    val totalCaracteres = lecciones.map { it.length }.reduce { acc, len -> acc + len }
    println("Carga total de texto (caracteres): $totalCaracteres")

    val resumen = lecciones.fold("Plan de estudio:") { acc, leccion -> "$acc | $leccion" }
    println(resumen)

    println("\nEstadisticas de contenido:")
    println("Total lecciones: ${lecciones.count()}")
    println("Ultima leccion añadida: ${lecciones.last()}")
    println("¿Contiene nivel avanzado? ${lecciones.any { it.contains("Avanzado") }}")
}
