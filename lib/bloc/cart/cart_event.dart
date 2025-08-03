import 'package:e_commerce/data/model/cart_model.dart';

abstract class CartEvent {}

class LoadCartProducts extends CartEvent {}

class CartUpdated extends CartEvent {
  final List<CartModel> items;
  CartUpdated(this.items);
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
