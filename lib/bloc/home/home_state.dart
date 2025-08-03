import 'package:e_commerce/data/model/products_model.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final List<ProductsModel> products;

  HomeState({
    this.isLoading = false,
    this.error,
    this.products = const [],
  });

  HomeState copywith({
    bool? isLoading,
    String? error,
    List<ProductsModel>? products,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      products: products ?? this.products
    );
  }
}
