class PerfilEstudiante(val nombre: String, gemasIniciales: Int) {
    private var gemasAcumuladas: Int = gemasIniciales

    fun ganarGemas(cantidad: Int) {
        if (cantidad > 0) {
            gemasAcumuladas += cantidad
            println("¡Has ganado $cantidad gemas! Total actual: $gemasAcumuladas")
        }
    }

    fun canjearGemas(cantidad: Int): Boolean {
        return if (cantidad > 0 && gemasAcumuladas >= cantidad) {
            gemasAcumuladas -= cantidad
            println("Canje exitoso de $cantidad gemas. Gemas restantes: $gemasAcumuladas")
            true
        } else {
            println("Gemas insuficientes para el canje.")
            false
        }
    }

    fun consultarGemas(): Int = gemasAcumuladas
}

fun main() {
    val estudiante = PerfilEstudiante("Henry", 100)

    estudiante.ganarGemas(50)
    estudiante.canjearGemas(30)
    estudiante.canjearGemas(200)

    println("Estudiante: ${estudiante.nombre}")
    println("Saldo de gemas: ${estudiante.consultarGemas()}")
}
