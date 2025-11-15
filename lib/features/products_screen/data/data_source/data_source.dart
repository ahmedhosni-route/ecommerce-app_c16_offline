import 'package:dio/dio.dart';

abstract class ProductDataSource{
  Future<Response> getProducts(String categoryId);
  Future<Response> addFav(String productId);
}