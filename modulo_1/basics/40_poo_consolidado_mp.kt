sealed class AlertaEstudiante(val titulo: String, val prioridad: String) {
    abstract fun generarMensaje(): String

    data class RecordatorioRacha(val dias: Int) : AlertaEstudiante("Racha en peligro", "ALTA") {
        override fun generarMensaje() = "¡Cuidado! Tu racha de $dias dias expira en 2 horas."
    }

    data class NuevaLeccion(val curso: String, val tema: String) : AlertaEstudiante("Nueva leccion", "BAJA") {
        override fun generarMensaje() = "Nueva leccion disponible en $curso: $tema."
    }

    data class LogroAlcanzado(val medalla: String) : AlertaEstudiante("¡Felicidades!", "MEDIA") {
        override fun generarMensaje() = "Has ganado la medalla: $medalla."
    }
}

interface CanalNotificacion {
    val tipo: String
    fun enviar(alerta: AlertaEstudiante): Boolean
}

class NotificadorApp : CanalNotificacion {
    override val tipo = "Notificacion In-App"
    override fun enviar(alerta: AlertaEstudiante): Boolean {
        println("[$tipo] ${alerta.generarMensaje()}")
        return true
    }
}

class NotificadorEmail(val correo: String) : CanalNotificacion {
    override val tipo = "Email"
    override fun enviar(alerta: AlertaEstudiante): Boolean {
        if (alerta.prioridad == "ALTA") {
            println("[$tipo] Enviando a $correo: ${alerta.titulo}")
            return true
        }
        return false
    }
}

class GestorAlertas(private val canales: List<CanalNotificacion>) {
    fun despachar(alerta: AlertaEstudiante) {
        println("--- Procesando Alerta: ${alerta.titulo} ---")
        canales.forEach { canal ->
            val enviado = canal.enviar(alerta)
            if (!enviado && alerta.prioridad == "ALTA") {
                println("  (!) Fallo envio por ${canal.tipo} para alerta critica")
            }
        }
        println()
    }
}

fun main() {
    val gestor = GestorAlertas(listOf(NotificadorApp(), NotificadorEmail("henry@estudiante.com")))

    val alertas = listOf(
        AlertaEstudiante.RecordatorioRacha(15),
        AlertaEstudiante.NuevaLeccion("Japones", "Particulas Ga/Wa"),
        AlertaEstudiante.LogroAlcanzado("Superviviente de 30 dias")
    )

    alertas.forEach { gestor.despachar(it) }
}
