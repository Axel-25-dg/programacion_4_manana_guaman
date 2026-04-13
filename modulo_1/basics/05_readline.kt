fun main() {
    // Readline
    println("Ingrese su nombre: ")
    val nombre = readLine()
    println("Nombre Incluido : $nombre")

    println("Ingrese su apellido: ")
    val apellido = readLine() ?: "anonimo"
    println("Apellido Incluido : $apellido")

    /*
    Comentarios Multilinea
    Aquí es donde estaba el problema. 
    */

    // Comentarios de una sola línea

    /**
     * Comentarios KDoc (para documentación)
     * @param nombre de usuario
     * @return un saludo personalizado
     */
    
    println("Fin del programa")
}



