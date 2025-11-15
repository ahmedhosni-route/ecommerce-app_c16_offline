import 'package:dio/src/response.dart';
import 'package:ecommerce_app/core/services/dio_service.dart';
import 'package:ecommerce_app/features/products_screen/data/data_source/data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDataSource)
class ProductDataSourceImp implements ProductDataSource {
  final DioService _dioService;
  ProductDataSourceImp(this._dioService);
  @override
  Future<Response> getProducts(String categoryId) {
    return _dioService.dio
        .get("/products", queryParameters: {"category[in]": categoryId});
  }

  @override
  Future<Response> addFav(String productId) {
    return _dioService.dio
        .post("/wishlist", data: {"productId":productId});
  }
}
