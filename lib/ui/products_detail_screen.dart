import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/bloc/cart/cart_bloc.dart';
import 'package:e_commerce/bloc/cart/cart_event.dart';
import 'package:e_commerce/bloc/cart/cart_state.dart';
import 'package:e_commerce/data/model/cart_model.dart';
import 'package:e_commerce/data/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsDetailScreen extends StatelessWidget {
  final ProductsModel product;
  const ProductsDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Container(
                    decoration: BoxDecoration(color: Colors.grey.shade100),
                    child: Center(child: Icon(Icons.error_outline)),
                  );
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    titleAlignment: ListTileTitleAlignment.top,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      product.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Text(
                      "₹${product.price}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
        builder: (context, cartState) {
          CartModel? cartItem;
          try {
            cartItem = cartState.cartItems.firstWhere((element) => element.productId.id == product.id,);
          } catch (e) {
            cartItem = null;
          }
          int productCount = cartItem != null ? cartItem.productCount : 0;
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: SizedBox(
              width: double.infinity,
              child: cartItem != null && productCount >= 1
              ? FilledButton(
                onPressed: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        productCount == 1 
                          ? Icons.delete_outline 
                          : Icons.remove,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        final currentCount = productCount;
                        context.read<CartBloc>().add(RemoveProduct(
                          cartId: cartItem!.id,
                          newQuantity: currentCount - 1,
                        ));
                      },
                    ),
                    Text("$productCount", style: TextStyle(color: Colors.white),),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.white,),
                      onPressed: () {
                        final currentCount = productCount;
                        context.read<CartBloc>().add(AddProduct(
                          cartId: cartItem!.id,
                          newQuantity: currentCount + 1,
                        ));
                      },
                    ),
                  ],
                ),
              )
              : FilledButton(
                onPressed: () {
                  context.read<CartBloc>().add(AddToCart(productId: product.id));
                  if (cartState.isAdded != null && cartState.isAdded) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Product added to cart")),
                    );
                  }
                }, 
                child: Text("Add to cart")
              ),
            ),
          );
        },
      ),
    );
  }
}
