import 'package:dio/src/response.dart';
import 'package:ecommerce_app/core/services/dio_service.dart';
import 'package:ecommerce_app/features/main_layout/data/data_source/data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MainDataSource)
class MainDataSourceImp implements MainDataSource {
  final DioService _dioService;
  MainDataSourceImp(this._dioService);

  @override
  Future<Response> getCategory() {
    return _dioService.dio.get("/categories");
  }  @override
  Future<Response> getFav() {
    return _dioService.dio.get("/wishlist");
  }
}
