/**
 * Operadores de comparacion para metas de aprendizaje
 * Ejemplo MP - 07
 */
fun main() {
    println("Verificacion de Metas Diarias")
    val palabrasMeta = 20
    val palabrasAprendidas = 25

    println("Meta alcanzada? (==): ${palabrasAprendidas == palabrasMeta}")
    println("Superoo la meta? (>): ${palabrasAprendidas > palabrasMeta}")
    println("Al menos alcanzo la meta? (>=): ${palabrasAprendidas >= palabrasMeta}")
    println("Aun no llega a la meta? (<): ${palabrasAprendidas < palabrasMeta}")
    
    val idiomaActual = "Frances"
    val idiomaRequerido = "Ingles"
    println("Es el idioma correcto? (.equals): ${idiomaActual.equals(idiomaRequerido)}")
}
