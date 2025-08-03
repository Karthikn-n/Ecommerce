import 'dart:async';

import 'package:e_commerce/bloc/cart/cart_event.dart';
import 'package:e_commerce/bloc/cart/cart_state.dart';
import 'package:e_commerce/data/model/cart_model.dart';
import 'package:e_commerce/data/service/supabase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final _supabaseService = SupabaseService();

  StreamSubscription<List<CartModel>>? _cartSubscription;
  List<CartModel> cartItems = [];

  CartBloc() : super(CartState()) {
    on<LoadCartProducts>(_onLoadCartProducts);
    on<AddProduct>(_onAddProduct);
    on<RemoveProduct>(_onRemoveProduct);
    on<CartUpdated>(_onCartUpdated);
    on<AddToCart>(_onAddToCart);
  }

  Future<void> _onLoadCartProducts(LoadCartProducts event, Emitter<CartState> emit) async {
    emit(state.copywith(isInitialLoading: true));

    cartItems = await _supabaseService.fetchCartItems();
    if(cartItems.isNotEmpty) {
      emit(state.copywith(isInitialLoading: false, cartItems: cartItems));
    } else {
      emit(state.copywith(isInitialLoading: false, cartItems: []));
    }
  }


  Future<void> _onAddProduct(AddProduct event, Emitter<CartState> emit) async {
    emit(state.copywith(isAdding: true));
    try {
      await _supabaseService.addProduct(event.newQuantity, event.cartId);
    } catch (_) {}
    add(CartUpdated());
    emit(state.copywith(isAdding: false));
  }

  Future<void> _onRemoveProduct(RemoveProduct event, Emitter<CartState> emit) async {
    emit(state.copywith(isRemoving: true));
    try {
      if (event.newQuantity <= 0) {
        await _supabaseService.deleteCartItem(event.cartId); // Optional deletion if 0
      } else {
        await _supabaseService.removeProduct(event.newQuantity, event.cartId);
      }
    } catch (_) {}
    add(CartUpdated());
    emit(state.copywith(isRemoving: false));
  }

  Future<void> _onCartUpdated(CartUpdated event, Emitter<CartState> emit) async{
    cartItems = await _supabaseService.fetchCartItems();
    emit(state.copywith(isInitialLoading: false, cartItems: cartItems));
  }


  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    emit(state.copywith(isAdding: true));

    try {
      // Check if product already exists in cart
      CartModel? existing;

      try {
        existing = cartItems.firstWhere(
          (item) => item.productId.id == event.productId,
        );
      } catch (_) {
        existing = null;
      }

      if (existing != null) {
        // Already exists — update quantity
        await _supabaseService.addProduct(
          existing.productCount + event.productCount,
          existing.id,
        );
      } else {
        // Doesn't exist — insert new
        await _supabaseService.insertCartItem(
          productId: event.productId,
          productCount: event.productCount,
        );
        emit(state.copywith(isAdded: true));
      }
    } catch (_) {}
    add(CartUpdated());
    emit(state.copywith(isAdding: false, isAdded: false));
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
