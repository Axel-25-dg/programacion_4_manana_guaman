// lib/data/remote/api/product_remote_datasource.dart

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/error/api_exception.dart';
import '../../../domain/model/product.dart';
import 'dio_client.dart';

abstract class ProductRemoteDatasource {
  Future<PaginatedProducts> getProducts({
    String? search,
    int? category,
    String? ordering,
    bool? isActive,
    int page = 1,
    int pageSize = 12,
  });

  Future<Product> getProduct(int id);
}

class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final Dio _dio;

  ProductRemoteDatasourceImpl(this._dio);

  @override
  Future<PaginatedProducts> getProducts({
    String? search,
    int? category,
    String? ordering,
    bool? isActive,
    int page = 1,
    int pageSize = 12,
  }) async {
    try {
      final response = await _dio.get(
        '/products/',
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
          if (category != null) 'category': category,
          if (ordering != null && ordering.isNotEmpty) 'ordering': ordering,
          if (isActive != null) 'is_active': isActive,
          'page': page,
          'page_size': pageSize,
        },
      );
      return PaginatedProducts.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  @override
  Future<Product> getProduct(int id) async {
    try {
      final response = await _dio.get('/products/$id/');
      return Product.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}

final productDatasourceProvider = Provider<ProductRemoteDatasource>((ref) {
  return ProductRemoteDatasourceImpl(ref.watch(dioProvider));
});
