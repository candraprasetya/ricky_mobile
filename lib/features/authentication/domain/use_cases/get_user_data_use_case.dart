import 'package:dartz/dartz.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/core/use_cases/use_case.dart';
import 'package:ricky_mobile/features/authentication/data/models/auth_model.dart';
import 'package:ricky_mobile/features/authentication/domain/repositories/auth_repository.dart';

class GetUserDataUseCase extends UseCase<AuthModel, NoParams> {
  final AuthRepository authRepository;

  GetUserDataUseCase(this.authRepository);
  @override
  Future<Either<Failure, AuthModel>> call(NoParams params) async {
    return await authRepository.getUserData();
  }
}
