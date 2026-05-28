package com.shopapp.data.repository

import com.shopapp.data.remote.api.ProductApi
import com.shopapp.data.remote.dto.RestockRequestDto
import com.shopapp.data.remote.dto.toDomain
import com.shopapp.data.remote.dto.toRequest
import com.shopapp.domain.model.Product
import com.shopapp.domain.model.ProductFilters
import com.shopapp.domain.model.ProductPayload
import com.shopapp.domain.repository.ProductRepository
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class ProductRepositoryImpl @Inject constructor(
    private val api: ProductApi,
) : ProductRepository {

    override suspend fun getProducts(filters: ProductFilters): Result<Pair<List<Product>, Int>> = runCatching {
        val queryMap = mutableMapOf<String, String>()
        filters.category?.let { queryMap["category"] = it.toString() }
        filters.search?.let { queryMap["search"] = it }
        filters.priceMin?.let { queryMap["min_price"] = it.toString() }
        filters.priceMax?.let { queryMap["max_price"] = it.toString() }
        filters.ordering?.let { queryMap["ordering"] = it }
        queryMap["page"] = filters.page.toString()

        val response = api.getProducts(queryMap)
        if (response.isSuccessful) {
            val body = response.body()!!
            body.results.map { it.toDomain() } to body.count
        } else {
            error("Error ${response.code()}")
        }
    }

    override suspend fun getProduct(id: Int): Result<Product> = runCatching {
        val response = api.getProduct(id)
        if (response.isSuccessful) response.body()!!.toDomain()
        else error("Error ${response.code()}")
    }

    override suspend fun createProduct(payload: ProductPayload): Result<Product> = runCatching {
        val response = api.createProduct(payload.toRequest())
        if (response.isSuccessful) response.body()!!.toDomain()
        else error("Error ${response.code()}")
    }

    override suspend fun updateProduct(id: Int, payload: ProductPayload): Result<Product> = runCatching {
        val response = api.updateProduct(id, payload.toRequest())
        if (response.isSuccessful) response.body()!!.toDomain()
        else error("Error ${response.code()}")
    }

    override suspend fun deleteProduct(id: Int): Result<Unit> = runCatching {
        val response = api.deleteProduct(id)
        if (!response.isSuccessful) error("Error ${response.code()}")
    }

    override suspend fun restock(id: Int, quantity: Int): Result<Int> = runCatching {
        val response = api.restock(id, RestockRequestDto(quantity))
        if (response.isSuccessful) response.body()!!.newStock
        else error("Error ${response.code()}")
    }

    override suspend fun getStats(): Result<Map<String, Any>> = runCatching {
        val response = api.getStats()
        if (response.isSuccessful) {
            val stats = response.body()!!
            mapOf(
                "totalActive" to stats.totalActive,
                "totalInactive" to stats.totalInactive,
                "avgPrice" to (stats.avgPrice ?: 0.0),
                "totalStock" to (stats.totalStock ?: 0)
            )
        } else {
            error("Error ${response.code()}")
        }
    }
}
