
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel {
  final String id;
  final String name;
  final String email;

  ProfileModel({
    required this.id,
    required this.email,
    required this.name,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}