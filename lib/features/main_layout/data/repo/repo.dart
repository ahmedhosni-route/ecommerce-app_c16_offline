import 'package:ecommerce_app/core/api_response/api_response.dart';
import 'package:ecommerce_app/features/main_layout/data/models/category_response.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/product_entity.dart';
import 'package:ecommerce_app/features/products_screen/presentation/widgets/product_item.dart';

abstract class MainRepo{
  Future<ApiResponse<List<CategoryModel>>> getCategory();
  Future<ApiResponse<List<ProductEntity>>> getFav();
}