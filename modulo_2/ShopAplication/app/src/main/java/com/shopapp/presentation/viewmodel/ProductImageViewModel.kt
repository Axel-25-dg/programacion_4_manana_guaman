package com.shopapp.presentation.viewmodel

import android.net.Uri
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.shopapp.domain.repository.ProductRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class ProductImageViewModel @Inject constructor(
    private val repository: ProductRepository,
) : ViewModel() {

    private val _isUploading = MutableStateFlow(false)
    val isUploading: StateFlow<Boolean> = _isUploading.asStateFlow()

    private val _uploadResult = MutableStateFlow<Result<String>?>(null)
    val uploadResult: StateFlow<Result<String>?> = _uploadResult.asStateFlow()

    fun uploadImage(productId: Int, uri: Uri) {
        if (_isUploading.value) return
        viewModelScope.launch {
            _isUploading.value  = true
            _uploadResult.value = null
            _uploadResult.value = repository.uploadProductImage(productId, uri)
            _isUploading.value  = false
        }
    }

    fun clearResult() { _uploadResult.value = null }
}