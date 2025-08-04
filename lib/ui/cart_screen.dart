import 'package:cached_network_image/cached_network_image.dart';
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
                      leading: SizedBox(
                        height: 50,
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: item.productId.imageUrl,
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover
                                  )
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                child: Center(child: Icon(Icons.error_outline),),
                              );
                            },
                          ),
                        ),
                      ),
                      title: Text(item.productId.title),
                      subtitle: Text("₹${item.productId.price * item.productCount}"),
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
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  spacing: 5,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        Text("₹${total.toStringAsFixed(2)}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: (){}, 
                        child: Text("Checkout")
                      ),
                    )
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