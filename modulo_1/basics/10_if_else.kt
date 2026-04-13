fun main() {
    println("Controles de Flujo")
    println("Condicional If")
    print("Incluir temperatura en grados centigrados: ")
    val temperatura = readLine()?.toDoubleOrNull() ?: 36.5
    if (temperatura >= 40.0) {
        println("Fiebre alta: atencion de emergencia prioritaria")
    } else if (temperatura >= 38.0) {
        println("Fiebre detectada: derivada consulta prioritaria")
    } else {
        println("Temperatura normal")
    }
    println("temperatura registrada: $temperatura grados centigrados")
}