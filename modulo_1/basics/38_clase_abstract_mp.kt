abstract class ContenidoEducativo(val titulo: String) {
    abstract val duracionSegundos: Int
    abstract fun iniciar()
    
    fun mostrarInfo() = println("Contenido: $titulo | Duracion: $duracionSegundos seg")
}

class LeccionVocabulario(titulo: String, val nPalabras: Int) : ContenidoEducativo(titulo) {
    override val duracionSegundos: Int = nPalabras * 10
    override fun iniciar() {
        println("Iniciando leccion de vocabulario: $titulo. ¡Aprenderas $nPalabras palabras!")
    }
}

class LeccionEscucha(titulo: String, override val duracionSegundos: Int) : ContenidoEducativo(titulo) {
    override fun iniciar() {
        println("Iniciando audio de $titulo. Por favor use auriculares.")
    }
}

class LeccionGramatica(titulo: String, val nReglas: Int) : ContenidoEducativo(titulo) {
    override val duracionSegundos: Int = nReglas * 30
    override fun iniciar() {
        println("Iniciando gramatica: $titulo. Revisaremos $nReglas reglas clave.")
    }
}

fun main() {
    val contenidos: List<ContenidoEducativo> = listOf(
        LeccionVocabulario("Frutas en Frances", 20),
        LeccionEscucha("Podcast: Viaje a Paris", 300),
        LeccionGramatica("El Pasado Compuesto", 5)
    )

    contenidos.forEach {
        it.mostrarInfo()
        it.iniciar()
        println("---")
    }
}
