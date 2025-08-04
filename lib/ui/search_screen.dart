import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/bloc/home/home_bloc.dart';
import 'package:e_commerce/bloc/home/home_state.dart';
import 'package:e_commerce/data/model/products_model.dart';
import 'package:e_commerce/ui/products_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  late final FocusNode _focusNode;
  final TextEditingController _searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        List<ProductsModel> filteredProducts = _searchController.text.isEmpty 
        ? []
        : state.products.where((e) => e.title.toLowerCase().contains(_searchController.text.toLowerCase()),).toList();

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: AppBar(
                automaticallyImplyLeading: false,
                titleSpacing: 0,
                title: SizedBox(
                  height: 40,
                  child: SearchBar(
                    controller: _searchController,
                    focusNode: _focusNode,
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    elevation: WidgetStatePropertyAll(0.0),
                    hintText: "Search products",
                    leading: Icon(Icons.search),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    onChanged: (value) {
                      setState(() {}); // fine for now
                    },
                    onTapOutside: (event) {
                      _focusNode.unfocus();
                    },
                  ),
                ),
              ),
            ),
          ),

          body: filteredProducts.isEmpty
          ? Center(
            child: Text(
              "No products found"
            ),
          )
          : ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: filteredProducts[index].imageUrl,
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
                title: Text(filteredProducts[index].title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                subtitle: Text("₹${filteredProducts[index].price}", style: TextStyle(fontSize: 12, color: Colors.black54),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsDetailScreen(product: filteredProducts[index]),));
                },
              );
            },
          ),
        );
      },
    );
  }
}