fun main() {
    println("Verificacion de Elegibilidad de Estudiante")
    val suscripcionPremium = true
    val rachaSuficiente = false
    val completoLecionesSemana = true

    println("Elegible para bono especial (Premium Y Racha)?")
    println("suscripcionPremium && rachaSuficiente = ${suscripcionPremium && rachaSuficiente}")

    println("Elegible para recordatorio (Premium O Lecciones completadas)?")
    println("suscripcionPremium || completoLecionesSemana = ${suscripcionPremium || completoLecionesSemana}")

    println("Estado de suscripcion invertido:")
    println("!suscripcionPremium = ${!suscripcionPremium}")

    val tieneBeca = true
    val esEstudianteNuevo = false
    println("Acceso a contenido gratuito (Beca O Estudiante Nuevo)?")
    println("${tieneBeca || esEstudianteNuevo}")

    val cursoCompletado = true
    val examenAprobado = true
    println("Certificado emitido? (Curso completado Y Examen aprobado)")
    println("${cursoCompletado && examenAprobado}")
}
