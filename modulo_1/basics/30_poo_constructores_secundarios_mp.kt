class TarjetaEstudio(val termino: String, val definicion: String) {
    val longitudTermino: Int get() = termino.length

    constructor(termino: String) : this(termino, "Sin definicion asignada")
    constructor(codigo: Int, termino: String, definicion: String) : this("[$codigo] $termino", definicion)

    override fun toString() = "Tarjeta: $termino -> $definicion (Longitud: $longitudTermino)"
}

fun main() {
    val t1 = TarjetaEstudio("Komorebi", "Luz del sol filtrada por los arboles")
    val t2 = TarjetaEstudio("Hygge")
    val t3 = TarjetaEstudio(101, "Ikigai", "Razon de vivir")

    println(t1)
    println(t2)
    println(t3)
}
