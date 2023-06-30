import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricky_mobile/features/authentication/data/models/auth_model.dart';

abstract class AuthDataSource {
  Future<User?> register(data);
  Future<User?> login(data);
  Future<void> logout();
  Future<void> saveUserToDB(data);
  Future<void> uploadImageToStorage(data);
  Future<void> updateUserDB(data);
  Future<AuthModel?> getUserData();
}
