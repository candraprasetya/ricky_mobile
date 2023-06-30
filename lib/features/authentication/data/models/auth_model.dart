import 'package:ricky_mobile/features/authentication/domain/entities/auth.dart';
import 'dart:convert';

class AuthModel extends Auth {
  const AuthModel(super.fullName, super.email, super.password,
      super.phoneNumber, super.photoUrl);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      map['fullName'] != null ? map['fullName'] as String : null,
      map['email'] != null ? map['email'] as String : null,
      map['password'] != null ? map['password'] as String : null,
      map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      map['photoUrl'] != null ? map['photoUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
