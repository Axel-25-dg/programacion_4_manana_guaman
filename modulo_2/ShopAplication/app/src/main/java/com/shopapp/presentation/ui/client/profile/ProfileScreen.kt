package com.shopapp.presentation.ui.client.profile

import android.net.Uri
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.PickVisualMediaRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowForward
import androidx.compose.material.icons.automirrored.filled.Logout
import androidx.compose.material.icons.automirrored.filled.Send
import androidx.compose.material.icons.filled.CameraAlt
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import coil.compose.AsyncImage
import coil.request.ImageRequest
import com.shopapp.presentation.viewmodel.AuthViewModel
import com.shopapp.presentation.viewmodel.ProfileViewModel
import com.shopapp.theme.*

@Composable
fun ProfileScreen(
    authViewModel:      AuthViewModel,
    onLogout:           () -> Unit,
    onSendNotification: () -> Unit = {},
    viewModel:          ProfileViewModel = hiltViewModel(),
) {
    val state by viewModel.state.collectAsState()
    val user = state.profile
    val isUploading = state.isUploading

    val snackbarHostState = remember { SnackbarHostState() }

    // Manejo de mensajes del ViewModel
    LaunchedEffect(Unit) {
        viewModel.snackbar.collect { message ->
            snackbarHostState.showSnackbar(message)
            if (message.contains("correctamente")) {
                authViewModel.refreshProfile()
            }
        }
    }

    Scaffold(
        snackbarHost = { SnackbarHost(snackbarHostState) },
        containerColor = Background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .verticalScroll(rememberScrollState())
                .padding(24.dp),
        ) {
            // ── Avatar y nombre ───────────────────────────────────
            Column(
                modifier            = Modifier
                    .fillMaxWidth()
                    .padding(vertical = 24.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
            ) {
                AvatarSection(
                    avatarUrl       = state.avatarUrl,
                    username        = user?.username ?: "",
                    isUploading     = isUploading,
                    onImageSelected = { uri -> viewModel.uploadAvatar(uri) }
                )

                Spacer(Modifier.height(16.dp))
                Text(
                    text       = user?.username ?: "—",
                    style      = MaterialTheme.typography.headlineMedium,
                    fontWeight = FontWeight.Bold,
                    color      = TextPrimary,
                )
                Text(
                    text  = user?.email ?: "—",
                    style = MaterialTheme.typography.bodyMedium,
                    color = TextSecondary,
                )
                Spacer(Modifier.height(8.dp))
                if (user?.isStaff == true) {
                    Surface(
                        color  = Accent.copy(alpha = 0.15f),
                        shape  = MaterialTheme.shapes.extraSmall,
                    ) {
                        Text(
                            text       = "Staff",
                            color      = Accent,
                            fontSize   = 11.sp,
                            fontWeight = FontWeight.Bold,
                            modifier   = Modifier.padding(horizontal = 12.dp, vertical = 4.dp),
                            letterSpacing = 0.8.sp,
                        )
                    }
                }
            }


            // ── Info del usuario ──────────────────────────────────
            Surface(
                color    = Surface,
                shape    = MaterialTheme.shapes.large,
                modifier = Modifier.fillMaxWidth(),
            ) {
                Column(modifier = Modifier.padding(16.dp)) {
                    Text(
                        text      = "Información de la cuenta",
                        style     = MaterialTheme.typography.labelSmall,
                        color     = TextSecondary,
                        letterSpacing = 0.8.sp,
                        modifier  = Modifier.padding(bottom = 12.dp),
                    )

                    listOf(
                        "ID de usuario" to (user?.id?.toString() ?: "—"),
                        "Usuario"       to (user?.username ?: "—"),
                        "Email"         to (user?.email ?: "—"),
                        "Rol"           to (if (user?.isStaff == true) "Administrador" else "Cliente"),
                    ).forEachIndexed { i, (label, value) ->
                        Row(
                            modifier              = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 10.dp),
                            horizontalArrangement = Arrangement.SpaceBetween,
                        ) {
                            Text(
                                text  = label,
                                style = MaterialTheme.typography.bodyMedium,
                                color = TextSecondary,
                            )
                            Text(
                                text       = value,
                                style      = MaterialTheme.typography.bodyMedium,
                                fontWeight = FontWeight.SemiBold,
                                color      = TextPrimary,
                            )
                        }
                        if (i < 3) HorizontalDivider(color = BorderLight, thickness = 0.5.dp)
                    }
                }
            }

            if (user?.isStaff == true) {
                Spacer(Modifier.height(24.dp))
                HorizontalDivider(color = BorderLight, thickness = 0.5.dp)

                ListItem(
                    headlineContent = {
                        Text("Enviar notificación", fontWeight = FontWeight.Medium)
                    },
                    supportingContent = {
                        Text("Envía un correo a uno o todos los usuarios")
                    },
                    leadingContent = {
                        Icon(
                            imageVector = Icons.AutoMirrored.Filled.Send,
                            contentDescription = null,
                            tint = MaterialTheme.colorScheme.primary,
                        )
                    },
                    trailingContent = {
                        Icon(
                            imageVector = Icons.AutoMirrored.Filled.ArrowForward,
                            contentDescription = null,
                        )
                    },
                    colors = ListItemDefaults.colors(containerColor = Surface),
                    modifier = Modifier.clickable(onClick = onSendNotification),
                )

                HorizontalDivider(color = BorderLight, thickness = 0.5.dp)
            }

            Spacer(Modifier.height(24.dp))

            // ── Botón cerrar sesión ───────────────────────────────
            var showConfirm by remember { mutableStateOf(false) }

            OutlinedButton(
                onClick  = { showConfirm = true },
                modifier = Modifier.fillMaxWidth().height(52.dp),
                colors   = ButtonDefaults.outlinedButtonColors(contentColor = Error),
                border   = BorderStroke(
                    width = 1.dp,
                    color = Error.copy(alpha = 0.5f)
                ),
                shape    = MaterialTheme.shapes.medium,
            ) {
                Icon(Icons.AutoMirrored.Filled.Logout, contentDescription = null, modifier = Modifier.size(18.dp))
                Spacer(Modifier.width(8.dp))
                Text("Cerrar sesión", fontWeight = FontWeight.SemiBold)
            }

            // Diálogo de confirmación
            if (showConfirm) {
                AlertDialog(
                    onDismissRequest = { showConfirm = false },
                    title            = { Text("¿Cerrar sesión?", color = TextPrimary) },
                    text             = { Text("Tu sesión se cerrará en este dispositivo.", color = TextSecondary) },
                    confirmButton    = {
                        TextButton(onClick = {
                            showConfirm = false
                            authViewModel.logout()
                            onLogout()
                        }) {
                            Text("Cerrar sesión", color = Error, fontWeight = FontWeight.Bold)
                        }
                    },
                    dismissButton    = {
                        TextButton(onClick = { showConfirm = false }) {
                            Text("Cancelar", color = TextSecondary)
                        }
                    },
                    containerColor   = Surface,
                    shape            = MaterialTheme.shapes.large,
                )
            }
        }
    }
}