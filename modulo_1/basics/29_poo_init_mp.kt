class RegistroEstudiante(val nombre: String, val correo: String) {
    val nombreProcesado: String
    val servidorCorreo: String

    init {
        require(nombre.isNotBlank()) { "El nombre del estudiante no puede estar vacio" }
        require(correo.contains("@")) { "Correo electronico no valido" }

        nombreProcesado = nombre.trim().uppercase()
        servidorCorreo = correo.substringAfter("@")
    }
}

fun main() {
    val registro = RegistroEstudiante("  Henry Guaman  ", "henry@idiomas.com")
    println("Nombre: ${registro.nombreProcesado}")
    println("Servidor: ${registro.servidorCorreo}")
    
    try {
        RegistroEstudiante("", "error")
    } catch (e: IllegalArgumentException) {
        println("Validacion fallida: ${e.message}")
    }
}
