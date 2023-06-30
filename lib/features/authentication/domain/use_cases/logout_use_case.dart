import 'package:dartz/dartz.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/features/authentication/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;

  LogoutUseCase(this.authRepository);

  Future<Either<Failure, void>> logout() async {
    return await authRepository.logout();
  }
}
