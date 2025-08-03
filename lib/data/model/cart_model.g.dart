// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) => CartModel(
  id: (json['id'] as num).toInt(),
  product: ProductsModel.fromJson(json['product'] as Map<String, dynamic>),
  productCount: (json['productCount'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
);

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
  'id': instance.id,
  'product': instance.product,
  'productCount': instance.productCount,
  'userId': instance.userId,
};
