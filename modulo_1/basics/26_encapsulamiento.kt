class CuentaBancaria(titular: String, saldoInicial: Double) {

    val titular: String = titular       // público — cualquiera puede leer

    private var saldo: Double = saldoInicial  // privado — solo esta clase lo modifica

    internal val numeroCuenta: String =        // internal — visible en el mismo módulo
        "ES${(100000..999999).random()}"

    protected open fun calcularInteres(): Double = saldo * 0.02  // protected — visible en subclases

    // El saldo solo cambia a través de estos métodos — NUNCA directamente
    fun depositar(monto: Double) {
        require(monto > 0) { "El monto debe ser positivo" }
        saldo += monto
        println("Depositado: $${"%.2f".format(monto)} | Nuevo saldo: ${consultarSaldo()}")
    }

    fun retirar(monto: Double): Boolean {
        require(monto > 0) { "El monto debe ser positivo" }
        if (monto > saldo) {
            println("Fondos insuficientes")
            return false
        }
        saldo -= monto
        println("Retirado: $${"%.2f".format(monto)} | Nuevo saldo: ${consultarSaldo()}")
        return true
    }

    fun consultarSaldo(): String = "$${"%.2f".format(saldo)}"
}

fun main() {
    val cuenta = CuentaBancaria("Ana García", 1000.0)

    cuenta.depositar(500.0)    // Depositado: $500.00 | Nuevo saldo: $1500.00
    cuenta.retirar(200.0)      // Retirado: $200.00 | Nuevo saldo: $1300.00
    cuenta.retirar(2000.0)     // Fondos insuficientes

    println(cuenta.titular)         // Ana García — acceso público permitido
    println(cuenta.consultarSaldo()) // $1300.00
    // cuenta.saldo = 999999.0       // ERROR — saldo es privado
}