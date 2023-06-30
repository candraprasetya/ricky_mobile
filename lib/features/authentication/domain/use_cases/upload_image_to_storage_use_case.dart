import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/core/use_cases/use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/repositories/auth_repository.dart';

class UploadImageToStorageUseCase extends UseCase<void, File> {
  final AuthRepository authRepository;

  UploadImageToStorageUseCase(this.authRepository);
  @override
  Future<Either<Failure, void>> call(File params) async {
    return await authRepository.saveUserImageToStorage(params);
  }
}
