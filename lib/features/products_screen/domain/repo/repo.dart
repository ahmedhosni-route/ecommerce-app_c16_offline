import 'package:ecommerce_app/core/api_response/api_response.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/product_entity.dart';

abstract class ProductRepo {
  Future<ApiResponse<List<ProductEntity>>> getProduct(String categoryId);
  Future<ApiResponse<bool>> addFav(String productId);
}
