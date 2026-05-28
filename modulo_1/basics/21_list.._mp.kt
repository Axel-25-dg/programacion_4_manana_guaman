fun main() {
    println("Gestion de Lecciones y Vocabulario (Listas Inmutables)")
    val lecciones = listOf("Gramatica 1", "Vocabulario A1", "Escucha Activa", "Pronunciacion", "Lectura Comprensiva")
    
    println("Total de lecciones: ${lecciones.size}")
    println("Primera leccion: ${lecciones.first()}")
    println("Ultima leccion: ${lecciones.last()}")
    
    println("Leccion en posicion 2: ${lecciones.get(2)}")
    println("Indice de 'Escucha Activa': ${lecciones.indexOf("Escucha Activa")}")
    println("¿Existe 'Gramatica 1'? ${"Gramatica 1" in lecciones}")

    println("Modulo inicial: ${lecciones.subList(0, 2)}")
    println("Sugerencia de hoy: ${lecciones.take(3)}")
    println("Lecciones avanzadas: ${lecciones.drop(3)}")

    for (leccion in lecciones) {
        println("- $leccion")
    }

    println("\nVocabulario Personalizado (Listas Mutables)")
    val palabras = mutableListOf("Hello", "Goodbye", "Please", "Thank you")
    
    println("Vocabulario actual: $palabras")
    
    palabras.add("Sorry")
    println("Añadida palabra: $palabras")
    
    palabras.add(0, "Welcome")
    println("Añadida al inicio: $palabras")
    
    palabras.remove("Goodbye")
    println("Eliminada palabra: $palabras")
    
    palabras[1] = "Hi"
    println("Actualizada palabra: $palabras")
    
    println("\nCola de Ejercicios (ArrayDeque)")
    val colaEjercicios = ArrayDeque<String>()
    colaEjercicios.addFirst("Traduccion")
    colaEjercicios.addLast("Completar frase")
    colaEjercicios.addLast("Audio")
    println("Ejercicios pendientes: $colaEjercicios")
    
    colaEjercicios.removeFirst()
    println("Despues de completar el primero: $colaEjercicios")
    
    colaEjercicios.removeLast()
    println("Despues de cancelar el ultimo: $colaEjercicios")
}
