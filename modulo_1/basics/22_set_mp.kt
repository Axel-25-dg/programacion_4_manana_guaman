fun main() {
    println("Vocabulario Unico del Estudiante (Set Inmutable)")
    val palabrasEstudiante1 = setOf("Casa", "Perro", "Gato", "Sol", "Luna", "Sol")
    println("Palabras unicas de Estudiante 1: $palabrasEstudiante1")

    println("\nComparacion de Vocabulario entre Estudiantes")
    val vocabularioA = setOf("Hola", "Adios", "Por favor", "Gracias", "Si")
    val vocabularioB = setOf("Gracias", "No", "Tal vez", "Hola")
    
    println("Vocabulario A: $vocabularioA")
    println("Vocabulario B: $vocabularioB")
    
    println("Union (Todas las palabras conocidas): ${vocabularioA.union(vocabularioB)}")
    println("Interseccion (Palabras que ambos conocen): ${vocabularioA.intersect(vocabularioB)}")
    println("Resta (Palabras que solo conoce A): ${vocabularioA.subtract(vocabularioB)}")

    println("\nIdiomas de Interes (Set Mutable)")
    val idiomasInteres = mutableSetOf("Ingles", "Frances", "Italiano", "Aleman")
    println("Idiomas actuales: $idiomasInteres")
    
    idiomasInteres.add("Ingles")
    println("Añadiendo 'Ingles' de nuevo (sin cambios): $idiomasInteres")
    
    idiomasInteres.add("Japones")
    println("Añadiendo 'Japones': $idiomasInteres")
    
    idiomasInteres.remove("Frances")
    println("Eliminando 'Frances': $idiomasInteres")
    
    println("¿Esta interesado en Aleman? ${"Aleman" in idiomasInteres}")
    println("¿Esta interesado en Chino? ${"Chino" in idiomasInteres}")
}
