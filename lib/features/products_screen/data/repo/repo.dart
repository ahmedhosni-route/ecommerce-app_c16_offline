import 'package:ecommerce_app/core/api_response/api_response.dart';
import 'package:ecommerce_app/features/products_screen/data/data_source/data_source.dart';
import 'package:ecommerce_app/features/products_screen/data/models/product_response.dart';

import 'package:ecommerce_app/features/products_screen/domain/entity/product_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo/repo.dart';

@Injectable(as: ProductRepo)
class ProductRepoImp implements ProductRepo {
  final ProductDataSource _dataSource;

  ProductRepoImp(this._dataSource);

  @override
  Future<ApiResponse<List<ProductEntity>>> getProduct(String categoryId) async {
    try {
      List<ProductEntity> products = [];
      var response = await _dataSource.getProducts(categoryId);
      if (response.statusCode == 200) {
        var data = ProductResponse.fromJson(response.data);
        for (var e in data.data!) {
          products.add(e.toDomain());
        }
        return Success(data: products);
      } else {
        return Error(error: response.data["message"]);
      }
    } catch (e) {
      return Error(error: e.toString());
    }
  }

  @override
  Future<ApiResponse<bool>> addFav(String productId) async {
    try {
      var response = await _dataSource.addFav(productId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(data: true);
      } else {
        return Error(error: response.data["message"]);
      }
    } catch (e) {
      return Error(error: e.toString());
    }
  }
}
