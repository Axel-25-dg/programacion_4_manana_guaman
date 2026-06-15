package com.shopapp.data.remote.api

import com.shopapp.data.remote.dto.*
import okhttp3.MultipartBody
import retrofit2.Response
import retrofit2.http.*

interface UserApi {
    @GET("users/")
    suspend fun getUsers(
        @Query("search")    search:   String?,
        @Query("is_staff")  isStaff:  Boolean?,
        @Query("is_active") isActive: Boolean?,
        @Query("page")      page:     Int?,
    ): Response<PaginatedDto<UserDto>>

    @GET("users/{id}/")
    suspend fun getUser(@Path("id") id: Int): Response<UserDto>

    @POST("users/")
    suspend fun createUser(@Body body: UserRequestDto): Response<UserDto>

    @PATCH("users/{id}/")
    suspend fun updateUser(
        @Path("id") id: Int,
        @Body body: UserRequestDto,
    ): Response<UserDto>

    @DELETE("users/{id}/")
    suspend fun deleteUser(@Path("id") id: Int): Response<Unit>

    @POST("users/{id}/toggle_active/")
    suspend fun toggleActive(@Path("id") id: Int): Response<ToggleActiveResponseDto>

    @GET("users/profile/")
    suspend fun getProfile(): Response<UserDto>

    /**
     * Sube o reemplaza el avatar del usuario autenticado.
     * Backend: PATCH /api/users/profile/  multipart/form-data campo "avatar"
     */
    @Multipart
    @PATCH("users/profile/")
    suspend fun uploadAvatar(
        @Part avatar: MultipartBody.Part,
    ): Response<UserDto>

    @GET("users/stats/")
    suspend fun getStats(): Response<UserStatsDto>

    // ── Recuperación de contraseña ───────────────────────────────────────────

    /**
     * Solicita el reset de contraseña.
     * El backend siempre responde 200 (anti-enumeración de usuarios).
     * No requiere autenticación.
     * Backend: POST /api/auth/password-reset/
     */
    @POST("auth/password-reset/")
    suspend fun requestPasswordReset(
        @Body body: PasswordResetRequestDto,
    ): Response<MessageDto>

    /**
     * Confirma el reset con uid + token + nueva contraseña.
     * Devuelve 400 si el token es inválido, expirado o las contraseñas no coinciden.
     * Backend: POST /api/auth/password-reset/confirm/
     */
    @POST("auth/password-reset/confirm/")
    suspend fun confirmPasswordReset(
        @Body body: PasswordResetConfirmDto,
    ): Response<MessageDto>

    // ── Notificaciones de staff ───────────────────────────────────────────────

    /**
     * Envía un correo personalizado o masivo.
     * Requiere is_staff = true en el backend (IsAdminUser → 403 si no es staff).
     * Backend: POST /api/emails/send/
     */
    @POST("emails/send/")
    suspend fun sendNotification(
        @Body body: SendNotificationDto,
    ): Response<NotificationResultDto>
}