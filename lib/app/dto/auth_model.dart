import 'dart:convert';

class AuthModel {
  AuthModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: map['access_token'] as String,
      refreshToken: map['refresh_token'] as String,
    );
  }

  final String accessToken;

  final String refreshToken;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  String toJson() => json.encode(toMap());
}
