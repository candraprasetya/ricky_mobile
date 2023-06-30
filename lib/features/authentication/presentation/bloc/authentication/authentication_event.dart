part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class Register extends AuthenticationEvent {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final String? photoUrl;

  const Register(
      {required this.fullName,
      required this.phoneNumber,
      required this.email,
      required this.password,
      this.photoUrl});
}

class Login extends AuthenticationEvent {
  final String email;
  final String password;

  const Login({
    required this.email,
    required this.password,
  });
}

class GetUserData extends AuthenticationEvent {}
