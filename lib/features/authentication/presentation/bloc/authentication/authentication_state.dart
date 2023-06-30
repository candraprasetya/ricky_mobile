// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationIsFailed extends AuthenticationState {
  final Failure failure;

  const AuthenticationIsFailed(this.failure);
}

class AuthenticationIsLoading extends AuthenticationState {}

class AuthenticationIsSuccess extends AuthenticationState {
  final AuthModel? data;
  final User? user;

  const AuthenticationIsSuccess({this.data, this.user});

  AuthenticationIsSuccess copyWith({
    AuthModel? data,
    User? user,
  }) {
    return AuthenticationIsSuccess(
      data: data ?? this.data,
      user: user ?? this.user,
    );
  }
}
