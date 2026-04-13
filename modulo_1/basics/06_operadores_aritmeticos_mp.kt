/**
 * Operadores aritmeticos aplicados a XP y tiempos de estudio
 * Ejemplo MP - 06
 */
fun main() {
    println("Calculadora de Progreso de Idiomas")
    val xpPorLeccion = 100
    val leccionesRealizadas = 3

    println("Resumen de hoy:")
    println("XP total ganado: $xpPorLeccion * $leccionesRealizadas = ${xpPorLeccion * leccionesRealizadas}")

    val tiempoMinutos = 45
    val sesiones = 2
    println("Tiempo total de estudio: $tiempoMinutos + $tiempoMinutos = ${tiempoMinutos + sesiones}")

    println("Promedio de XP por minuto:")
    println("${xpPorLeccion * leccionesRealizadas} / 90 = ${(xpPorLeccion * leccionesRealizadas) / 90}")

    println("Operadores de Asignacion Compuesta para Racha")
    var rachaDias = 5

    rachaDias += 1
    println("Racha incrementada (+=1): $rachaDias")

    rachaDias -= 1
    println("Penalizacion de racha (-=1): $rachaDias")

    // Incremento y decremento
    var vidas = 5
    vidas--
    println("Perdiste una vida en la leccion: $vidas")
    vidas++
    println("Recuperaste una vida: $vidas")
}
