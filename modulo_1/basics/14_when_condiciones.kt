fun main() {
    println("--- Controles de Flujo When con condiciones arbitrarias ---")
    
    println("Edad del paciente:")
    val edad = readLine()?.toIntOrNull() ?: 0

    println("Tiene Seguro? (S/N):")
    val tieneSeguro = readLine()?.trim()?.lowercase() == "s"

    var nivelSeguro = ""
    if (tieneSeguro) {
        println("Nivel del seguro (BASICO/INTERMEDIO/PREMIUM):")
        nivelSeguro = readLine()?.trim()?.uppercase() ?: ""
    }

    val copago = when {
        !tieneSeguro && edad < 18 -> 0.0
        !tieneSeguro && edad >= 65 -> 15.0
        !tieneSeguro -> 45.0
        nivelSeguro == "BASICO" -> 20.0
        nivelSeguro == "INTERMEDIO" -> 10.0
        nivelSeguro == "PREMIUM" -> 0.0
        else -> 30.0
    }

    println("Copago: $${"%.2f".format(copago)}")
}