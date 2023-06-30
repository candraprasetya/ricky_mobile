import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/core/use_cases/use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/repositories/auth_repository.dart';

class RegisterUseCase extends UseCase<User?, RegisterParams> {
  final AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  @override
  Future<Either<Failure, User?>> call(RegisterParams params) async {
    return await authRepository.register({
      'email': params.email,
      'password': params.password,
    });
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({
    required this.email,
    required this.password,
  });
}
