data class Idioma(
    val id: Int,
    val nombre: String,
    val nivel: String,
    val activo: Boolean = true
)

fun main() {
    val i1 = Idioma(1, "Ingles", "B1")
    val i2 = Idioma(1, "Ingles", "B1")
    val i3 = Idioma(2, "Frances", "A2")

    println("Idioma 1: $i1")
    println("¿Son iguales i1 e i2? ${i1 == i2}")

    val i4 = i1.copy(nivel = "B2")
    println("Copia con nuevo nivel: $i4")

    val (id, nombre, nivel) = i1
    println("Desestructuracion: ID $id, Nombre $nombre, Nivel $nivel")

    val idiomas = listOf(i1, i3, i4)
    idiomas.forEach { (idI, nombreI, nivelI) ->
        println("Curso [$idI]: $nombreI ($nivelI)")
    }
}
