/**
 * Control de flujo When para seleccion de cursos
 * Ejemplo MP - 13
 */
fun main() {
    println("Catalogo de Cursos de Idiomas")
    println("1. Ingles")
    println("2. Frances")
    println("3. Aleman")
    println("4. Italiano")
    println("5. Japones")
    println("6. Portugues")
    println("Seleccione el codigo del curso:")
    
    val codigo = readLine()?.toIntOrNull() ?: 0
    
    val curso = when(codigo) {
        1 -> "Ingles - Domina el idioma universal"
        2 -> "Frances - El idioma del amor y la cultura"
        3 -> "Aleman - Ciencia y tecnologia"
        4 -> "Italiano - Arte y gastronomia"
        5 -> "Japones - Tradición y modernidad"
        6 -> "Portugues - Ritmo y negocios"
        else -> "Codigo de curso no valido"
    }
    
    println("Curso Elegido: $curso")
}
