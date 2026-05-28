fun main() {
    println("Menu Interactivo de Aprendizaje")
    
    var opcion: String
    while (true) {
        println("\n--- MENU DE ESTUDIANTE ---")
        println("1. Practicar vocabulario")
        println("2. Ver racha actual")
        println("3. Tomar examen de nivel")
        println("4. Salir")
        print("Seleccione una opcion: ")
        
        opcion = readLine() ?: ""

        when (opcion) {
            "1" -> {
                println("Iniciando practica de vocabulario...")
                var palabrasEstudiadas = 0
                while (palabrasEstudiadas < 3) {
                    palabrasEstudiadas++
                    println("Palabra $palabrasEstudiadas aprendida.")
                }
            }
            "2" -> {
                println("Tu racha actual es de 15 dias. ¡Sigue asi!")
            }
            "3" -> {
                println("Preparando examen de nivel...")
                var carga = 0
                do {
                    println("Cargando contenido... $carga%")
                    carga += 25
                } while (carga <= 100)
                println("Examen listo.")
            }
            "4", "salir" -> {
                println("Cerrando sesion de aprendizaje. ¡Hasta pronto!")
                break
            }
            else -> {
                println("Opcion no valida. Intente de nuevo.")
            }
        }
    }
}
