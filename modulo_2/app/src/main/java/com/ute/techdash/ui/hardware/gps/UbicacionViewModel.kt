package com.ute.techdash.ui.hardware.gps

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch

data class UbicacionState(
    val ubicacion:      UbicacionDato? = null,
    val rastreando:     Boolean        = false,
    val error:          String?        = null,
    val historial:      List<UbicacionDato> = emptyList()
)

class UbicacionViewModel(
    private val repositorio: LocationRepository
) : ViewModel() {

    private val _state = MutableStateFlow(UbicacionState())
    val state: StateFlow<UbicacionState> = _state.asStateFlow()

    private var jobRastreo: kotlinx.coroutines.Job? = null

    fun iniciarRastreo() {
        if (_state.value.rastreando) return
        _state.update { it.copy(rastreando = true, error = null) }

        jobRastreo = viewModelScope.launch {
            try {
                repositorio.ubicacionFlow()
                    .catch { e ->
                        _state.update { it.copy(error = e.message, rastreando = false) }
                    }
                    .collect { ubicacion ->
                        _state.update { estado ->
                            estado.copy(
                                ubicacion  = ubicacion,
                                historial  = (estado.historial + ubicacion).takeLast(50)
                            )
                        }
                    }
            } catch (e: Exception) {
                _state.update { it.copy(error = e.message, rastreando = false) }
            }
        }
    }

    fun detenerRastreo() {
        jobRastreo?.cancel()
        jobRastreo = null
        _state.update { it.copy(rastreando = false) }
    }

    fun limpiarHistorial() {
        _state.update { it.copy(historial = emptyList()) }
    }

    override fun onCleared() {
        super.onCleared()
        detenerRastreo()
    }
}
