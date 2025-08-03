import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/data/model/products_model.dart';
import 'package:flutter/material.dart';

class ProductsDetailScreen extends StatelessWidget {
  final ProductsModel product;
  const ProductsDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
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
            const SizedBox(height: 10.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    titleAlignment: ListTileTitleAlignment.top,
                    contentPadding: EdgeInsets.zero,
                    title: Text(product.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                    trailing: Text("₹${product.price}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  ),
                  Text(product.description, style: TextStyle(color: Colors.black54),),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: (){}, 
            child: Text("Add to cart")
          ),
        ),
      ),
    );
  }
}