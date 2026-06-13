package com.shopapp.domain.repository

import com.shopapp.domain.model.NotificationResult

interface NotificationRepository {
    /**
     * Envía un correo de notificación.
     * Si [userId] es null se envía a todos los usuarios activos no-staff.
     * Devuelve [Result.failure] con `403` si el usuario autenticado no es staff.
     */
    suspend fun sendNotification(
        subject: String,
        message: String,
        userId:  Int? = null,
    ): Result<NotificationResult>
}
