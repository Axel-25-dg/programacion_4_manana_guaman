open class Pregunta(val enunciado: String, val dificultad: Int) {
    open fun mostrarPregunta() = println("Pregunta ($dificultad pts): $enunciado")
    
    fun registrarIntento() = println("Intento registrado en la base de datos.")
}

class OpcionMultiple(enunciado: String, dificultad: Int, val opciones: List<String>) : Pregunta(enunciado, dificultad) {
    override fun mostrarPregunta() {
        super.mostrarPregunta()
        opciones.forEachIndexed { i, opcion -> println("  ${i + 1}. $opcion") }
    }
}

class CompletarEspacio(enunciado: String, dificultad: Int, val respuestaCorrecta: String) : Pregunta(enunciado, dificultad) {
    override fun mostrarPregunta() {
        println("Complete el espacio en blanco: $enunciado")
    }
}

fun main() {
    val p1 = OpcionMultiple("¿Cual es el plural de 'Child'?", 10, listOf("Childs", "Children", "Childrens"))
    p1.mostrarPregunta()
    p1.registrarIntento()

    val p2 = CompletarEspacio("The ___ is on the table.", 5, "book")
    p2.mostrarPregunta()
    p2.registrarIntento()
}
