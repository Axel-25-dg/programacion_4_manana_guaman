fun main() {
    println("Calculo de Estadisticas de Aprendizaje")
    val xpLeccion = 150
    val bonoRacha = 50

    println("Total XP ganado en esta leccion:")
    println("$xpLeccion + $bonoRacha = ${xpLeccion + bonoRacha} XP")

    val xpTotal = 1000
    val penalizacionError = 20
    println("XP despues de penalizacion por errores:")
    println("$xpTotal - $penalizacionError = ${xpTotal - penalizacionError} XP")

    val multiplicadorPremium = 2
    println("XP con multiplicador Premium:")
    println("$xpLeccion * $multiplicadorPremium = ${xpLeccion * multiplicadorPremium} XP")

    val totalMinutosSemana = 120
    val diasEstudio = 5
    println("Promedio de minutos por dia:")
    println("$totalMinutosSemana / $diasEstudio = ${totalMinutosSemana / diasEstudio} min/dia")

    val palabrasPorPagina = 25
    val totalPalabras = 107
    println("Palabras sobrantes en la ultima pagina:")
    println("$totalPalabras % $palabrasPorPagina = ${totalPalabras % palabrasPorPagina} palabras")

    var vidas = 5
    println("Vidas iniciales: $vidas")
    vidas--
    println("Vidas tras un error: $vidas")
    
    var xpAcumulada = 500
    xpAcumulada += 100
    println("XP Acumulada tras completar reto: $xpAcumulada")
}
