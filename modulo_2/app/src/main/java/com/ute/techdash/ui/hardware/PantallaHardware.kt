package com.ute.techdash.ui.hardware

import androidx.compose.foundation.layout.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CompassCalibration
import androidx.compose.material.icons.filled.SignalCellularAlt
import androidx.compose.material.icons.filled.Sensors
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import com.ute.techdash.ui.hardware.gps.LocationRepository
import com.ute.techdash.ui.hardware.gps.PantallaGPS
import com.ute.techdash.ui.hardware.gps.UbicacionViewModel
import com.ute.techdash.ui.hardware.red.BannerConectividad
import com.ute.techdash.ui.hardware.red.ConectividadRepository
import com.ute.techdash.ui.hardware.sensores.PantallaSensores
import com.ute.techdash.ui.hardware.sensores.SensoresRepository
import com.ute.techdash.ui.hardware.sensores.SensoresViewModel

@Composable
fun PantallaHardware() {
    val context = LocalContext.current
    
    // Repositorios y ViewModels (en una app real usaríamos DI como Hilt)
    val locationRepo = remember { LocationRepository(context) }
    val gpsVm: UbicacionViewModel = viewModel(factory = object : androidx.lifecycle.ViewModelProvider.Factory {
        override fun <T : androidx.lifecycle.ViewModel> create(modelClass: Class<T>): T {
            return UbicacionViewModel(locationRepo) as T
        }
    })

    val sensoresRepo = remember { SensoresRepository(context) }
    val sensoresVm: SensoresViewModel = viewModel(factory = object : androidx.lifecycle.ViewModelProvider.Factory {
        override fun <T : androidx.lifecycle.ViewModel> create(modelClass: Class<T>): T {
            return SensoresViewModel(sensoresRepo) as T
        }
    })

    val conectividadRepo = remember { ConectividadRepository(context) }

    var tabSeleccionada by remember { mutableIntStateOf(0) }

    Scaffold(
        topBar = {
            Column {
                BannerConectividad(conectividadRepo)
                TabRow(selectedTabIndex = tabSeleccionada) {
                    Tab(
                        selected = tabSeleccionada == 0,
                        onClick = { tabSeleccionada = 0 },
                        text = { Text("GPS") },
                        icon = { Icon(Icons.Default.CompassCalibration, null) }
                    )
                    Tab(
                        selected = tabSeleccionada == 1,
                        onClick = { tabSeleccionada = 1 },
                        text = { Text("Sensores") },
                        icon = { Icon(Icons.Default.Sensors, null) }
                    )
                    Tab(
                        selected = tabSeleccionada == 2,
                        onClick = { tabSeleccionada = 2 },
                        text = { Text("Dashboard") },
                        icon = { Icon(Icons.Default.SignalCellularAlt, null) }
                    )
                }
            }
        }
    ) { padding ->
        Box(Modifier.padding(padding)) {
            when (tabSeleccionada) {
                0 -> PantallaGPS(gpsVm)
                1 -> PantallaSensores(sensoresVm)
                2 -> DashboardHardware()
            }
        }
    }
}
