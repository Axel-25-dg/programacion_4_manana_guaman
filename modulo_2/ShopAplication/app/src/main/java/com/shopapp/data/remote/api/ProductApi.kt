package com.shopapp.data.remote.api

import com.shopapp.data.remote.dto.*
import okhttp3.MultipartBody
import retrofit2.Response
import retrofit2.http.*

interface ProductApi {
    @GET("products/")
    suspend fun getProducts(
        @QueryMap filters: Map<String, String>,
    ): Response<PaginatedDto<ProductDto>>

    @GET("products/{id}/")
    suspend fun getProduct(@Path("id") id: Int): Response<ProductDto>

    @GET("products/available/")
    suspend fun getAvailable(): Response<PaginatedDto<ProductDto>>

    @POST("products/")
    suspend fun createProduct(@Body body: ProductRequestDto): Response<ProductDto>

    @PATCH("products/{id}/")
    suspend fun updateProduct(
        @Path("id") id: Int,
        @Body body: ProductRequestDto,
    ): Response<ProductDto>

    @DELETE("products/{id}/")
    suspend fun deleteProduct(@Path("id") id: Int): Response<Unit>

    @POST("products/{id}/restock/")
    suspend fun restock(
        @Path("id") id: Int,
        @Body body: RestockRequestDto,
    ): Response<RestockResponseDto>

    @GET("products/stats/")
    suspend fun getStats(): Response<ProductStatsDto>

    /**
     * Sube o reemplaza la imagen de un producto.
     * Solo accesible para usuarios con is_staff = true.
     * Backend: PATCH /api/products/{id}/  multipart/form-data campo "image"
     */
    @Multipart
    @PATCH("products/{id}/")
    suspend fun uploadProductImage(
        @Path("id") id: Int,
        @Part image: MultipartBody.Part,
    ): Response<ProductDto>
}