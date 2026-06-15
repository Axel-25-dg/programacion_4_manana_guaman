package com.shopapp.data.repository

import android.content.Context
import android.net.Uri
import com.shopapp.data.remote.api.UserApi
import com.shopapp.data.remote.dto.SendNotificationDto
import com.shopapp.data.remote.dto.toDomain
import com.shopapp.data.remote.dto.toRequest
import com.shopapp.data.util.toMultipart
import com.shopapp.domain.model.NotificationResult
import com.shopapp.domain.model.User
import com.shopapp.domain.model.UserPayload
import com.shopapp.domain.repository.UserRepository
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class UserRepositoryImpl @Inject constructor(
    private val api: UserApi,
    @ApplicationContext private val context: Context,
) : UserRepository {

    override suspend fun getUsers(
        search:   String?,
        isStaff:  Boolean?,
        isActive: Boolean?,
        page:     Int?,
    ): Result<Pair<List<User>, Int>> = runCatching {
        val response = api.getUsers(search, isStaff, isActive, page)
        if (response.isSuccessful) {
            val body = response.body()!!
            Pair(body.results.map { it.toDomain() }, body.count)
        } else error("Error ${response.code()}")
    }

    override suspend fun getUser(id: Int): Result<User> = runCatching {
        val response = api.getUser(id)
        if (response.isSuccessful) response.body()!!.toDomain()
        else error("Error ${response.code()}")
    }

    override suspend fun createUser(payload: UserPayload): Result<User> = runCatching {
        val response = api.createUser(payload.toRequest())
        if (response.isSuccessful) response.body()!!.toDomain()
        else error("Error ${response.code()}: ${response.errorBody()?.string()}")
    }

    override suspend fun updateUser(id: Int, payload: UserPayload): Result<User> = runCatching {
        val response = api.updateUser(id, payload.toRequest())
        if (response.isSuccessful) response.body()!!.toDomain()
        else error("Error ${response.code()}: ${response.errorBody()?.string()}")
    }

    override suspend fun deleteUser(id: Int): Result<Unit> = runCatching {
        val response = api.deleteUser(id)
        if (!response.isSuccessful) error("Error ${response.code()}")
    }

    override suspend fun toggleActive(id: Int): Result<Boolean> = runCatching {
        val response = api.toggleActive(id)
        if (response.isSuccessful) response.body()!!.isActive
        else error("Error ${response.code()}")
    }

    override suspend fun getStats(): Result<Map<String, Int>> = runCatching {
        val response = api.getStats()
        if (response.isSuccessful) {
            val s = response.body()!!
            mapOf(
                "total"    to s.total,
                "active"   to s.active,
                "inactive" to s.inactive,
                "staff"    to s.staff,
            )
        } else error("Error ${response.code()}")
    }

    override suspend fun getProfile(): Result<User> = runCatching {
        val response = api.getProfile()
        if (response.isSuccessful) response.body()!!.toDomain()
        else error(response.errorBody()?.string() ?: "Error ${response.code()}")
    }

    override suspend fun uploadAvatar(uri: Uri): Result<String> = runCatching {
        val part = uri.toMultipart(context, fieldName = "avatar")
        val response = api.uploadAvatar(part)
        if (response.isSuccessful) {
            response.body()?.avatarUrl ?: error("El servidor no devolvió una URL de avatar")
        } else {
            error(response.errorBody()?.string() ?: "Error ${response.code()}")
        }
    }

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