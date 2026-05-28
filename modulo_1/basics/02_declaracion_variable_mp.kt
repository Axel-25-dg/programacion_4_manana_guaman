fun main() {
    val nombreEstudiante = "Henry"
    val edad: Int = 22
    val idiomaDestino = "Ruso"
    
    var leccionesCompletadas = 5
    println("Estudiante: $nombreEstudiante")
    println("Idioma: $idiomaDestino")
    println("Lecciones iniciales: $leccionesCompletadas")
    
    leccionesCompletadas = leccionesCompletadas + 1
    println("Lecciones despues de hoy: $leccionesCompletadas")
    
    println("$nombreEstudiante tiene $edad anos y estudia $idiomaDestino")
}
