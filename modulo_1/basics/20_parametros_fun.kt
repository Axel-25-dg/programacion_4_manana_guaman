fun main() {
    println("Funciones-Parametros por defecto")
    println(crearUsuario("Alexander", 25, "admin", true))
    println(crearUsuario("Luis"))
    println(crearUsuario("Henry", 30))
    println(crearUsuario("Ana", 20, "admin"))
    // argumentos nombrados
    println(crearUsuario(edad = 25, nombre = "Fernafloo", activo = false))
}

fun crearUsuario( 
    nombre: String,
    edad: Int = 18,
    rol: String = "usuario",
    activo: Boolean = true
): String{
    return "Usuario creado: $nombre, Edad: $edad, Rol: $rol, Activo: $activo"
}