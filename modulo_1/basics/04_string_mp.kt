fun main() {
    val nombre = "Henry"
    val idioma = "Japones"
    val racha = 15
    
    println("Bienvenido de vuelta, $nombre")
    println("Idioma actual: ${idioma.uppercase()}")
    
    val resumenPerfil = "Estudiante: ${nombre.uppercase()} | Nivel: Intermedio"
    println(resumenPerfil)
    
    println("Dias de racha: ${racha + 1} (si completas la leccion de hoy)")
    
    val tarjetaEstudiante = """
        |Estudiante: $nombre
        |Idioma: $idioma
        |Racha: $racha dias
        |Estado de suscripcion: ${if (racha >= 10) "Premium" else "Basico"}
    """.trimMargin()
    println(tarjetaEstudiante)
}
