fun main() {
    println("Controles de Flujo When")
    println("Ingresa codigo")
    val codigo = readLine()?.toIntOrNull() ?: 0

    val especialidad = when(codigo) {
        1 -> "Sangre venosa 24 horas"
        2 -> "Orina 48 horas"
        3 -> "Heces 72 horas"
        4 -> "Hisopado nasofaringeo 24 horas"
        5 -> "Biopsia 72 horas"
        else -> "Especialidad no registrada en el sistema"
    }
    
    println("Especialidad: $especialidad")
}