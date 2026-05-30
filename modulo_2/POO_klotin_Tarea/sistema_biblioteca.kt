class LibroBiblioteca(
    val id: Int,
    val titulo: String,
    val autor: String
) {
    private var estaPrestado: Boolean = false

    fun disponible(): Boolean = !estaPrestado

    fun prestar() {
        if (!estaPrestado) {
            estaPrestado = true
            println("Prestado: $titulo")
        } else {
            println("No disponible")
        }
    }

    fun devolver() {
        if (estaPrestado) {
            estaPrestado = false
            println("Devuelto: $titulo")
        } else {
            println("No estaba prestado")
        }
    }

    fun info() {
        val estado = if (estaPrestado) "Prestado" else "Disponible"
        println("$id - $titulo - $autor - $estado")
    }
}

class Biblioteca {
    private val libros = mutableListOf<LibroBiblioteca>()

    fun agregar(libro: LibroBiblioteca) {
        libros.add(libro)
    }

    fun listar() {
        for (l in libros) {
            if (l.disponible()) l.info()
        }
    }

    fun buscar(titulo: String): LibroBiblioteca? {
        return libros.find { it.titulo.equals(titulo, ignoreCase = true) }
    }
}

fun main() {
    val biblio = Biblioteca()
    val l1 = LibroBiblioteca(1, "1984", "George Orwell")
    val l2 = LibroBiblioteca(2, "Quijote", "Cervantes")
    
    biblio.agregar(l1)
    biblio.agregar(l2)
    
    biblio.listar()
    
    val b = biblio.buscar("1984")
    b?.prestar()
    b?.prestar()
    b?.devolver()
    
    biblio.listar()
}
