/**
 * Uso de readLine para capturar datos del curso
 * Ejemplo MP - 05
 */
fun main() {
    println("Que idioma desea aprender?")
    val idioma = readLine()
    println("Idioma seleccionado: $idioma")

    println("Ingrese su ID de estudiante: ")
    val idEstudiante = readLine() ?: "EST-0000"
    println("ID Registrado: $idEstudiante")

    println("Configuracion de perfil completada para $idioma")
}
