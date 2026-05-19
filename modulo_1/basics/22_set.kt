fun main(){
    println("Set inmutable")
    val numeros = setOf(1,2,3,4,5,6,7,8,1,3)
    println("numeros Set: ${numeros}")

    println("Operaciones de Conjuntos")
    val pares   = setOf(2,4,6,8,10)
    val multiplos3= setOf(3,6,9)
    println("pares Set: ${pares}")
    println("multiplos3 Set: ${multiplos3}")
    println("Union set: ${pares.union(multiplos3)}")
    println("Interseccion set: ${pares.intersect(multiplos3)}")
    println("Subraccion set: ${pares.subtract(multiplos3)}")
    println("pares set: ${pares}")
    println("multiplos3 set: ${multiplos3}")


    println("Set mutable")
    val tags = mutableSetOf ("kotlin", "python", "java", "c++")
    println(tags)
    
    tags.add("kotlin")
    println(tags)
    
    tags.add("javasrcipt")
    println(tags)
    
    tags.remove("java")
    println(tags)
    
    println("Verificar si elemnto existe ${"kotlin" in tags}")
    println("Verificar si elemnto existe ${"javascript" in tags}")

    
}