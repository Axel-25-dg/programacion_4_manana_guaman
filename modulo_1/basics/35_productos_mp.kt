data class NivelCurso(val id: Int, val nombre: String)

data class Leccion(
    val id: Int,
    val titulo: String,
    val xpBase: Int,
    val duracionMinutos: Int,
    val nivel: NivelCurso,
    val activa: Boolean = true
) {
    val esLarga: Boolean get() = duracionMinutos > 20
    val xpTotal: Int get() = xpBase + 10

    fun aplicarBono(porcentaje: Double): Leccion {
        require(porcentaje in 0.0..100.0)
        return copy(xpBase = (xpBase * (1 + porcentaje / 100)).toInt())
    }
}

object CatalogoLecciones {
    private val niveles = mutableListOf(
        NivelCurso(1, "A1 - Principiante"),
        NivelCurso(2, "B1 - Intermedio"),
        NivelCurso(3, "C1 - Avanzado")
    )
    private val lecciones = mutableListOf<Leccion>()
    private var siguienteId = 1

    fun agregarLeccion(titulo: String, xp: Int, minutos: Int, nivelId: Int): Leccion? {
        val nivel = niveles.find { it.id == nivelId } ?: return null
        val leccion = Leccion(siguienteId++, titulo, xp, minutos, nivel)
        lecciones.add(leccion)
        return leccion
    }

    fun listar(): List<Leccion> = lecciones.toList()
    fun activas(): List<Leccion> = lecciones.filter { it.activa }
    fun porNivel(id: Int): List<Leccion> = lecciones.filter { it.nivel.id == id }
    fun buscar(query: String): List<Leccion> =
        lecciones.filter { it.titulo.contains(query, ignoreCase = true) }
}

fun main() {
    CatalogoLecciones.agregarLeccion("Saludos Basicos", 50, 10, 1)
    CatalogoLecciones.agregarLeccion("Verbo To Be", 75, 15, 1)
    CatalogoLecciones.agregarLeccion("Conversacion en Restaurante", 150, 25, 2)
    CatalogoLecciones.agregarLeccion("Analisis de Ensayos", 300, 45, 3)
    CatalogoLecciones.agregarLeccion("Preposiciones", 80, 20, 1)

    println("=== Catalogo de Lecciones ===")
    for (l in CatalogoLecciones.listar()) {
        val icono = if (l.esLarga) "⏳" else "⚡"
        println("$icono ${l.titulo} - ${l.xpTotal} XP (${l.nivel.nombre})")
    }

    println("\n=== Lecciones A1 con Bono de Fin de Semana ===")
    CatalogoLecciones.porNivel(1)
        .map { it.aplicarBono(20.0) }
        .forEach { println("  ${it.titulo}: ${it.xpBase} XP (Bono incluido)") }
}
