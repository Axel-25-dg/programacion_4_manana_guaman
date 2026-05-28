object AjustesApp {
    val version: String = "1.0.0"
    val servidor: String = "idiomas.api.com"
    private val tokenAcceso: String = "AUTH_TOKEN_789"

    fun obtenerUrl() = "https://$servidor/v1"
}

class Estudiante private constructor(val id: Int, val nombre: String) {
    companion object {
        private var totalEstudiantes = 0

        fun crearEstudiante(nombre: String): Estudiante? {
            if (nombre.isBlank()) return null
            return Estudiante(++totalEstudiantes, nombre.trim())
        }
    }

    override fun toString() = "Estudiante #$id: $nombre"
}

fun main() {
    println("App Version: ${AjustesApp.version}")
    println("URL API: ${AjustesApp.obtenerUrl()}")

    val e1 = Estudiante.crearEstudiante("Henry")
    val e2 = Estudiante.crearEstudiante("Maria")
    
    println(e1)
    println(e2)
}
