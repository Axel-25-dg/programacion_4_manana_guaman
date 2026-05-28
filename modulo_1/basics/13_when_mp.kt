fun main() {
    println("Seleccion de Idioma de Estudio")
    println("Ingrese el codigo del idioma (1-6):")
    val codigo = readLine()?.toIntOrNull() ?: 0
    
    val idioma = when(codigo) {
        1 -> "Ingles"
        2 -> "Frances"
        3 -> "Aleman"
        4 -> "Japones"
        5 -> "Italiano"
        6 -> "Portugues"
        else -> "Idioma no disponible actualmente"
    }
    
    println("Usted ha seleccionado: $idioma")
    println("Disfrute su aprendizaje de $idioma!")
}
