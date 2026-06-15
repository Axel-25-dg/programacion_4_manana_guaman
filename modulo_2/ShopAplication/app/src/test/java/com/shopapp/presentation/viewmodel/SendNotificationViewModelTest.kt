package com.shopapp.presentation.viewmodel

import com.shopapp.domain.model.NotificationResult
import com.shopapp.domain.model.User
import com.shopapp.domain.model.UserPayload
import com.shopapp.domain.repository.UserRepository
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.test.*
import org.junit.After
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test

@OptIn(ExperimentalCoroutinesApi::class)
class SendNotificationViewModelTest {

    private lateinit var viewModel: SendNotificationViewModel
    private val testDispatcher = UnconfinedTestDispatcher()

    // Mock manual simple
    private class FakeUserRepository : UserRepository {
        var shouldSucceed = true
        var lastSubject: String? = null
        var lastMessage: String? = null
        var lastUserId: Int? = null

        override suspend fun sendNotification(subject: String, message: String, userId: Int?): Result<NotificationResult> {
            lastSubject = subject
            lastMessage = message
            lastUserId = userId
            return if (shouldSucceed) {
                Result.success(NotificationResult("Enviado", 1, 0))
            } else {
                Result.failure(Exception("Error de red"))
            }
        }

        // Métodos no usados en este test
        override suspend fun getUsers(search: String?, isStaff: Boolean?, isActive: Boolean?, page: Int?) = Result.success(Pair(emptyList<User>(), 0))
        override suspend fun getUser(id: Int) = Result.failure<User>(Exception())
        override suspend fun createUser(payload: UserPayload) = Result.failure<User>(Exception())
        override suspend fun updateUser(id: Int, payload: UserPayload) = Result.failure<User>(Exception())
        override suspend fun deleteUser(id: Int) = Result.success(Unit)
        override suspend fun toggleActive(id: Int) = Result.success(true)
        override suspend fun getStats() = Result.success(emptyMap<String, Int>())
        override suspend fun getProfile() = Result.failure<User>(Exception())
        override suspend fun uploadAvatar(uri: android.net.Uri) = Result.success("")
    }

    private val fakeRepository = FakeUserRepository()

    @Before
    fun setup() {
        Dispatchers.setMain(testDispatcher)
        viewModel = SendNotificationViewModel(fakeRepository)
    }

    @After
    fun tearDown() {
        Dispatchers.resetMain()
    }

    @Test
    fun `send notification success updates state with result`() = runTest {
        viewModel.send("Test Subject", "Test Message", 123)

        val state = viewModel.state.value
        assertFalse(state.isLoading)
        assertNotNull(state.result)
        assertEquals(1, state.result?.sent)
        assertNull(state.error)
        assertEquals("Test Subject", fakeRepository.lastSubject)
        assertEquals(123, fakeRepository.lastUserId)
    }

    @Test
    fun `send notification failure updates state with error`() = runTest {
        fakeRepository.shouldSucceed = false
        viewModel.send("Subject", "Message", null)

        val state = viewModel.state.value
        assertFalse(state.isLoading)
        assertNull(state.result)
        assertEquals("Error de red", state.error)
    }

    @Test
    fun `clearResult resets result state`() = runTest {
        viewModel.send("Subject", "Message", null)
        assertNotNull(viewModel.state.value.result)

        viewModel.clearResult()
        assertNull(viewModel.state.value.result)
    }
}