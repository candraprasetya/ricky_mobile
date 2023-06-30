import 'package:dartz/dartz.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/core/use_cases/use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/repositories/auth_repository.dart';

class SaveUserToDBUseCase extends UseCase<void, UserParams> {
  final AuthRepository authRepository;

  SaveUserToDBUseCase(this.authRepository);
  @override
  Future<Either<Failure, void>> call(UserParams params) async {
    return await authRepository.saveUserToDB({
      'email': params.email.trim(),
      'phoneNumber': params.phoneNumber,
      'fullName': params.fullName.trim(),
      'photoUrl': params.photoUrl,
    });
  }
}

class UserParams {
  final String email;
  final String phoneNumber;
  final String fullName;
  final String? photoUrl;

  UserParams({
    required this.email,
    required this.phoneNumber,
    required this.fullName,
    this.photoUrl,
  });
}
