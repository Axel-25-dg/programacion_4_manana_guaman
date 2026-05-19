package com.ute.compose.ui.material3

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.tooling.preview.Preview

@Composable
fun CompraTienda() {
    var nombreProducto by remember { mutableStateOf("") }
    var cantidad by remember { mutableStateOf("") }
    var precio by remember { mutableStateOf("") }
    var resultado by remember { mutableStateOf("") }

    Column(
        modifier = Modifier.padding(16.dp),
        verticalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        Text("Ejercicio: Compra Tienda", style = MaterialTheme.typography.titleMedium)

        OutlinedTextField(
            value = nombreProducto,
            onValueChange = { nombreProducto = it },
            label = { Text("Nombre del Producto") },
            modifier = Modifier.fillMaxWidth()
        )

        OutlinedTextField(
            value = cantidad,
            onValueChange = { cantidad = it },
            label = { Text("Cantidad") },
            modifier = Modifier.fillMaxWidth()
        )

        OutlinedTextField(
            value = precio,
            onValueChange = { precio = it },
            label = { Text("Precio Unitario") },
            modifier = Modifier.fillMaxWidth()
        )

        Button(
            onClick = {
                val cant = cantidad.toDoubleOrNull() ?: 0.0
                val prec = precio.toDoubleOrNull() ?: 0.0
                val subtotal = cant * prec

                val descuento = when {
                    subtotal > 50 -> subtotal * 0.10
                    subtotal >= 20 -> subtotal * 0.05
                    else -> 0.0
                }

                val total = subtotal - descuento

                resultado = "Producto: $nombreProducto\n" +
                        "Subtotal: $subtotal\n" +
                        "Descuento: $descuento\n" +
                        "Total a pagar: $total"
            },
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Calcular")
        }

        Text(text = resultado)
    }
}

// ESTO ES LO QUE HACE QUE LA FUNCIÓN SE USE EN LA VISTA PREVIA
@Preview(showBackground = true)
@Composable
fun PreviewCompra() {
    MaterialTheme {
        CompraTienda()
    }
}