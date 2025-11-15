import 'package:ecommerce_app/core/api_response/api_response.dart';
import 'package:ecommerce_app/features/main_layout/data/data_source/data_source.dart';
import 'package:ecommerce_app/features/main_layout/data/models/category_response.dart';
import 'package:ecommerce_app/features/main_layout/data/repo/repo.dart';
import 'package:ecommerce_app/features/products_screen/data/models/product_response.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/product_entity.dart';
import 'package:injectable/injectable.dart';


@Injectable(as:MainRepo )
class MainRepoImp implements MainRepo{

  final MainDataSource _dataSource;

  MainRepoImp(this._dataSource);

  @override
  Future<ApiResponse<List<CategoryModel>>> getCategory()async {
    try{
      var response = await _dataSource.getCategory();
      if(response.statusCode == 200){
        var data = CategoryResponse.fromJson(response.data);
        return Success(data: data.data??[]);
      }else{
        return Error(error: response.data["message"]);
      }
    }catch(e){
      return Error(error: e.toString());
    }
  }

  @override
  Future<ApiResponse<List<ProductEntity>>> getFav()async {
    try{
      List<ProductEntity> products = [];
      var response = await _dataSource.getFav();

      if(response.statusCode == 200){
        var data = ProductResponse.fromJson(response.data);

        for(var e in data.data!){
          products.add(e.toDomain());
        }

        return Success(data: products);
      }else{
        return Error(error: response.data["message"]);
      }
    }catch(e){
      return Error(error: e.toString());

    }
  }



}