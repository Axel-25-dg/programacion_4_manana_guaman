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

    println("Controles de Flujo Iteraciones, Ciclos repetitivos-Ciclo While")
    
    println("While basico")
    var contador = 1
    while (contador <= 5) {
        println(contador)
        contador++
    }

    println("While con do-while")
    contador = 1
    do {
        println(contador)
        contador++
    } while (contador <= 5)

    println("Break continue")
    contador = 0
    while (contador < 10) {
       contador++
       if (contador == 3) continue
       if (contador == 7) break
       println(contador)
    }

    var input: String
    while (true) {
        print("Ingrese 'salir' para terminar: ")
        input = readLine() ?: ""
        if (input == "salir" || input == "") break
        println("Usted ingreso: $input")
    }
    println("While infinito")
    contador = 1
    while (true) {
        println(contador)
        if (contador >= 5) break
        contador++
    }

    println("While con break y continue")
    contador = 0
    while (contador < 10) {
       contador++
       if (contador == 3) continue
       if (contador == 7) break
       println(contador)
    }
}


// ejercicio

fun main() {    
    var input: String

    while (true) {
        print("\nSeleccione una opcion (1-saludar, 2-sumar, 3-tabla, 4-salir): ")
        input = readLine() ?: ""

        when (input) {
            "1" -> {
                println("Ejecutando: saludar ($input)")
            }
            "2" -> {
                println("Ejecutando: sumar ($input)")
            }
            "3" -> {
                println("Ejecutando: tabla ($input)")
            }
            "4", "salir" -> {
                println("Saliendo del programa...")
                break
            }
            else -> {
                println("Error: No existe la opción '$input'")
            }
        }
    }
}