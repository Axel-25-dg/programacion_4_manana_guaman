fun main() {
    println("Calculo de Descuento en Suscripcion")
    println("Es usted estudiante de intercambio? (s/n)")
    val esIntercambio = readLine()?.trim()?.lowercase() == "s"
    
    println("Ingrese su edad:")
    val edad = readLine()?.toIntOrNull() ?: 0

    if (esIntercambio) {
        println("Aplicando politica para estudiantes de intercambio")
        if (edad < 25) {
            println("Descuento del 50% aplicado.")
        } else if (edad < 35) {
            println("Descuento del 30% aplicado.")
        } else {
            println("Descuento del 10% aplicado.")
        }
    } else {
        println("Aplicando politica para estudiantes locales")
        if (edad < 18) {
            println("Descuento del 20% aplicado.")
        } else {
            println("Tarifa estandar aplicada.")
        }
    }
}
