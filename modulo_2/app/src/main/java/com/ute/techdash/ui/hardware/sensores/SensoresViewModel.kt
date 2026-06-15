package com.ute.techdash.ui.hardware.sensores

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch

data class SensoresState(
    val acelerometro: DatoAcelerometro? = null,
    val giroscopio:   DatoGiroscopio?   = null,
    val luz:          DatoLuz?           = null,
    val presion:      DatoPresion?       = null,
    val presionError: String?            = null,
    val activo:       Boolean            = false
)

class SensoresViewModel(
    private val repositorio: SensoresRepository
) : ViewModel() {

    private val _state = MutableStateFlow(SensoresState())
    val state: StateFlow<SensoresState> = _state.asStateFlow()

    private var jobs = listOf<kotlinx.coroutines.Job>()

    fun iniciar() {
        if (_state.value.activo) return
        _state.update { it.copy(activo = true) }

        jobs = listOf(
            viewModelScope.launch {
                repositorio.acelerometroFlow()
                    .catch { }
                    .collect { dato -> _state.update { s -> s.copy(acelerometro = dato) } }
            },
            viewModelScope.launch {
                repositorio.giroscopioFlow()
                    .catch { }
                    .collect { dato -> _state.update { s -> s.copy(giroscopio = dato) } }
            },
            viewModelScope.launch {
                repositorio.luzAmbienteFlow()
                    .catch { }
                    .collect { dato -> _state.update { s -> s.copy(luz = dato) } }
            },
            viewModelScope.launch {
                repositorio.presionFlow()
                    .catch { e -> _state.update { s -> s.copy(presionError = "Sensor no disponible") } }
                    .collect { dato -> _state.update { s -> s.copy(presion = dato) } }
            }
        )
    }

    fun detener() {
        jobs.forEach { it.cancel() }
        jobs = emptyList()
        _state.update { it.copy(activo = false) }
    }

    override fun onCleared() { super.onCleared(); detener() }
}
