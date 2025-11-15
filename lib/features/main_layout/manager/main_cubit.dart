import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/core/api_response/api_response.dart';
import 'package:ecommerce_app/core/base_state/base_state.dart';
import 'package:ecommerce_app/features/main_layout/data/data_source/data_source.dart';
import 'package:ecommerce_app/features/main_layout/data/models/category_response.dart';
import 'package:ecommerce_app/features/main_layout/data/repo/repo.dart';
import 'package:ecommerce_app/features/products_screen/domain/entity/product_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'main_state.dart';

@injectable
class MainCubit extends Cubit<MainState> {
  MainCubit(this._repo) : super(MainState());

  final MainRepo _repo;

  Future<void> getCategory() async {
    emit(state.copyWith(getCategoryState: LoadingState()));

    var result = await _repo.getCategory();

    switch (result) {
      case Success<List<CategoryModel>>():
        emit(state.copyWith(
            getCategoryState: SuccessState(data: result.data ?? [])));
      case Error<List<CategoryModel>>():
        emit(state.copyWith(getCategoryState: ErrorState(error: result.error)));
    }
  }

  Future<void> getFav() async {
    emit(state.copyWith(getFavState: LoadingState()));

    var result = await _repo.getFav();

    switch (result) {
      case Success<List<ProductEntity>>():
        emit(
            state.copyWith(getFavState: SuccessState(data: result.data ?? [])));
      case Error<List<ProductEntity>>():
        emit(state.copyWith(getFavState: ErrorState(error: result.error)));
    }
  }
}
