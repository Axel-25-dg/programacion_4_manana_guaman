/**
 * Manejo de Strings y plantillas en el proyecto de idiomas
 * Ejemplo MP - 04
 */
fun main() {
    val nombre = "Henry"
    val apellido = "Guaman"
    val nivel = 5
    
    println("Hola, $nombre")

    println("Usuario: ${nombre.uppercase()} ${apellido.uppercase()}")
    
    val infoCurso = "Nivel del Curso: ${nivel + 1} (Proximamente)"
    println(infoCurso)
    
    val tarjetaEstudiante = """
        |DATOS DEL ESTUDIANTE
        |Nombre: $nombre $apellido
        |Nivel Actual: $nivel
        |Estado: ${if (nivel >= 1) "Activo" else "Nuevo"}
    """.trimMargin()
    
    println(tarjetaEstudiante)
}
