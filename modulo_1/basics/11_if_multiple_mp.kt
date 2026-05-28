fun main() {
    println("Clasificacion de Rendimiento del Estudiante")
    println("Ingrese su precision promedio (%):")
    
    val precision = readLine()?.toIntOrNull() ?: 0

    val rango = if (precision >= 95) {
        "Leyenda"
    } else if (precision >= 85) {
        "Maestro"
    } else if (precision >= 70) {
        "Experto"
    } else if (precision >= 50) {
        "Aprendiz"
    } else {
        "Novato"
    }

    println("Rango de rendimiento: $rango")
    println("Rango en mayusculas: ${rango.uppercase()}")
}
