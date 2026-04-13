/**
 * Ejemplo MP - 11
 */
fun main() {
    println("Clasificacion de Fluidez")
    println("Ingrese cantidad de palabras aprendidas:")
    
    val palabras = readLine()?.toIntOrNull() ?: 0

    val rango = if (palabras <= 500) {
        "Principiante (A1)"
    } else if (palabras <= 1000) {
        "Elemental (A2)"
    } else if (palabras <= 2000) {
        "Intermedio (B1)"
    } else if (palabras <= 4000) {
        "Intermedio Alto (B2)"
    } else if (palabras <= 8000) {
        "Avanzado (C1)"
    } else {
        "Maestria (C2)"
    }

    println("Tu rango actual es: $rango")
    println("ESTADO: ${rango.uppercase()}")
}   
