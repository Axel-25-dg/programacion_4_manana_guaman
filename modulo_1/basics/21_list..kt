fun main() {
    println("Listas-Inmueble")
    val frutas = listOf("manzana", "pera", "uva", "naranja", "mango")
    
    println("Size: ${frutas.size}")
    println("Mostrar el elemento indice 0: ${frutas[0]}")
    println("Mostrar el primer elemento: ${frutas.first()}")
    println("Mostrar el ultimo elemento: ${frutas.last()}")
    
    println("Mostrar el elemento indice 2: ${frutas.get(2)}")
    println("Mostrar indice conetnido elemento: ${frutas.indexOf("pera")}")
    println("Verificar existencia de elemento: ${frutas.contains("pera")}")
    println("Verificar existencia de un elemento: ${"pera" in frutas}")

    println("Sublista: ${frutas.subList(1, 3)}")
    println("Tomar primeros 2 elementos: ${frutas.take(2)}")
    println("Suprimir tres primeros elementos: ${frutas.drop(3)}")
    println("Tomar los ultimos dos elemntos: ${frutas.takeLast(2)}")

    for (fruta in frutas) {
        println(fruta)
    }

    println("listas-Mutable")
    val colores = mutableListOf("rojo", "verde", "azul", "amarillo", "negro")
    
    println(colores)
    
    colores.add("verde")
    println(colores)
    
    colores.add(0, "rosa")
    println(colores)
    
    colores.remove("azul")
    println(colores)
    
    colores[1] = "celeste"
    println(colores)
    
    println("Array deque")
    val deque =  ArrayDeque<Int>()
    println(deque)
    deque.addFirst(1)
    println(deque)
    deque.addLast(2)
    println(deque)
    deque.addLast(0)
    println(deque)
    deque.removeFirst()
    println(deque)
    deque.removeLast()
    println(deque)
}