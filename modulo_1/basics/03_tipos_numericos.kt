fun main ()
println ("Tipos Datos ")
println ("Numeros enteros ")
val numero1  :Byte =127
println ("Numero BYte $numero1")

val numero2 : Short = 32_765
println ("Numero short $numero2")

val numero3: Int = 12_122_122_122
println ("Numero int $numero3")

val numero4 : Long =2_122_122_122_1222_123_987L
prntln ( "numero long $numero4")

val numeros5 : Float =14.3
println ("Numero Float $numero5")

val numero6: Double = 3.1415925
println ("Numero Double $numero6")






//Inferido 
val nombre ="Juana"
val edad= 56 

println("Nombre $nombre")
val nombreTipo=nombre::class.simpleName
println("Tipo inferido nombre: ${nombreTipo}")
println("Tipo inferido nombre: ${nombre::class.simpleName}")
println("Edad: $edad")
val edadTipo=edad::class.simpleName
println("Tipo inferido edad: ${edadTipo}")
println("Tipo inferido edad: ${edad::class.simpleName}")


