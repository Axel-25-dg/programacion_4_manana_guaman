fun main() {
    print("Ingrese el tipo de examen (Laboratorio / Imagen): ")
    val tipoExamen = readLine()?.trim()
    if (tipoExamen?.equals("Laboratorio", ignoreCase = true) == true) {
        println("Preparacion: El paciente debe estar en ayunas.")
    } else if (tipoExamen?.equals("Imagen", ignoreCase = true) == true) {
        println("Preparacion: No requiere ayuno (segun indicaciones generales).")
    } else {
        println("Tipo de examen no reconocido.")
    }
}