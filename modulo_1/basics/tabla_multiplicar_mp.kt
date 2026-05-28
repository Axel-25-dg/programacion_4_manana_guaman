fun main() {
    println("Cronograma de Repeticion Espaciada (Factor 2)")
    val diaInicial = 1
    val factorOlvido = 2
    
    println("Dia | Proxima Revision")
    println("---------------------")
    for (i in 0..5) {
        val proximoDia = diaInicial + (Math.pow(factorOlvido.toDouble(), i.toDouble())).toInt()
        println(" $i  | Dia $proximoDia")
    }
}
