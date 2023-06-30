import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/features/authentication/data/datasources/auth_datasource.dart';
import 'package:ricky_mobile/features/authentication/data/models/auth_model.dart';
import 'package:ricky_mobile/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<Either<Failure, AuthModel>> getUserData() async {
    try {
      final res = await authDataSource.getUserData();
      return right(res!);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> login(Map<String, dynamic> data) async {
    try {
      final res = await authDataSource.login(data);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    final res = await authDataSource.logout();
    return right(res);
  }

  @override
  Future<Either<Failure, User?>> register(Map<String, dynamic> data) async {
    try {
      final res = await authDataSource.register(data);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserImageToStorage(File data) async {
    try {
      final res = await authDataSource.uploadImageToStorage(data);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveUserToDB(Map<String, dynamic> data) async {
    try {
      final res = await authDataSource.saveUserToDB(data);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserDB(Map<String, dynamic> data) async {
    try {
      final res = await authDataSource.updateUserDB(data);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
