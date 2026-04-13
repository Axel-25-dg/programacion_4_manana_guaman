/**
 * Ejemplo MP - 10
 */
fun main() {
    println("Verificacion de Nivel de Membresia")
    print("Ingrese la cantidad de lecciones completadas: ")
    val lecciones = readLine()?.toIntOrNull() ?: 0

    if (lecciones >= 100) {
        println("Usuario Oro: Acceso ilimitado a todos los idiomas.")
    } else if (lecciones >= 50) {
        println("Usuario Plata: Acceso a 3 idiomas simultaneos.")
    } else {
        println("Usuario Bronce: Acceso a 1 idioma.")
    }
    println("Lecciones totales: $lecciones")
}
