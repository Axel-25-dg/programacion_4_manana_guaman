fun main() {
    print("Ingrese el tipo de leccion (Gramatica / Vocabulario): ")
    val tipoLeccion = readLine()?.trim()
    if (tipoLeccion?.equals("Gramatica", ignoreCase = true) == true) {
        println("Recomendacion: Repasa las reglas de conjugacion antes de empezar.")
    } else if (tipoLeccion?.equals("Vocabulario", ignoreCase = true) == true) {
        println("Recomendacion: Usa las tarjetas de memoria para memorizar nuevas palabras.")
    } else {
        println("Tipo de leccion no reconocido en el sistema.")
    }
}
