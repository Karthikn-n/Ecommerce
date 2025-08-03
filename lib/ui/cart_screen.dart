import 'package:e_commerce/bloc/cart/cart_bloc.dart';
import 'package:e_commerce/bloc/cart/cart_event.dart';
import 'package:e_commerce/bloc/cart/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Cart"),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.isInitialLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Your cart is empty", style: TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }


          double total = state.cartItems.fold(0.0, (sum, item) {
            return sum + (item.productId.price * item.productCount);
          });

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = state.cartItems[index];
                    return ListTile(
                      leading: Image.network(item.productId.imageUrl, width: 50, height: 50),
                      title: Text(item.productId.title),
                      subtitle: Text("₹${item.productId.price}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(item.productCount == 1 ? Icons.delete_outline : Icons.remove),
                            onPressed: () {
                              final currentCount = item.productCount;
                              context.read<CartBloc>().add(RemoveProduct(
                                cartId: item.id,
                                newQuantity: currentCount - 1,
                              ));
                            },
                          ),
                          Text("${item.productCount}"),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              final currentCount = item.productCount;
                              context.read<CartBloc>().add(AddProduct(
                                cartId: item.id,
                                newQuantity: currentCount + 1,
                              ));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    Text("₹${total.toStringAsFixed(2)}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}