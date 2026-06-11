package com.shopapp.domain.model

data class User(
    val id:         Int,
    val username:   String,
    val email:      String,
    val firstName:  String,
    val lastName:   String,
    val isStaff:    Boolean,
    val isActive:   Boolean,
    val dateJoined: String,
    val numOrders:  Int,
    val avatarUrl:  String? = null,    // ← nuevo campo
)

data class UserPayload(
    val username: String,
    val email: String,
    val firstName: String,
    val lastName: String,
    val isStaff: Boolean,
    val isActive: Boolean,
    val password: String? = null,
)