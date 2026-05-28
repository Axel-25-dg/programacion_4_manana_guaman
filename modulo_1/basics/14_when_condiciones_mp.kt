fun main() {
    println("Calculo de Costo de Suscripcion")
    
    println("Edad del estudiante:")
    val edad = readLine()?.toIntOrNull() ?: 0

    println("Tiene beca? (s/n):")
    val tieneBeca = readLine()?.trim()?.lowercase() == "s"

    var nivelSuscripcion = ""
    if (!tieneBeca) {
        println("Nivel deseado (BASICO/INTERMEDIO/AVANZADO):")
        nivelSuscripcion = readLine()?.trim()?.uppercase() ?: ""
    }

    val costoSuscripcion = when {
        tieneBeca && edad < 21 -> 0.0
        tieneBeca && edad >= 60 -> 5.0
        tieneBeca -> 15.0
        nivelSuscripcion == "BASICO" -> 20.0
        nivelSuscripcion == "INTERMEDIO" -> 35.0
        nivelSuscripcion == "AVANZADO" -> 50.0
        else -> 30.0
    }

    println("Costo mensual de suscripcion: $${"%.2f".format(costoSuscripcion)}")
}
