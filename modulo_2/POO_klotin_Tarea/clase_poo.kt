class Libro(
    var titulo: String,
    var autor: String,
    var anioPublicacion: Int,
    var numeroPaginas: Int
) {
    fun mostrarInformacion() {
        println("Titulo: $titulo")
        println("Autor: $autor")
        println("Anio: $anioPublicacion")
        println("Paginas: $numeroPaginas")
    }

    fun tipoLibro() {
        if (anioPublicacion < 2000) {
            println("Antiguo")
        } else {
            println("Reciente")
        }
    }
}

fun main() {
    val libro1 = Libro("Cien anos de soledad", "Gabriel Garcia Marquez", 1967, 417)
    libro1.mostrarInformacion()
    libro1.tipoLibro()
    
    val libro2 = Libro("El resplandor", "Stephen King", 2013, 600)
    libro2.mostrarInformacion()
    libro2.tipoLibro()
}
