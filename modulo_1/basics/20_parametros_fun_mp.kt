fun main() {
    println("Registro de Estudiantes con Parametros por Defecto")
    println(registrarEstudiante("Henry", 22, "Japones", true))
    println(registrarEstudiante("Luis"))
    println(registrarEstudiante("Maria", 25))
    println(registrarEstudiante("Ana", 19, "Frances"))
    
    println(registrarEstudiante(idioma = "Aleman", nombre = "Carlos", activo = false))
}

fun registrarEstudiante( 
    nombre: String,
    edad: Int = 18,
    idioma: String = "Ingles",
    activo: Boolean = true
): String {
    return "Estudiante: $nombre, Edad: $edad, Idioma: $idioma, Estado: ${if (activo) "Activo" else "Inactivo"}"
}
