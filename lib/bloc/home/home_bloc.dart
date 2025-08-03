import 'package:e_commerce/bloc/home/home_event.dart';
import 'package:e_commerce/bloc/home/home_state.dart';
import 'package:e_commerce/data/model/products_model.dart';
import 'package:e_commerce/data/service/supabase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc() : super(HomeState()){
    on<LoadProducts>(_onInitalLoading);
  }
  final _supabaseService = SupabaseService();
  
  final List<ProductsModel> productsList = []; // cached

  Future<void> _onInitalLoading(LoadProducts event, Emitter<HomeState> emit) async {
    emit(state.copywith(isLoading: true, error: null));

    try {
      final products = await _supabaseService.fetchProducts();
      productsList.addAll(products);
      emit(state.copywith(isLoading: false, error: null, products: products));
    } catch (e) {
      emit(state.copywith(isLoading: false, error: e.toString(), products: []));
    }
  }
}