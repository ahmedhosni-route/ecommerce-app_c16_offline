part of 'main_cubit.dart';

class MainState {
  BaseState<List<CategoryModel>>? getCategoryState;
  BaseState<List<ProductEntity>>? getFavState;
  MainState({
    this.getCategoryState,
    this.getFavState,
  });

  MainState copyWith({
    BaseState<List<CategoryModel>>? getCategoryState,
    BaseState<List<ProductEntity>>? getFavState,
  }) {
    return MainState(
        getCategoryState: getCategoryState ?? this.getCategoryState,
        getFavState: getFavState ?? this.getFavState);
  }
}
