import 'package:e_commerce/bloc/home/home_bloc.dart';
import 'package:e_commerce/bloc/home/home_event.dart';
import 'package:e_commerce/bloc/home/home_state.dart';
import 'package:e_commerce/widgets/home/products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state.error != null) {
              return Center(child: Text(state.error!));
            }
            return SingleChildScrollView(
              child: Column(
                spacing: 15.0,
                children: [
                  // Beverage products
                  ProductsWidget(
                    title: "Beverages", 
                    products: state.products.where((element) => element.categoryId == 1,).toList(),
                  ),
                  // Junk food products
                  ProductsWidget(
                    title: "Junk Foods", 
                    products: state.products.where((element) => element.categoryId == 2,).toList()
                  ),
                  // Snacsk
                  ProductsWidget(
                    title: "Snacks", 
                    products: state.products.where((element) => element.categoryId == 3,).toList()
                  ),
                  ProductsWidget(
                    title: "Non-Veg", 
                    products: state.products.where((element) => element.categoryId == 4,).toList()
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}