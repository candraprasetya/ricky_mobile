import 'package:dartz/dartz.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/core/use_cases/use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/repositories/auth_repository.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/save_user_to_db_use_case.dart';

class UpdateUserDBUseCase extends UseCase<void, UserParams> {
  final AuthRepository authRepository;

  UpdateUserDBUseCase(this.authRepository);
  @override
  Future<Either<Failure, void>> call(UserParams params) async {
    return await authRepository.updateUserDB({
      'email': params.email.trim(),
      'phoneNumber': params.phoneNumber.trim(),
      'fullName': params.fullName.trim(),
      'photoUrl': params.photoUrl,
    });
  }
}
