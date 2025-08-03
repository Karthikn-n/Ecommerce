import 'package:e_commerce/data/model/products_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final int id;
  final ProductsModel product;
  final int productCount;
  final int userId;

  CartModel({
    required this.id,
    required this.product,
    required this.productCount,
    required this.userId,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) 
    => _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}