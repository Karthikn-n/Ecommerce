// Use json_serializable and json_annotation to manage model files

import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart'; 

@JsonSerializable()
class ProductsModel {
  final int id;
  final int categoryId;
  final String title;
  final String description;
  final String imageUrl;
  final int price;
  final String createdAt;

  ProductsModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.price
  });
  
  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
    _$ProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}