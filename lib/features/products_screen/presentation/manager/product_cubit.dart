import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/api_response/api_response.dart';
import 'package:ecommerce_app/core/app_dialogs/app_dialogs.dart';
import 'package:ecommerce_app/core/base_state/base_state.dart';
import 'package:ecommerce_app/features/products_screen/data/repo/repo.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/product_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/repo/repo.dart';

part 'product_state.dart';

@injectable
class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._repo) : super(ProductState());

  final ProductRepo _repo;

  Future<void> getProducts(String categoryId) async {
    emit(state.copyWith(getProductState: LoadingState()));
    var result = await _repo.getProduct(categoryId);

    switch (result) {
      case Success<List<ProductEntity>>():
        emit(state.copyWith(
            getProductState: SuccessState(data: result.data ?? [])));
      case Error<List<ProductEntity>>():
        emit(state.copyWith(getProductState: ErrorState(error: result.error)));
    }
  }

  Future<void> addFav(String productId) async {
    var result = await _repo.addFav(productId);

    switch (result) {
      case Success<bool>():
        AppDialogs.showToast(message: "Product added Success");
      case Error<bool>():
        AppDialogs.showToast(message: result.error, type: ToastType.error);
    }
  }
}
