/**
 * Ejemplo MP - 12
 */
fun main() {
    println("Portal de Examenes de Certificacion")
    println("Es usuario Premium? (s/n)")
    val esPremium = readLine()?.trim()?.lowercase() == "s"
    
    println("Puntaje en el simulacro (0-100)")
    val puntajeSimulacro = readLine()?.toIntOrNull() ?: 0

    if (esPremium) {
        println("Validando acceso para usuario Premium...")
        if (puntajeSimulacro >= 70) {
            println("Felicidades! Puedes tomar el examen oficial hoy.")
        } else {
            println("Te recomendamos practicar un poco mas antes del examen oficial.")
        }
    } else {
        println("El examen oficial requiere una suscripcion Premium.")
        if (puntajeSimulacro >= 90) {
            println("Excelente puntaje! Obten Premium para certificarte.")
        } else {
            println("Sigue practicando para alcanzar el nivel de certificacion.")
        }
    }
}
