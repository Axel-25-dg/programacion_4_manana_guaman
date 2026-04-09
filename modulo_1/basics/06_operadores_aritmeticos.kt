fun main() {
    println("Operador Aritmetico")
    val numero1 = 10
    val numero2 = 5

    println("Suma:")
    println("$numero1 + $numero2 = ${numero1 + numero2}")

    println("Resta:")
    println("$numero1 - $numero2 = ${numero1 - numero2}")

    println("Multiplicacion:")
    println("$numero1 * $numero2 = ${numero1 * numero2}")

    println("Division:")
    println("$numero1 / $numero2 = ${numero1 / numero2}")

    println("Modulo:")
    println("$numero1 % $numero2 = ${numero1 % numero2}")

    println("Operadores de Asignacion Compuesta")
    var x = 10

    x += 5
    println("x += 5: $x")

    x -= 3
    println("x -= 5: $x")

    x *= 5
    println("x *= 5: $x")

    x /= 2
    println("x /= 5: $x")

    x %= 2
    println("x %= 5: $x")

    // incremento y decremento
    x++
    println("x++: $x")
    x--
    println("x--: $x")
}

