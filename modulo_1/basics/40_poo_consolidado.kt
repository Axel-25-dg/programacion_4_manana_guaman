// ABSTRACCIÓN: sealed class define los tipos posibles de notificación
sealed class Notificacion(val titulo: String, val mensaje: String) {
    abstract fun formatear(): String  // cada tipo formatea de forma distinta

    data class Email(
        val destinatario: String,
        val asunto:       String,
        val cuerpo:       String
    ) : Notificacion(asunto, cuerpo) {
        override fun formatear() =
            "📧 Email → $destinatario\n   Asunto: $titulo\n   ${mensaje.take(50)}..."
    }

    data class Push(val dispositivo: String, val icono: String = "🔔")
        : Notificacion("Push", "") {
        override fun formatear() = "$icono Push → $dispositivo: $titulo"
    }

    data class Sms(val telefono: String, val texto: String)
        : Notificacion("SMS", texto) {
        override fun formatear() = "📱 SMS → $telefono: ${texto.take(160)}"
    }

    object Silenciosa : Notificacion("", "") {
        override fun formatear() = "🔕 Notificación silenciosa"
    }
}

// ABSTRACCIÓN + POLIMORFISMO: interfaz con contrato genérico
interface EnviadorNotificacion {
    val nombre: String
    fun enviar(notificacion: Notificacion): Boolean
}

// HERENCIA: implementaciones concretas del mismo contrato
class ServicioEmail : EnviadorNotificacion {
    override val nombre = "Email"
    override fun enviar(n: Notificacion): Boolean {
        if (n !is Notificacion.Email) return false
        println("  [EMAIL] → ${n.destinatario}")
        return true
    }
}

class ServicioPush : EnviadorNotificacion {
    override val nombre = "Push"
    override fun enviar(n: Notificacion): Boolean {
        if (n !is Notificacion.Push) return false
        println("  [PUSH] → ${n.dispositivo}")
        return true
    }
}

// ENCAPSULAMIENTO: la lista de servicios es privada
class Dispatcher(private val servicios: List<EnviadorNotificacion>) {

    fun enviar(notificacion: Notificacion) {
        println(notificacion.formatear())  // POLIMORFISMO: cada tipo formatea distinto
        val exito = servicios.any { it.enviar(notificacion) }
        if (!exito) println("  ⚠️ Sin servicio disponible")
        println()
    }
}

fun main() {
    val dispatcher = Dispatcher(listOf(ServicioEmail(), ServicioPush()))

    listOf(
        Notificacion.Email("ana@test.com", "Bienvenida", "Gracias por registrarte."),
        Notificacion.Push("iPhone-Ana"),
        Notificacion.Sms("+34600000000", "Tu código es 1234"),
        Notificacion.Silenciosa
    ).forEach { dispatcher.enviar(it) }
}