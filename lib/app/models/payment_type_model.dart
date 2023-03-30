import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentTypeModel extends Equatable {
  const PaymentTypeModel({
    required this.id,
    required this.name,
    required this.acronym,
    required this.enabled,
  });

  factory PaymentTypeModel.fromJson(String source) =>
      PaymentTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory PaymentTypeModel.fromMap(Map<String, dynamic> map) {
    return PaymentTypeModel(
      id: map['id'] as int,
      name: map['name'] as String,
      acronym: map['acronym'] as String,
      enabled: map['enabled'] as bool,
    );
  }

  final int id;

  final String name;

  final String acronym;

  final bool enabled;

  @override
  List<Object?> get props => [
        id,
        name,
        acronym,
        enabled,
      ];

  PaymentTypeModel copyWith({
    int? id,
    String? name,
    String? acronym,
    bool? enabled,
  }) {
    return PaymentTypeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      acronym: acronym ?? this.acronym,
      enabled: enabled ?? this.enabled,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'acronym': acronym,
      'enabled': enabled,
    };
  }

  String toJson() => json.encode(toMap());
}
