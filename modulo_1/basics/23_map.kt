fun main (){
    println("map inmutable")
    val capitales = mapOf(
        "Espana" to "Madrid",
        "Francia" to "Paris",
        "Alemania" to "Berlin",
        "Italia" to "Roma",
    )
    println(capitales["Espana"])
    println(capitales["Portugal"])
    println(capitales.getOrDefault("Espana", "Desconocido"))
    println(capitales.getOrDefault("Portugal", "Desconocido"))
    println(capitales)
    println(capitales.keys)
    println(capitales.values)
    println(capitales.entries)
    for ((pais, capital) in capitales) {
        println("$pais -> $capital")
    }

    println("map mutable")
    val inventario = mutableMapOf(
        "laptops" to 10,
        "impresoras" to 4,
        "teclados" to 12,
        "mause" to 8
    )
    inventario["monitores"] = 5
    println(inventario)
    inventario["laptops"] = 20
    println(inventario)
    inventario.remove("mause")
    println(inventario)
    inventario.getOrPut("proyector"){15}
    println(inventario)
    inventario.getOrPut("teclados"){15}
    println(inventario)
}