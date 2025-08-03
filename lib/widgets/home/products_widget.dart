import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/data/model/products_model.dart';
import 'package:e_commerce/ui/products_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductsWidget extends StatelessWidget {
  final String title;
  final List<ProductsModel> products;
  const ProductsWidget({super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 5.0,),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right:10.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsDetailScreen(product: products[index]),));
                  },
                  child: _productCard(products[index])
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _productCard(ProductsModel product) {
    return SizedBox(
      height: 200,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
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
          ),
          
          const SizedBox(height: 10,),
          Text(
            product.title,
            style: TextStyle(
              fontSize: 16, 
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold
            ),
          ),
          Text("₹${product.price}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }
}