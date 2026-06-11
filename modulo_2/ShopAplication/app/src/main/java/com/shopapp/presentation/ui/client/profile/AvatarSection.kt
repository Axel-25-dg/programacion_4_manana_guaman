package com.shopapp.presentation.ui.client.profile

import android.net.Uri
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CameraAlt
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import coil.compose.SubcomposeAsyncImage
import coil.request.ImageRequest

/**
 * Avatar circular del usuario con selector de imagen al pulsarlo.
 *
 * @param avatarUrl       URL absoluta del avatar actual (puede ser null).
 * @param username        Nombre de usuario para calcular iniciales y color de fondo.
 * @param isUploading     true mientras se está enviando el nuevo avatar al servidor.
 * @param onImageSelected Se invoca con la URI seleccionada por el usuario.
 */
@Composable
fun AvatarSection(
    avatarUrl:       String?,
    username:        String,
    isUploading:     Boolean,
    onImageSelected: (Uri) -> Unit,
    modifier:        Modifier = Modifier,
) {
    val launcher = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.GetContent()
    ) { uri: Uri? ->
        uri?.let { onImageSelected(it) }
    }

    Box(
        contentAlignment = Alignment.BottomEnd,
        modifier         = modifier.size(100.dp),
    ) {
        Box(
            modifier = Modifier
                .size(100.dp)
                .clip(CircleShape)
                .border(2.dp, MaterialTheme.colorScheme.primary, CircleShape)
                .clickable(enabled = !isUploading) { launcher.launch("image/*") },
        ) {
            if (!avatarUrl.isNullOrBlank()) {
                SubcomposeAsyncImage(
                    model = ImageRequest.Builder(LocalContext.current)
                        .data(avatarUrl)
                        .crossfade(true)
                        .build(),
                    contentDescription = "Avatar de $username",
                    contentScale       = ContentScale.Crop,
                    modifier           = Modifier.fillMaxSize(),
                    loading = {
                        Box(
                            contentAlignment = Alignment.Center,
                            modifier         = Modifier
                                .fillMaxSize()
                                .background(avatarBackground(username)),
                        ) {
                            CircularProgressIndicator(
                                modifier    = Modifier.size(24.dp),
                                color       = Color.White,
                                strokeWidth = 2.dp,
                            )
                        }
                    },
                    error = { InitialsAvatar(username) },
                )
            } else {
                InitialsAvatar(username)
            }

            AnimatedVisibility(
                visible  = isUploading,
                enter    = fadeIn(),
                exit     = fadeOut(),
                modifier = Modifier.fillMaxSize(),
            ) {
                Box(
                    contentAlignment = Alignment.Center,
                    modifier         = Modifier
                        .fillMaxSize()
                        .background(Color.Black.copy(alpha = 0.50f)),
                ) {
                    CircularProgressIndicator(
                        color       = Color.White,
                        modifier    = Modifier.size(28.dp),
                        strokeWidth = 2.dp,
                    )
                }
            }
        }

        if (!isUploading) {
            Surface(
                shape          = CircleShape,
                color          = MaterialTheme.colorScheme.primaryContainer,
                tonalElevation = 4.dp,
                modifier       = Modifier
                    .size(28.dp)
                    .clickable { launcher.launch("image/*") },
            ) {
                Icon(
                    imageVector        = Icons.Default.CameraAlt,
                    contentDescription = "Cambiar avatar",
                    tint               = MaterialTheme.colorScheme.onPrimaryContainer,
                    modifier           = Modifier.padding(4.dp).fillMaxSize(),
                )
            }
        }
    }
}

@Composable
private fun InitialsAvatar(username: String) {
    Box(
        contentAlignment = Alignment.Center,
        modifier         = Modifier
            .fillMaxSize()
            .background(avatarBackground(username)),
    ) {
        Text(
            text       = username.take(2).uppercase(),
            color      = Color.White,
            fontSize   = 32.sp,
            fontWeight = FontWeight.Bold,
        )
    }
}

private fun avatarBackground(username: String): Color {
    val hue = (username.hashCode().and(0x7FFFFFFF) % 360).toFloat()
    return Color.hsl(hue = hue, saturation = 0.55f, lightness = 0.45f)
}