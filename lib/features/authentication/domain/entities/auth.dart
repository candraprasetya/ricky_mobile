// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String? fullName;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? photoUrl;

  const Auth(
    this.fullName,
    this.email,
    this.password,
    this.phoneNumber,
    this.photoUrl,
  );

  @override
  List<Object> get props {
    return [
      fullName!,
      email!,
      password!,
      phoneNumber!,
      photoUrl!,
    ];
  }

  Auth copyWith({
    String? fullName,
    String? email,
    String? password,
    String? phoneNumber,
    String? photoUrl,
  }) {
    return Auth(
      fullName ?? this.fullName,
      email ?? this.email,
      password ?? this.password,
      phoneNumber ?? this.phoneNumber,
      photoUrl ?? this.photoUrl,
    );
  }
}
