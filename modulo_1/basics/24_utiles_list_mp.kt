fun main() {
    println("Utilidades de Transformacion de XP")
    val puntajesXP = listOf(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
    println("Lista original de XP: $puntajesXP")
    
    val xpDuplicada = puntajesXP.map { it * 2 }
    println("XP con bono duplicador: $xpDuplicada")
    
    val reporteTexto = puntajesXP.map { "Logro: $it XP" }
    println("Reporte formateado: $reporteTexto")

    println("\nFiltrado de Resultados")
    val puntajesAltos = puntajesXP.filter { it >= 70 }
    println("Lecciones con excelente desempeño: $puntajesAltos")
    
    val puntajesBajos = puntajesXP.filter { it < 50 }
    println("Lecciones que requieren repaso: $puntajesBajos")
    
    val mezclaResultados = listOf(100, "Completado", 85, "En curso", true, 92)
    val soloPuntajes = mezclaResultados.filterIsInstance<Int>()
    println("Extraccion numerica: $soloPuntajes")

    println("\nProcesamiento Acumulativo (Reduce)")
    val sumaTotalXP = puntajesXP.reduce { acumulador, xp -> acumulador + xp }
    println("Suma total de XP: $sumaTotalXP")

    println("\nProcesamiento con Valor Inicial (Fold)")
    val xpConBase = puntajesXP.fold(1000) { acumulador, xp -> acumulador + xp }
    println("XP total incluyendo base de nivel: $xpConBase")

    println("\nEstadisticas Finales")
    println("Orden ascendente: ${puntajesXP.sorted()}")
    println("Orden descendente: ${puntajesXP.sortedDescending()}")
    println("Promedio de XP: ${puntajesXP.average()}")
    println("Puntaje Maximo: ${puntajesXP.maxOrNull()}")
    println("Puntaje Minimo: ${puntajesXP.minOrNull()}")
    println("Total de lecciones evaluadas: ${puntajesXP.count()}")
    
    println("\nBusqueda de Hitos")
    println("Primer hito > 50: ${puntajesXP.find { it > 50 }}")
    println("¿Hay algun puntaje perfecto (100)? ${puntajesXP.any { it == 100 }}")
    println("¿Todos aprobaron (>60)? ${puntajesXP.all { it > 60 }}")
}
