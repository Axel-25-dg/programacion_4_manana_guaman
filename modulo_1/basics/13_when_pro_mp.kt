fun main() {
    println("Consulta de Nivel de Curso")
    println("Ingrese el codigo del curso:")
    val codigo = readLine()?.toIntOrNull() ?: 0

    val nivel = when(codigo) {
        1 -> "A1 - Principiante"
        2 -> "A2 - Elemental"
        3 -> "B1 - Intermedio"
        4 -> "B2 - Intermedio Alto"
        5 -> "C1 - Avanzado"
        else -> "Codigo de curso no valido"
    }
    
    println("Nivel correspondiente: $nivel")
}
