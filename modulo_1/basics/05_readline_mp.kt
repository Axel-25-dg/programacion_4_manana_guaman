fun main() {
    println("Ingrese su nombre de estudiante: ")
    val nombre = readLine()
    println("Estudiante registrado: $nombre")

    println("Ingrese el idioma que desea aprender: ")
    val idioma = readLine() ?: "Ingles"
    println("Idioma seleccionado: $idioma")

    println("Ingrese su ID de estudiante: ")
    val idEstudiante = readLine() ?: "0000"
    println("Registro completo para ID: $idEstudiante")
    
    println("Proceso de registro finalizado")
}
