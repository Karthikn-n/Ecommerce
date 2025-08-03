import 'package:e_commerce/data/model/cart_model.dart';

class CartState {
  final bool isInitialLoading;
  final bool isAdding;
  final bool isRemoving;
  final bool isRemoved;
  final List<CartModel> cartItems;

  CartState({
    this.isAdding = false,
    this.isInitialLoading = false,
    this.isRemoving = false,
    this.isRemoved = false,
    this.cartItems = const [],
  });

  CartState copywith({
    bool? isAdding,
    bool? isInitialLoading,
    bool? isRemoved,
    bool? isRemoving,
    List<CartModel>? cartItems,
  }) {
    return CartState(
      isAdding: isAdding ?? this.isAdding,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isRemoving: isRemoving ?? this.isRemoving,
      isRemoved: isRemoved ?? this.isRemoved,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
