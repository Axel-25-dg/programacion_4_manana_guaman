fun main() {
    println("Estadisticas y Seguimiento de Aprendizaje")

    println("Dias de la semana:")
    for (i in 1..7) {
        println("Dia $i")
    }

    println("Progreso de leccion (0% a 100%):")
    for (i in 0..100 step 20) {
        println("Completado: $i%")
    }
    
    println("Conteo regresivo para inicio de examen:")
    for (i in 5 downTo 1) {
        println("Iniciando en... $i")
    }

    println("Vocabulario de hoy:")
    val vocabulario = listOf("Konnichiwa", "Sayonara", "Arigatou", "Onegai", "Sumimasen")
    for (palabra in vocabulario) {
        println("Palabra: $palabra")
    }

    println("Indice de palabras en la leccion:")
    for ((index, palabra) in vocabulario.withIndex()) {
        println("Posicion ${index + 1}: $palabra")
    }

    println("Buscando palabra clave (limite 3):")
    for (i in 1..10) {
        if (i == 4) break
        println("Revisando palabra $i...")
    }

    println("Saltando palabras ya conocidas:")
    for (i in 1..5) {
        if (i == 3) continue
        println("Estudiando palabra nueva $i")
    }

    val progresoEstudiantes = listOf(
        Triple("Henry", 95, 15),
        Triple("Maria", 82, 30),
        Triple("Pedro", 65, 5),
        Triple("Ana", 89, 45),
        Triple("Luis", 74, 10)
    )

    println("Reporte de Rendimiento:")
    for ((pos, estudiante) in progresoEstudiantes.withIndex()) {
        val (nombre, precision, racha) = estudiante
        val estado = if (precision > 80) "Excelente" else "Necesita Practica"
        val bono = if (racha > 20) "Bono Activo" else "Sin Bono"
        println("Estudiante ${pos + 1}: $nombre - Precision: $precision% ($estado) - Racha: $racha dias ($bono)")
    }
}
