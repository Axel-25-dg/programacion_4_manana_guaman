class ProductoInventario(
    var codigo: String,
    var nombre: String,
    private var precio: Double,
    private var stock: Int
) {
    fun consultarPrecio() {
        println("Precio: $precio")
    }

    fun consultarStock() {
        println("Stock: $stock")
    }

    fun aumentarStock(cantidad: Int) {
        if (cantidad > 0) {
            stock += cantidad
            println("Stock: $stock")
        }
    }

    fun disminuirStock(cantidad: Int) {
        if (cantidad > 0 && stock - cantidad >= 0) {
            stock -= cantidad
            println("Stock: $stock")
        } else {
            println("Error stock")
        }
    }

    fun cambiarPrecio(nuevoPrecio: Double) {
        if (nuevoPrecio >= 0) {
            precio = nuevoPrecio
            println("Precio: $precio")
        } else {
            println("Error precio")
        }
    }
}

fun main() {
    val producto = ProductoInventario("P100", "Monitor", 350.0, 20)
    producto.consultarPrecio()
    producto.consultarStock()
    producto.aumentarStock(10)
    producto.disminuirStock(5)
    producto.cambiarPrecio(320.0)
}
