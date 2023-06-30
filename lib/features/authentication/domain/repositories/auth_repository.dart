import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/features/authentication/data/models/auth_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, User?>> register(Map<String, dynamic> data);
  Future<Either<Failure, User?>> login(Map<String, dynamic> data);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> saveUserToDB(Map<String, dynamic> data);
  Future<Either<Failure, AuthModel>> getUserData();
  Future<Either<Failure, void>> saveUserImageToStorage(File data);
  Future<Either<Failure, void>> updateUserDB(Map<String, dynamic> data);
}
