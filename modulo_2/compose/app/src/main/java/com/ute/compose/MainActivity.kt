// MainActivity.kt
package com.ute.compose

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import com.ute.compose.ui.material3.Paso02CardScreen
import com.ute.compose.ui.material3.Paso03LazyColumnScreen
import com.ute.compose.ui.material3.Paso04ScaffoldScreen
import com.ute.compose.ui.material3.Paso05NavBarScreen
import com.ute.compose.ui.material3.Paso06DialogosScreen

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme {
                // ◀ CAMBIA AQUÍ para probar cada paso:
                // S01SaludoScreen()
                // S02TextScreen()
                // S03ButtonScreen()
                // S04LayoutScreen()
                // S05ModifierScreen()
                // S06EstadoScreen()
                // S07StateHoistingScreen()
                // S08BienvenidaScreen()


                // Componetes de Material 3:
                // Paso01TextFieldScreen()
                // Paso01SumaScreen()
                // CompraTienda()
                // Paso02CardScreen()
                // Paso03LazyColumnScreen()
                // Paso04ScaffoldScreen()
                // Paso05NavBarScreen()
                Paso06DialogosScreen()
            }
        }
    }
}