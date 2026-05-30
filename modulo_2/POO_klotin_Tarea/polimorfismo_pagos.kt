interface MetodoPago {
    fun procesarPago(monto: Double)
}

class PagoEfectivo : MetodoPago {
    override fun procesarPago(monto: Double) {
        println("Efectivo: $monto")
    }
}

class PagoTarjeta : MetodoPago {
    override fun procesarPago(monto: Double) {
        println("Tarjeta: $monto")
    }
}

class PagoTransferencia : MetodoPago {
    override fun procesarPago(monto: Double) {
        println("Transferencia: $monto")
    }
}

fun main() {
    val metodos: List<MetodoPago> = listOf(
        PagoEfectivo(),
        PagoTarjeta(),
        PagoTransferencia()
    )
    for (m in metodos) {
        m.procesarPago(150.50)
    }
}
