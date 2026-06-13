package com.shopapp.data.remote.dto

import com.google.gson.annotations.SerializedName

/** Cuerpo del POST /api/auth/password-reset/ */
data class PasswordResetRequestDto(
    @SerializedName("email") val email: String,
)

/** Cuerpo del POST /api/auth/password-reset/confirm/ */
data class PasswordResetConfirmDto(
    @SerializedName("uid")           val uid:          String,
    @SerializedName("token")         val token:        String,
    @SerializedName("new_password")  val newPassword:  String,
    @SerializedName("new_password2") val newPassword2: String,
)

/**
 * Respuesta genérica { "detail": "..." }
 * Usada por ambos endpoints de recuperación de contraseña.
 */
data class MessageDto(
    @SerializedName("detail") val detail: String,
)
