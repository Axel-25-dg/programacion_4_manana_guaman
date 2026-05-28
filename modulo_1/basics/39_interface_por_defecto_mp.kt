interface Serializable {
    val id: String
    fun serializar(): String
    val version: Int get() = 1
}

interface Validable {
    val errores: List<String>
    val esValido: Boolean get() = errores.isEmpty()

    fun validar(): Boolean
    fun imprimirErrores() {
        if (errores.isEmpty()) println("Registro sin errores.")
        else errores.forEach { println("  - Error: $it") }
    }
}

data class RegistroLeccion(
    override val id: String,
    val estudiante: String,
    val leccion: String,
    val puntaje: Int
) : Serializable, Validable {

    override fun serializar() = "$id|$estudiante|$leccion|$puntaje"

    override val errores: List<String> get() = buildList {
        if (estudiante.isBlank()) add("El nombre del estudiante no puede estar vacio.")
        if (leccion.isBlank()) add("El nombre de la leccion no puede estar vacio.")
        if (puntaje < 0 || puntaje > 100) add("El puntaje debe estar entre 0 y 100.")
    }

    override fun validar() = esValido
}

fun main() {
    val registro1 = RegistroLeccion("R001", "Henry", "Vocabulario A1", 95)
    val registro2 = RegistroLeccion("R002", "", "Gramatica", 150)

    println("Registro 1:")
    println("Serializado: ${registro1.serializar()}")
    registro1.imprimirErrores()

    println("\nRegistro 2:")
    println("Serializado: ${registro2.serializar()}")
    registro2.imprimirErrores()
}
