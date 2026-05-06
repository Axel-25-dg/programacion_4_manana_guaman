package com.ute.compose.ui.material3

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp

@Composable
fun Paso01SumaScreen() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .verticalScroll(rememberScrollState()),
        verticalArrangement = Arrangement.spacedBy(24.dp)
    ) {
        Text(
            text = "Ejercicio: Operación de Suma",
            style = MaterialTheme.typography.headlineSmall,
            color = MaterialTheme.colorScheme.primary
        )

        HorizontalDivider()

        // Llamada al componente de cálculo
        SeccionCalculoSumar()
    }
}

@Composable
private fun SeccionCalculoSumar() {
    // Estados para los inputs de texto
    var numero1 by remember { mutableStateOf("") }
    var numero2 by remember { mutableStateOf("") }

    // Lógica: Convertimos el texto a número. Si está vacío o es inválido, usamos 0.0
    val valor1 = numero1.toDoubleOrNull() ?: 0.0
    val valor2 = numero2.toDoubleOrNull() ?: 0.0
    val resultado = valor1 + valor2

    Column(verticalArrangement = Arrangement.spacedBy(16.dp)) {

        // Campo Primer Número
        OutlinedTextField(
            value = numero1,
            onValueChange = { input ->
                // Validación: Solo permitir números y un punto decimal
                if (input.all { it.isDigit() || it == '.' }) numero1 = input
            },
            label = { Text("Primer número (A)") },
            placeholder = { Text("Ej: 10.5") },
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Decimal,
                imeAction = ImeAction.Next
            ),
            modifier = Modifier.fillMaxWidth(),
            singleLine = true
        )

        // Campo Segundo Número
        OutlinedTextField(
            value = numero2,
            onValueChange = { input ->
                if (input.all { it.isDigit() || it == '.' }) numero2 = input
            },
            label = { Text("Segundo número (B)") },
            placeholder = { Text("Ej: 5") },
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Decimal,
                imeAction = ImeAction.Done
            ),
            modifier = Modifier.fillMaxWidth(),
            singleLine = true
        )

        // Tarjeta para mostrar el resultado
        Card(
            colors = CardDefaults.cardColors(
                containerColor = MaterialTheme.colorScheme.primaryContainer
            ),
            modifier = Modifier
                .fillMaxWidth()
                .padding(top = 8.dp)
        ) {
            Column(
                modifier = Modifier.padding(24.dp),
                horizontalAlignment = androidx.compose.ui.Alignment.CenterHorizontally
            ) {
                Text(
                    text = "RESULTADO",
                    style = MaterialTheme.typography.labelLarge,
                    color = MaterialTheme.colorScheme.onPrimaryContainer
                )
                Text(
                    text = "$resultado",
                    style = MaterialTheme.typography.displayMedium,
                    color = MaterialTheme.colorScheme.primary
                )
            }
        }

        // Botón de limpieza opcional
        TextButton(
            onClick = {
                numero1 = ""
                numero2 = ""
            },
            modifier = Modifier.fillMaxWidth(),
            enabled = numero1.isNotEmpty() || numero2.isNotEmpty()
        ) {
            Text("Limpiar campos")
        }
    }
}

@Preview(showBackground = true)
@Composable
fun Paso01Suma_Preview() {
    MaterialTheme {
        Paso01SumaScreen()
    }
}