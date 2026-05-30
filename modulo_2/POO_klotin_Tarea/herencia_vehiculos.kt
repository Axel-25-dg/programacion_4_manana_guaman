open class Vehiculo(
    var marca: String,
    var modelo: String,
    var anio: Int
) {
    open fun mostrarDatos() {
        println("Marca: $marca")
        println("Modelo: $modelo")
        println("Anio: $anio")
    }
}

class Auto(
    marca: String,
    modelo: String,
    anio: Int,
    var numeroPuertas: Int
) : Vehiculo(marca, modelo, anio) {
    override fun mostrarDatos() {
        super.mostrarDatos()
        println("Puertas: $numeroPuertas")
    }
}

class Motocicleta(
    marca: String,
    modelo: String,
    anio: Int,
    var cilindrada: Int
) : Vehiculo(marca, modelo, anio) {
    override fun mostrarDatos() {
        super.mostrarDatos()
        println("Cilindrada: $cilindrada")
    }
}

fun main() {
    val miAuto = Auto("Toyota", "Corolla", 2022, 4)
    val miMoto = Motocicleta("Yamaha", "MT-07", 2023, 689)
    miAuto.mostrarDatos()
    miMoto.mostrarDatos()
}
