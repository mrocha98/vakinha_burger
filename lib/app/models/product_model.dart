import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int,
        name: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        image: data['image'] as String,
      );

  final int id;

  final String name;

  final String description;

  final double price;

  final String image;

  @override
  List<Object?> get props => [id, name, description, price, image];

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'image': image,
      };

  String toJson() => json.encode(toMap());

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? image,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image,
      );
}
