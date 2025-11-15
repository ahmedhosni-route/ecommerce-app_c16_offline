part of 'product_cubit.dart';

class ProductState {
  BaseState<List<ProductEntity>>? getProductState;
  ProductState({this.getProductState});

  ProductState copyWith({BaseState<List<ProductEntity>>? getProductState}) {
    return ProductState(
        getProductState: getProductState ?? this.getProductState);
  }
}
