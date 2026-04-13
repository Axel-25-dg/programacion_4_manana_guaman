/**
 * Ejemplo MP - 09
 */
fun main() {
    println("Sistema de Evaluacion de Leccion")
    print("Ingrese el puntaje obtenido (0-100): ")
    val puntaje = readLine()?.toDoubleOrNull() ?: 0.0

    if (puntaje >= 90.0) {
        println("Excelente: Has dominado este tema!")
    } else if (puntaje >= 70.0) {
        println("Bien hecho: Has aprobado la leccion.")
    } else {
        println("Necesitas practicar un poco mas este vocabulario.")
    }
    println("Puntaje registrado: $puntaje puntos")
}
