fun main() {
    println("Sistema de Gestion de Aprendizaje")
    
    val bienvenida = obtenerBienvenida()
    println(bienvenida)
    
    val totalPalabras = sumarPalabras(120, 45)
    println("Total de palabras aprendidas: $totalPalabras")
    
    println("Diferencia de XP: ${calcularDiferenciaXP(1000, 850)}")
    println("XP Neta: ${calcularXPNeta(500, 50)}")
    
    mostrarPerfilEstudiante("Henry")
}

fun obtenerBienvenida(): String {
    return "¡Bienvenido a tu plataforma de idiomas!"
}

fun sumarPalabras(basico: Int, avanzado: Int): Int {
    return basico + avanzado
}

fun calcularDiferenciaXP(actual: Int, anterior: Int) = actual - anterior

fun calcularXPNeta(bruta: Int, penalizacion: Int) = bruta - penalizacion

fun mostrarPerfilEstudiante(nombre: String) {
    println("Cargando perfil del estudiante: $nombre")
}
