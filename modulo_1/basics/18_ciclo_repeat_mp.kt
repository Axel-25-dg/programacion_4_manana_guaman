fun main() {
    println("Registro de Puntajes en Lecciones")
    println("¿Cuantas lecciones completaste hoy?")
    
    val nLecciones = readLine()?.toIntOrNull() ?: 0
    var totalXP = 0

    if (nLecciones > 0) {
        repeat(nLecciones) { i ->
            println("Puntaje de la leccion ${i + 1}:")
            val xp = readLine()?.toIntOrNull() ?: 0
            totalXP += xp
        }

        val promedioXP = totalXP / nLecciones
        println("XP promedio por leccion: $promedioXP")
        
        println("Calificacion del dia: ${
            when {
                promedioXP >= 90 -> "Excelente"
                promedioXP in 70..89 -> "Muy Bueno"
                promedioXP in 50..69 -> "Bueno"
                else -> "Necesita Refuerzo"
            }
        }")
    } else {
        println("No se registraron lecciones hoy.")
    }

    println("\nSimulacion de practica intensiva:")
    val repeticiones = 3
    repeat(repeticiones) { iteration ->
        println("Repeticion de vocabulario #${iteration + 1} completada.")
    }
}
