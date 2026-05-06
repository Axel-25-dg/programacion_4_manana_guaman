// MainActivity.kt
package com.ute.compose

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.material3.MaterialTheme
import com.ute.compose.ui.material3.Paso01SumaScreen
import com.ute.compose.ui.material3.Paso01TextFieldScreen
import com.ute.compose.ui.material3.Paso02CardScreen
import com.ute.compose.ui.screens.*

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
                Paso01SumaScreen()
                //Paso02CardScreen()
                // Paso03_LazyColumnScreen()
                // Paso04_ScaffoldScreen()
                // Paso05_NavBarScreen()
                // Paso06_DialogosScreen()
            }
        }
    }
}