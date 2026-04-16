fun main(){
    println("utilidades list")
    val numeros = listOf(1,2,3,4,5,6,7,8,9,10)
    println(numeros)
    val cudrados = numeros.map { it * it }
    println(cudrados)
    val numerosTexto = numeros.map { "numero $it" }
    println(numerosTexto)

}