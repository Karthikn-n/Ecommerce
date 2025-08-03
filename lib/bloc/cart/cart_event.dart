abstract class CartEvent {}

class LoadCartProducts extends CartEvent {}

class CartUpdated extends CartEvent {
}

class AddProduct extends CartEvent {
  final int cartId;
  final int newQuantity;

  AddProduct({required this.cartId, required this.newQuantity});
}

class RemoveProduct extends CartEvent {
  final int cartId;
  final int newQuantity;

  RemoveProduct({required this.cartId, required this.newQuantity});
}

class AddToCart extends CartEvent {
  final int productId;
  final int productCount;

  AddToCart({required this.productId, this.productCount = 1});
}
