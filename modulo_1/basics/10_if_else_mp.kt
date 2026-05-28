fun main() {
    println("Resultado del Examen de Idioma")
    val puntajeExamen = 65
    val puntajeAprobatorio = 70

    if (puntajeExamen >= puntajeAprobatorio) {
        println("Felicidades! Has aprobado el examen.")
        println("Puedes avanzar al siguiente nivel.")
    } else {
        println("Lo sentimos, no has alcanzado el puntaje minimo.")
        println("Te recomendamos repasar las lecciones anteriores.")
    }

    val rachaActiva = true
    if (rachaActiva) {
        println("Tu racha esta protegida.")
    } else {
        println("Cuidado! Podrias perder tu racha si no practicas hoy.")
    }
}
