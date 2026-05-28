class IdiomaInmutable(val nombre: String, val codigo: String)

class RachaEstudiante(var dias: Int = 0) {
    fun incrementar() { dias++ }
    fun perderRacha() { dias = 0 }
}

class RegistroRapido(nombre: String) {
    val nombreEstudiante = nombre.trim()
}

fun main() {
    val idioma = IdiomaInmutable("Frances", "FR")
    println("Idioma: ${idioma.nombre} (${idioma.codigo})")

    val racha = RachaEstudiante(5)
    racha.incrementar()
    println("Racha actual: ${racha.dias}")
    racha.perderRacha()
    println("Racha tras olvido: ${racha.dias}")

    val registro = RegistroRapido("  Henry  ")
    println("Estudiante registrado: '${registro.nombreEstudiante}'")
}
