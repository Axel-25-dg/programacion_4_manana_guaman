fun main() {
    println("Diccionario de Traducciones (Map Inmutable)")
    val traducciones = mapOf(
        "Hello" to "Hola",
        "World" to "Mundo",
        "Language" to "Idioma",
        "Student" to "Estudiante",
    )
    
    println("Traduccion de 'Hello': ${traducciones["Hello"]}")
    println("Traduccion de 'Book': ${traducciones["Book"]}")
    println("Traduccion segura de 'Hello': ${traducciones.getOrDefault("Hello", "No encontrada")}")
    println("Traduccion segura de 'Book': ${traducciones.getOrDefault("Book", "No encontrada")}")
    
    println("Todas las palabras: ${traducciones.keys}")
    println("Todas las traducciones: ${traducciones.values}")
    
    for ((ingles, espanol) in traducciones) {
        println("$ingles en español es $espanol")
    }

    println("\nSeguimiento de Rachas por Estudiante (Map Mutable)")
    val rachasEstudiantes = mutableMapOf(
        "Henry" to 15,
        "Maria" to 30,
        "Pedro" to 5,
        "Ana" to 45
    )
    
    rachasEstudiantes["Carlos"] = 1
    println("Nueva racha añadida: $rachasEstudiantes")
    
    rachasEstudiantes["Henry"] = 16
    println("Racha actualizada para Henry: $rachasEstudiantes")
    
    rachasEstudiantes.remove("Pedro")
    println("Estudiante Pedro eliminado: $rachasEstudiantes")
    
    rachasEstudiantes.getOrPut("Luis") { 0 }
    println("Asegurando racha para Luis: $rachasEstudiantes")
    
    rachasEstudiantes.getOrPut("Ana") { 0 }
    println("Asegurando racha para Ana (ya existe): $rachasEstudiantes")
}
