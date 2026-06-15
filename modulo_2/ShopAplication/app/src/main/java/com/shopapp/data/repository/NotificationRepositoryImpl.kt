package com.shopapp.data.repository

import com.shopapp.data.remote.api.UserApi
import com.shopapp.data.remote.dto.SendNotificationDto
import com.shopapp.domain.model.NotificationResult
import com.shopapp.domain.repository.NotificationRepository
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class NotificationRepositoryImpl @Inject constructor(
    private val api: UserApi,
) : NotificationRepository {

    override suspend fun sendNotification(
        subject: String,
        message: String,
        userId:  Int?,
    ): Result<NotificationResult> =
        runCatching {
            val response = api.sendNotification(SendNotificationDto(subject, message, userId))
            if (response.isSuccessful) {
                val dto = response.body() ?: error("Respuesta vacía del servidor")
                NotificationResult(dto.detail, dto.sent, dto.failed)
            } else {
                error(response.errorBody()?.string() ?: "Error ${response.code()}")
            }
        }
}
