package com.shopapp.data.repository

import com.shopapp.data.remote.api.UserApi
import com.shopapp.data.remote.dto.PasswordResetConfirmDto
import com.shopapp.data.remote.dto.PasswordResetRequestDto
import com.shopapp.domain.repository.PasswordResetRepository
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class PasswordResetRepositoryImpl @Inject constructor(
    private val api: UserApi,
) : PasswordResetRepository {

    override suspend fun requestReset(email: String): Result<String> =
        runCatching {
            val response = api.requestPasswordReset(PasswordResetRequestDto(email))
            if (response.isSuccessful) {
                response.body()?.detail ?: "Solicitud enviada"
            } else {
                error(response.errorBody()?.string() ?: "Error ${response.code()}")
            }
        }

    override suspend fun confirmReset(
        uid:          String,
        token:        String,
        newPassword:  String,
        newPassword2: String,
    ): Result<String> =
        runCatching {
            val response = api.confirmPasswordReset(
                PasswordResetConfirmDto(
                    uid          = uid,
                    token        = token,
                    newPassword  = newPassword,
                    newPassword2 = newPassword2,
                )
            )
            if (response.isSuccessful) {
                response.body()?.detail ?: "Contraseña actualizada"
            } else {
                error(response.errorBody()?.string() ?: "Error ${response.code()}")
            }
        }
}
