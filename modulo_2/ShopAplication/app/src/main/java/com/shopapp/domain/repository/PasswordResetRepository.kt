package com.shopapp.domain.repository

interface PasswordResetRepository {

    /**
     * Solicita el envío del correo de reset.
     * Siempre devuelve [Result.success] con el mensaje del backend,
     * incluso cuando el email no existe (anti-enumeración).
     */
    suspend fun requestReset(email: String): Result<String>

    /**
     * Confirma el reset con uid + token + nueva contraseña.
     * Devuelve [Result.failure] si el token es inválido o las contraseñas no coinciden.
     */
    suspend fun confirmReset(
        uid:          String,
        token:        String,
        newPassword:  String,
        newPassword2: String,
    ): Result<String>
}
