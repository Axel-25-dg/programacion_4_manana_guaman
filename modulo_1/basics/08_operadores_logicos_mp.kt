/**
 * Operadores logicos para acceso a cursos avanzados
 * Ejemplo MP - 08
 */
fun main() {
    println("Validacion de Requisitos para Examen de Certificacion")
    val nivelSuficiente = true
    val rachaActiva = true
    val esPremium = false

    println("&& - Requerido: Nivel Suficiente Y Racha Activa")
    println("Puede dar el examen? ${nivelSuficiente && rachaActiva}")

    println("|| - Requerido: Racha Activa O Ser Usuario Premium")
    println("Tiene beneficios extra? ${rachaActiva || esPremium}")

    println("! - Not Lógico")
    println("Es usuario gratuito? ${!esPremium}")
    println("Perdio la racha? ${!rachaActiva}")
}
