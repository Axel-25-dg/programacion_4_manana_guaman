fun main() {
    println("Analisis de Desempeño del Estudiante")

    println("Nombre del Estudiante:")
    val nombreEstudiante = readLine()?.trim()?.lowercase() ?: "Anonimo"

    println("Ingrese el nivel de desempeño (EXCELENTE/BUENO/SUFICIENTE/INSUFICIENTE):")
    val desempeño = readLine()?.trim()?.uppercase() ?: ""

    when (desempeño) {
        "EXCELENTE" -> {
            println("¡Felicidades, $nombreEstudiante!")
            println("Has ganado una medalla de oro.")
            println("Se han acreditado 500 gemas extra.")
        }
        "BUENO" -> {
            println("Muy bien, $nombreEstudiante.")
            println("Has ganado una medalla de plata.")
            println("Se han acreditado 200 gemas extra.")
        }
        "SUFICIENTE" -> {
            println("Buen trabajo, $nombreEstudiante.")
            println("Has ganado una medalla de bronce.")
            println("Continua practicando para mejorar.")
        }
        "INSUFICIENTE" -> {
            println("Animo, $nombreEstudiante.")
            println("No has alcanzado el minimo esta vez.")
            println("Te recomendamos realizar el repaso diario.")
        }
        else -> {
            println("Nivel de desempeño no reconocido en el sistema.")
        }
    }
}
