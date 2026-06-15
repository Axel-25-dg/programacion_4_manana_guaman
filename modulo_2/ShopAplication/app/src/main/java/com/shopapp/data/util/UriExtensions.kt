package com.shopapp.data.util

import android.content.Context
import android.net.Uri
import okhttp3.MediaType.Companion.toMediaTypeOrNull
import okhttp3.MultipartBody
import okhttp3.RequestBody.Companion.toRequestBody

/**
 * Convierte una URI de la galería en un [MultipartBody.Part] listo para Retrofit.
 * Detecta el MIME type real del archivo; si no puede determinarlo usa image/jpeg.
 */
fun Uri.toMultipart(context: Context, fieldName: String): MultipartBody.Part {
    val resolver    = context.contentResolver
    val mimeType    = resolver.getType(this) ?: "image/jpeg"
    val bytes       = resolver.openInputStream(this)?.readBytes()
        ?: error("No se pudo leer el archivo seleccionado")
    val requestBody = bytes.toRequestBody(mimeType.toMediaTypeOrNull())
    val fileName    = "upload.${mimeType.substringAfterLast('/')}"
    return MultipartBody.Part.createFormData(fieldName, fileName, requestBody)
}