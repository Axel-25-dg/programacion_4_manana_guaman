package com.shopapp.data.repository

import android.content.Context
import com.shopapp.data.remote.api.UserApi
import com.shopapp.data.remote.dto.NotificationResultDto
import com.shopapp.data.remote.dto.SendNotificationDto
import com.shopapp.domain.repository.UserRepository
import kotlinx.coroutines.test.runTest
import okhttp3.ResponseBody.Companion.toResponseBody
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.Mockito.`when`
import org.mockito.MockitoAnnotations
import org.mockito.kotlin.any
import retrofit2.Response

class UserRepositoryImplTest {

    @Mock
    private lateinit var api: UserApi

    @Mock
    private lateinit var context: Context

    private lateinit var repository: UserRepository

    @Before
    fun setup() {
        MockitoAnnotations.openMocks(this)
        repository = UserRepositoryImpl(api, context)
    }

    @Test
    fun `sendNotification success returns NotificationResult`() = runTest {
        val dto = NotificationResultDto("Success", 5, 0)
        `when`(api.sendNotification(any()))
            .thenReturn(Response.success(dto))

        val result = repository.sendNotification("Sub", "Msg", null)

        assertTrue(result.isSuccess)
        val data = result.getOrNull()
        assertNotNull(data)
        assertEquals(5, data?.sent)
        assertEquals(0, data?.failed)
    }

    @Test
    fun `sendNotification failure returns Result failure`() = runTest {
        `when`(api.sendNotification(any()))
            .thenReturn(Response.error(403, "Forbidden".toResponseBody()))

        val result = repository.sendNotification("Sub", "Msg", null)

        assertTrue(result.isFailure)
        assertEquals("Forbidden", result.exceptionOrNull()?.message)
    }
}