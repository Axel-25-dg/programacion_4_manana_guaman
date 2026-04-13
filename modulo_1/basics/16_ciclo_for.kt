fun main() {
    println("Controles de Flujo Iteraciones, Ciclos repetitivos-Ciclo For")

    println("For con rango")
    for (i in 1..5) {
        println(i)
    }

    println("For con until")
    for (i in 1 until 5) {
        println(i)
    }
    
    println("For con pasos")
    for (i in 1..10 step 2) {
        println(i)
    }

    println("For con decendente")
    for ( i  in 10 downTo 1 step 2) {
        println(i)
    }

    println("for con listas")
    val lista = listOf("manzana", "pera", "uva", "naranja", "mango")
    for (fruta in lista) {
        println(fruta)
    }

    println("For con listas index valor")
    for ( (index, fruta) in lista.withIndex()) {
        println("Index: $index, Fruta: $fruta")
    }

    println("for con break")
    for (i in 1..10) {
        if (i == 5) {
            break
        }
        println(i)
    }

    println("for con continue")
    for (i in 1..10) {
        if (i == 5) {
            continue
        }
        println(i)
    }

    println("for continue")
    for (i in 1..10) {
        if (i == 5) {
            continue
        if (i == 8) {
            break
        }
        }
        println(i)
    }

    val pacientes = listOf(
        Triple("Alexander, M", 37.2, 98),
        Triple("Maria, L", 38.5, 102),
        Triple("Pedro, J", 36.5, 85),
        Triple("Ana, S", 39.1, 110),
        Triple("Luis, R", 37.8, 92)
    )

    for ((Posicion, Paciente) in pacientes.withIndex()) {
        val (nombre, temperatura, spo2) = Paciente
        val alertaTem = if (temperatura > 37.5) "Fiebre" else "Normal"
        val alertaSpo2 = if (spo2 < 90) "Bajo" else "Normal"
        println("Cama $Posicion - $nombre - Temp $temperatura Gdo.Cent. $alertaTem - Spo2 $spo2 % $alertaSpo2")
    }
}
