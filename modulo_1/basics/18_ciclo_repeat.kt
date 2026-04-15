fun main() {
    println("Controles de Flujo interacciones, Ciclo repetitivos - ciclo repeat")
    println(" pon cuantas pulsiones quieres tomar para calcular frecuencia cardiaca")
    
    val mediciones = readLine()?.toIntOrNull() ?: 0
    var totalPulsaciones = 0

    if (mediciones > 0) {
        repeat(mediciones) { i ->
            println("Medicion ${i + 1} (pulsos en 15 seg.)")
            val pulsos = readLine()?.toIntOrNull() ?: 0
            totalPulsaciones += pulsos * 4
        }

        val promedio = totalPulsaciones / mediciones
        println("Frecuencia cardiaca promedio: $promedio lpm")
        
        println("Clasificacion: ${
            when {
                promedio < 60 -> "Bradicardia"
                promedio in 60..100 -> "Normal"
                promedio in 101..120 -> "Taquicardia leve"
                promedio > 120 -> "Taquicardia severa"
                else -> "No se pudo calcular"
            }
        }")
    }
}


//ejercicio

fun main() {
    println("Registro de temperatura del paciente (cada 4 horas / 24 horas)")
    
    var sumaTemperaturas = 0.0
    var contadorFiebre = 0
    val medicionesTotales = 6

    repeat(medicionesTotales) { i ->
        print("Medición ${i + 1} (Temperatura en °C): ")
        val temp = readLine()?.toDoubleOrNull() ?: 0.0
        
        sumaTemperaturas += temp
        
        if (temp > 38.5) {
            contadorFiebre++
        }
    }

    val promedio = sumaTemperaturas / medicionesTotales

    println("\n--- Resumen Médico ---")
    println("Promedio de temperatura: $promedio°C")
    
    if (contadorFiebre > 2) {
        println("Estado: Fiebre sostenida ($contadorFiebre mediciones altas)")
    } else {
        println("Estado: No hubo fiebre sostenida")
    }
}