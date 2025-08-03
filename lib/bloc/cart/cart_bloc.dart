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
  }

  Future<void> _onLoadCartProducts(LoadCartProducts event, Emitter<CartState> emit) async {
    emit(state.copywith(isInitialLoading: true));

    // final userId = prefs.getString("userId")!;
    _cartSubscription?.cancel(); // cancel if already listening

    _cartSubscription = _supabaseService.fetchCartItems().listen((items) {
      add(CartUpdated(items));
    });
  }

  Future<void> _onAddProduct(AddProduct event, Emitter<CartState> emit) async {
    emit(state.copywith(isAdding: true));
    try {
      await _supabaseService.addProduct(event.newQuantity, event.cartId);
    } catch (_) {}
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
    emit(state.copywith(isRemoving: false));
  }

  void _onCartUpdated(CartUpdated event, Emitter<CartState> emit) {
    emit(state.copywith(isInitialLoading: false, cartItems: event.items));
    cartItems = event.items;
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}
