data class Categoria(val id: Int, val nombre: String)

data class Producto(
    val id:        Int,
    val nombre:    String,
    val precio:    Double,
    val stock:     Int,
    val categoria: Categoria,
    val activo:    Boolean = true
) {
    // ABSTRACCION: el usuario consulta disponible sin saber la logica
    val disponible: Boolean get() = activo && stock > 0
    val precioConIva: Double get() = precio * 1.19

    // Devuelve una copia — inmutabilidad como forma de encapsulamiento
    fun aplicarDescuento(porcentaje: Double): Producto {
        require(porcentaje in 0.0..100.0) { "Descuento debe ser entre 0 y 100" }
        return copy(precio = precio * (1 - porcentaje / 100))
    }
}

// ENCAPSULAMIENTO: el estado del catalogo es privado y mutable internamente
object CatalogoProductos {
    private val categorias = mutableListOf(
        Categoria(1, "Perifericos"),
        Categoria(2, "Pantallas"),
        Categoria(3, "Audio")
    )
    private val productos   = mutableListOf<Producto>()
    private var siguienteId = 1

    fun agregarProducto(nombre: String, precio: Double, stock: Int, categoriaId: Int): Producto? {
        val categoria = categorias.find { it.id == categoriaId } ?: return null
        val producto  = Producto(siguienteId++, nombre, precio, stock, categoria)
        productos.add(producto)
        return producto
    }

    // ABSTRACCION: interfaz publica limpia — solo lectura de listas
    fun listar(): List<Producto>              = productos.toList()
    fun disponibles(): List<Producto>         = productos.filter { it.disponible }
    fun porCategoria(id: Int): List<Producto> = productos.filter { it.categoria.id == id }
    fun buscar(query: String): List<Producto> =
        productos.filter { it.nombre.contains(query, ignoreCase = true) }
}

fun main() {
    CatalogoProductos.agregarProducto("Teclado mecanico",   89.99, 15, 1)
    CatalogoProductos.agregarProducto("Mouse inalambrico",  29.99,  0, 1)
    CatalogoProductos.agregarProducto("Monitor 27\"",      349.99,  5, 2)
    CatalogoProductos.agregarProducto("Auriculares BT",    149.99,  8, 3)
    
    // Incluir 3 productos mas al final
    CatalogoProductos.agregarProducto("Memoria USB", 15.50, 20, 1)
    CatalogoProductos.agregarProducto("Microfono", 45.00, 10, 3)
    CatalogoProductos.agregarProducto("Cable HDMI", 12.00, 50, 1)

    println("=== Todos los productos ===")
    
    // Recorrer todos los productos con for
    val listaCompleta = CatalogoProductos.listar()
    for (p in listaCompleta) {
        val estado = if (p.disponible) "✅" else "❌"
        println("$estado ${p.nombre} — ${"%.2f".format(p.precioConIva)} (con IVA)")
    }

    println("\n=== Disponibles con 10% descuento ===")
    CatalogoProductos.disponibles()
        .map { it.aplicarDescuento(10.0) }
        .forEach { println("  ${it.nombre}: ${"%.2f".format(it.precio)}") }
}