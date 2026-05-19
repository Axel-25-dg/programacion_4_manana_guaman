fun main(){
    println("utilidades list")
    val numeros = listOf(1,2,3,4,5,6,7,8,9,10)
    println(numeros)
    val cudrados = numeros.map { it * it }
    println(cudrados)
    val numerosTexto = numeros.map { "numero $it" }
    println(numerosTexto)


    println("filter")
    val pares = numeros.filter{it % 2 == 0 }
    println(pares)
    val mayores5 = numeros.filter {it > 5}
    println(mayores5)
    val paresMayores5 = numeros.filter{it % 2 == 0 && it > 5}
    println(paresMayores5)
    val noPares = numeros.filter { it % 2 != 0 }
    println(noPares)
    val impares = numeros.filterNot { it % 2 == 0 }
    println(impares)

    val mezcla = listOf(1, "hola", 2, "Mundo", true, 42)
    val soloString = mezcla.filterIsInstance<String>()
    println(soloString) 

    println("reduce") 
    val numeroReduce = listOf(1,2,3,4,5)
    val suma = numeroReduce.reduce { acc, i -> acc + i }
    println(suma) 
    val producto = numeroReduce.reduce { acc, i -> acc * i }
    println(producto) 

    println("fold")
    val sumaFold = numeroReduce.fold(100) { acc, i -> acc + i }
    println(sumaFold) 
    val productoFold = numeroReduce.fold(100) { acc, i -> acc * i }
    println(productoFold) 

    println("Ordenacion")
    println("Ascendente: ${numeros.sorted()}")
    println("Descendente: ${numeros.sortedDescending()}")
    println("sorter By: ${numeros.sortedBy { it % 3 }}")
    println("Agregacion")
    println("Sumatoria: ${numeros.sum()}")
    println("Promedio: ${numeros.average()}")
    println("Maximo: ${numeros.max()}")
    println("Minimo: ${numeros.min()}")
    println("Contar: ${numeros.count()}")
    println("Busqueda")
    println("Buscar: ${numeros.find { it > 4 }}")
    println("Busqueda ultimo: ${numeros.findLast { it > 4 }}")
    println("Busqueda any: ${numeros.any { it > 4 }}")
    println("Busqueda all: ${numeros.all { it > 0 }}")
    println("Busqueda none: ${numeros.none { it > 10 }}")

}