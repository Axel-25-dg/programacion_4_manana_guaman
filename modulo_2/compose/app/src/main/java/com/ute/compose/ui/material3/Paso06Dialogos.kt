package com.ute.compose.ui.material3

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.compose.material.icons.outlined.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import com.ute.compose.model.Contacto
import com.ute.compose.model.contactosDeMuestra

// NOTA: HE ELIMINADO LA CLASE "DestinoNav" DE AQUÍ PARA EVITAR EL ERROR DE REDECLARACIÓN.
// El programa usará la que ya tienes definida en tus otros archivos.

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun Paso06DialogosScreen() {
    var contactos by remember { mutableStateOf(contactosDeMuestra) }
    var busqueda by remember { mutableStateOf("") }
    var filtro by remember { mutableStateOf("Todos") }
    var destinoActual by remember { mutableStateOf("contactos") }

    var mostrarNuevo by remember { mutableStateOf(false) }
    var contactoAEliminar by remember { mutableStateOf<Contacto?>(null) }

    val snackbarHostState = remember { SnackbarHostState() }

    val contactosFiltrados = contactos
        .filter { c -> if (filtro == "Favoritos") c.favorito else true }
        .filter { c -> busqueda.isBlank() || c.nombre.contains(busqueda, ignoreCase = true) }

    // Aquí usamos la clase DestinoNav que ya existe en tu proyecto
    val destinos = listOf(
        DestinoNav("contactos", "Contactos", Icons.Filled.People, Icons.Outlined.People),
        DestinoNav("favoritos", "Favoritos", Icons.Filled.Favorite, Icons.Outlined.FavoriteBorder),
        DestinoNav("perfil", "Perfil", Icons.Filled.AccountCircle, Icons.Outlined.AccountCircle),
    )

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Agenda (${contactos.size})", fontWeight = FontWeight.Bold) },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primaryContainer
                )
            )
        },
        bottomBar = {
            NavigationBar {
                destinos.forEach { destino ->
                    val sel = destinoActual == destino.ruta
                    NavigationBarItem(
                        selected = sel,
                        onClick = { destinoActual = destino.ruta },
                        icon = { Icon(if (sel) destino.iconoActivo else destino.iconoInactivo, null) },
                        label = { Text(destino.etiqueta) }
                    )
                }
            }
        },
        floatingActionButton = {
            if (destinoActual == "contactos") {
                FloatingActionButton(onClick = { mostrarNuevo = true }) {
                    Icon(Icons.Default.PersonAdd, null)
                }
            }
        },
        snackbarHost = { SnackbarHost(snackbarHostState) }
    ) { padding ->
        Box(modifier = Modifier.padding(padding)) {
            if (destinoActual == "contactos") {
                ContenidoContactos(
                    contactos = contactosFiltrados,
                    busqueda = busqueda,
                    onBusqueda = { busqueda = it },
                    onFavorito = { id ->
                        contactos = contactos.map { if (it.id == id) it.copy(favorito = !it.favorito) else it }
                    },
                    onEliminar = { contactoAEliminar = it }
                )
            } else {
                Text("Pantalla de $destinoActual", modifier = Modifier.align(Alignment.Center))
            }
        }
    }

    if (mostrarNuevo) {
        DialogNuevoContacto(
            onDismiss = { mostrarNuevo = false },
            onGuardar = { nuevo ->
                contactos = contactos + nuevo
                mostrarNuevo = false
            }
        )
    }

    contactoAEliminar?.let { contacto ->
        AlertDialog(
            onDismissRequest = { contactoAEliminar = null },
            title = { Text("Eliminar") },
            text = { Text("¿Deseas eliminar a ${contacto.nombre}?") },
            confirmButton = {
                TextButton(onClick = {
                    contactos = contactos.filter { it.id != contacto.id }
                    contactoAEliminar = null
                }) { Text("Eliminar", color = MaterialTheme.colorScheme.error) }
            },
            dismissButton = {
                TextButton(onClick = { contactoAEliminar = null }) { Text("Cancelar") }
            }
        )
    }
}

@Composable
private fun ContenidoContactos(
    contactos: List<Contacto>,
    busqueda: String,
    onBusqueda: (String) -> Unit,
    onFavorito: (Int) -> Unit,
    onEliminar: (Contacto) -> Unit
) {
    Column {
        OutlinedTextField(
            value = busqueda,
            onValueChange = onBusqueda,
            modifier = Modifier.fillMaxWidth().padding(16.dp),
            placeholder = { Text("Buscar...") },
            leadingIcon = { Icon(Icons.Default.Search, null) }
        )
        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(8.dp),
            contentPadding = PaddingValues(horizontal = 16.dp, vertical = 8.dp)
        ) {
            items(contactos, key = { it.id }) { contacto ->
                TarjetaContactoSimple(contacto, onFavorito, onEliminar)
            }
        }
    }
}

@Composable
private fun TarjetaContactoSimple(
    contacto: Contacto,
    onFavorito: (Int) -> Unit,
    onEliminar: (Contacto) -> Unit
) {
    ElevatedCard(Modifier.fillMaxWidth()) {
        Row(Modifier.padding(12.dp), verticalAlignment = Alignment.CenterVertically) {
            Box(
                Modifier.size(48.dp).clip(CircleShape).background(MaterialTheme.colorScheme.secondaryContainer),
                contentAlignment = Alignment.Center
            ) {
                Text(contacto.nombre.first().uppercase())
            }
            Spacer(Modifier.width(12.dp))
            Column(Modifier.weight(1f)) {
                Text(contacto.nombre, fontWeight = FontWeight.Bold)
                Text(contacto.telefono, style = MaterialTheme.typography.bodySmall)
            }
            IconButton(onClick = { onFavorito(contacto.id) }) {
                Icon(
                    if (contacto.favorito) Icons.Default.Favorite else Icons.Default.FavoriteBorder,
                    null,
                    tint = if (contacto.favorito) MaterialTheme.colorScheme.error else MaterialTheme.colorScheme.onSurface
                )
            }
            IconButton(onClick = { onEliminar(contacto) }) {
                Icon(Icons.Default.Delete, null)
            }
        }
    }
}

@Composable
private fun DialogNuevoContacto(onDismiss: () -> Unit, onGuardar: (Contacto) -> Unit) {
    var n by remember { mutableStateOf("") }
    var t by remember { mutableStateOf("") }
    Dialog(onDismissRequest = onDismiss) {
        Card {
            Column(Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
                Text("Nuevo Contacto", style = MaterialTheme.typography.titleLarge)
                OutlinedTextField(value = n, onValueChange = { n = it }, label = { Text("Nombre") })
                OutlinedTextField(value = t, onValueChange = { t = it }, label = { Text("Teléfono") })
                Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.End) {
                    TextButton(onClick = onDismiss) { Text("Cancelar") }
                    Button(onClick = {
                        onGuardar(Contacto((0..9999).random(), n, "", t, false))
                    }, enabled = n.isNotBlank()) { Text("Guardar") }
                }
            }
        }
    }
}

@Preview(showBackground = true)
@Composable
fun PreviewPaso06() {
    MaterialTheme { Paso06DialogosScreen() }
}