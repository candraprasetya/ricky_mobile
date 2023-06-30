import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ricky_mobile/features/authentication/data/datasources/auth_datasource.dart';
import 'package:ricky_mobile/features/authentication/data/models/auth_model.dart';

import '../../../../core/storage/storage.dart';

class AuthDataSouceImpl implements AuthDataSource {
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final Storage storage;

  AuthDataSouceImpl(this.storage);

  @override
  Future<User?> login(data) async {
    try {
      final response = await auth.signInWithEmailAndPassword(
          email: data['email'], password: data['password']);
      if (response.user?.uid != null) {
        await auth.setPersistence(Persistence.SESSION);
        await storage.saveToken(value: response.user!.uid);
        return response.user!;
      } else {
        throw Exception();
      }
    } on DioException {
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await auth.signOut();
    } on DioException {
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<User?> register(data) async {
    try {
      final response = await auth.createUserWithEmailAndPassword(
          email: data['email'], password: data['password']);
      if (response.user?.uid != null) {
        await storage.saveToken(value: response.user!.uid);
        return response.user!;
      } else {
        throw Exception();
      }
    } on DioException {
      rethrow;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> saveUserToDB(data) async {
    try {
      await firestore.collection('users').doc(auth.currentUser!.uid).set(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserDB(data) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> uploadImageToStorage(data) async {
    try {
      final ref = firebaseStorage
          .ref()
          .child('user_image')
          .child('${auth.currentUser!.uid}.jpg');

      await ref.putFile(data);

      final url = await ref.getDownloadURL();

      await updateUserDB({"photoUrl": url});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthModel?> getUserData() async {
    try {
      late AuthModel authModel;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        authModel = AuthModel.fromMap(value.data()!);
      });

      return authModel;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
