class Curso(val nombre: String, val duracionSemanas: Int)

class CursoDetallado(val nombre: String, val nivel: String, val leccionesTotales: Int) {
    fun obtenerResumen() = "Curso: $nombre | Nivel: $nivel | $leccionesTotales lecciones"
    fun esAvanzado() = nivel.equals("C1", ignoreCase = true) || nivel.equals("C2", ignoreCase = true)
}

fun main() {
    val cursoBasico = Curso("Ingles Inicial", 4)
    println("Curso: ${cursoBasico.nombre}, Duracion: ${cursoBasico.duracionSemanas} semanas")

    val cursoPro = CursoDetallado("Japones N5", "A1", 50)
    println(cursoPro.obtenerResumen())
    println("¿Es nivel avanzado? ${cursoPro.esAvanzado()}")
}
