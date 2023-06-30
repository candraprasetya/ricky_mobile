// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/core/use_cases/use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase extends UseCase<User?, LoginParams> {
  final AuthRepository authRepository;
  LoginUseCase(
    this.authRepository,
  );

  @override
  Future<Either<Failure, User?>> call(LoginParams params) async {
    return await authRepository
        .login({'email': params.email, 'password': params.password});
  }
}

class LoginParams {
  final String? email;
  final String? password;

  LoginParams(this.email, this.password);
}
