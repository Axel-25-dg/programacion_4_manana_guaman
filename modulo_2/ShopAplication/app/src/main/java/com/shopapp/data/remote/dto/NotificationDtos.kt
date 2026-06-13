package com.shopapp.data.remote.dto

import com.google.gson.annotations.SerializedName

/** Cuerpo del POST /api/emails/send/ */
data class SendNotificationDto(
    @SerializedName("subject") val subject: String,
    @SerializedName("message") val message: String,
    @SerializedName("user_id") val userId:  Int? = null,  // null → envío masivo
)

/**
 * Respuesta { "detail": "Correo enviado a N usuario(s).", "sent": N, "failed": M }
 */
data class NotificationResultDto(
    @SerializedName("detail") val detail: String,
    @SerializedName("sent")   val sent:   Int,
    @SerializedName("failed") val failed: Int,
)
