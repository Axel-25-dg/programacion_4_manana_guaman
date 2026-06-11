package com.shopapp.presentation.ui.admin.products

import android.net.Uri
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.CameraAlt
import androidx.compose.material.icons.filled.BrokenImage
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import coil.compose.SubcomposeAsyncImage
import coil.request.ImageRequest
import com.shopapp.presentation.viewmodel.ProductImageViewModel

@Composable
fun ProductImageSection(
    productId:       Int,
    currentImageUrl: String?,          // URL actual del producto
    isStaff:         Boolean,
    onImageUpdated:  () -> Unit,       // llamado tras subida exitosa
    modifier:        Modifier = Modifier,
    imageViewModel:  ProductImageViewModel = hiltViewModel(),
) {
    val isUploading  by imageViewModel.isUploading.collectAsState()
    val uploadResult by imageViewModel.uploadResult.collectAsState()

    val snackbarHostState = remember { SnackbarHostState() }

    LaunchedEffect(uploadResult) {
        uploadResult?.let { result ->
            result
                .onSuccess {
                    onImageUpdated()
                    snackbarHostState.showSnackbar("Imagen actualizada correctamente")
                }
                .onFailure { e ->
                    snackbarHostState.showSnackbar(
                        "Error al subir imagen: ${e.message ?: "desconocido"}"
                    )
                }
            imageViewModel.clearResult()
        }
    }

    val launcher = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.GetContent()
    ) { uri: Uri? ->
        uri?.let { imageViewModel.uploadImage(productId, it) }
    }

    Box(modifier = modifier) {
        // ── Imagen principal ──────────────────────────────────────────────────
        if (!currentImageUrl.isNullOrBlank()) {
            SubcomposeAsyncImage(
                model = ImageRequest.Builder(LocalContext.current)
                    .data(currentImageUrl)
                    .crossfade(true)
                    .build(),
                contentDescription = "Imagen del producto",
                contentScale       = ContentScale.Crop,
                modifier           = Modifier.fillMaxSize(),
                loading = {
                    Box(
                        contentAlignment = Alignment.Center,
                        modifier         = Modifier.fillMaxSize(),
                    ) { CircularProgressIndicator() }
                },
                error = {
                    Box(
                        contentAlignment = Alignment.Center,
                        modifier         = Modifier.fillMaxSize().background(Color.DarkGray),
                    ) {
                        Icon(
                            imageVector        = Icons.Default.BrokenImage,
                            contentDescription = null,
                            tint               = Color.White,
                            modifier           = Modifier.size(48.dp),
                        )
                    }
                },
            )
        } else {
            Box(
                contentAlignment = Alignment.Center,
                modifier         = Modifier.fillMaxSize().background(Color.DarkGray),
            ) {
                Icon(
                    imageVector        = Icons.Default.BrokenImage,
                    contentDescription = null,
                    tint               = Color.White,
                    modifier           = Modifier.size(48.dp),
                )
            }
        }

        // ── Overlay de carga ──────────────────────────────────────────────────
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
                    .background(Color.Black.copy(alpha = 0.55f)),
            ) {
                Column(horizontalAlignment = Alignment.CenterHorizontally) {
                    CircularProgressIndicator(color = Color.White)
                    Spacer(Modifier.height(8.dp))
                    Text("Subiendo imagen...", color = Color.White)
                }
            }
        }

        // ── Botón cámara (solo staff) ─────────────────────────────────────────
        if (isStaff && !isUploading) {
            FloatingActionButton(
                onClick   = { launcher.launch("image/*") },
                modifier  = Modifier
                    .align(Alignment.BottomEnd)
                    .padding(12.dp)
                    .size(40.dp),
                shape          = CircleShape,
                containerColor = MaterialTheme.colorScheme.primary,
            ) {
                Icon(
                    imageVector        = Icons.Default.CameraAlt,
                    contentDescription = "Cambiar imagen",
                    tint               = Color.White,
                    modifier           = Modifier.size(20.dp),
                )
            }
        }

        SnackbarHost(
            hostState = snackbarHostState,
            modifier  = Modifier.align(Alignment.BottomCenter),
        )
    }
}