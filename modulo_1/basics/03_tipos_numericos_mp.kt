/**
 * Tipos de datos numericos para estadisticas de aprendizaje
 * Ejemplo MP - 03
 */
fun main() {
    println("Estadisticas de Aprendizaje")
    
    val nivelActual: Byte = 12
    println("Nivel actual: $nivelActual")
    
    val palabrasAprendidas: Short = 1500
    println("Palabras en vocabulario: $palabrasAprendidas")
    
    val puntosExperiencia: Int = 45000
    println("XP Total: $puntosExperiencia")
    
    val totalMinutosEstudiados: Long = 120_500L
    println("Tiempo total (min): $totalMinutosEstudiados")
    
    val precisionPromedio: Float = 88.5f
    println("Precision promedio: $precisionPromedio%")
    
    val progresoModulo: Double = 0.75234
    println("Progreso del modulo actual: $progresoModulo")

    // Inferido y Reflexión
    val cursoActivo = "Ingles Avanzado"
    val rachaDias = 30
    
    println("Curso: $cursoActivo")
    println("Tipo de dato curso: ${cursoActivo::class.simpleName}")
    
    println("Racha: $rachaDias dias")
    println("Tipo de dato racha: ${rachaDias::class.simpleName}")
}
