package com.ute.techdash.ui.hardware.sensores

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.flow.map

// Datos de cada sensor
data class DatoAcelerometro(val x: Float, val y: Float, val z: Float) {
    val magnitud get() = Math.sqrt((x*x + y*y + z*z).toDouble()).toFloat()
    val inclinacion get() = Math.toDegrees(Math.atan2(y.toDouble(), x.toDouble())).toFloat()
}

data class DatoGiroscopio(val x: Float, val y: Float, val z: Float)

data class DatoLuz(val lux: Float) {
    val descripcion get() = when {
        lux < 10    -> "Muy oscuro"
        lux < 100   -> "Interior tenue"
        lux < 1000  -> "Interior iluminado"
        lux < 10000 -> "Nublado exterior"
        else        -> "Luz solar directa"
    }
}

data class DatoPresion(val hPa: Float)

// Repositorio genérico de sensores
class SensoresRepository(context: Context) {

    private val sensorManager =
        context.getSystemService(Context.SENSOR_SERVICE) as SensorManager

    // Flow para cualquier tipo de sensor
    private fun sensorFlow(tipoSensor: Int): Flow<FloatArray> = callbackFlow {
        val sensor = sensorManager.getDefaultSensor(tipoSensor)
            ?: run { close(Exception("Sensor $tipoSensor no disponible")); return@callbackFlow }

        val listener = object : SensorEventListener {
            override fun onSensorChanged(event: SensorEvent) {
                trySend(event.values.clone())
            }
            override fun onAccuracyChanged(sensor: Sensor, accuracy: Int) {}
        }

        sensorManager.registerListener(
            listener,
            sensor,
            SensorManager.SENSOR_DELAY_GAME   // ~20ms — Reto 1: Cambio a GAME
        )

        awaitClose {
            sensorManager.unregisterListener(listener)
        }
    }

    fun acelerometroFlow(): Flow<DatoAcelerometro> =
        sensorFlow(Sensor.TYPE_ACCELEROMETER).map { v ->
            DatoAcelerometro(v[0], v[1], v[2])
        }

    fun giroscopioFlow(): Flow<DatoGiroscopio> =
        sensorFlow(Sensor.TYPE_GYROSCOPE).map { v ->
            DatoGiroscopio(v[0], v[1], v[2])
        }

    fun luzAmbienteFlow(): Flow<DatoLuz> =
        sensorFlow(Sensor.TYPE_LIGHT).map { v -> DatoLuz(v[0]) }

    fun presionFlow(): Flow<DatoPresion> =
        sensorFlow(Sensor.TYPE_PRESSURE).map { v -> DatoPresion(v[0]) }

    fun sensorDisponible(tipo: Int): Boolean =
        sensorManager.getDefaultSensor(tipo) != null
}
