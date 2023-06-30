// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ricky_mobile/core/storage/storage_impl.dart';
import 'package:ricky_mobile/features/authentication/data/datasources/auth_datasource_impl.dart';
import 'package:ricky_mobile/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/get_user_data_use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/register_use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/save_user_to_db_use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/upload_image_to_storage_use_case.dart';
import 'package:ricky_mobile/features/authentication/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:ricky_mobile/features/authentication/presentation/bloc/upload_photo/upload_photo_bloc.dart';

class GetProviders extends StatelessWidget {
  final Widget child;
  const GetProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final storageImpl = StorageImpl();
    final authDataSourceImpl = AuthDataSouceImpl(storageImpl);
    final authRepositoryImpl = AuthRepositoryImpl(authDataSourceImpl);

    return MultiBlocListener(listeners: [
      //Register
      BlocProvider(
        create: (context) => AuthenticationBloc(
            RegisterUseCase(authRepositoryImpl),
            SaveUserToDBUseCase(authRepositoryImpl),
            LoginUseCase(authRepositoryImpl),
            GetUserDataUseCase(authRepositoryImpl),
            UploadImageToStorageUseCase(authRepositoryImpl)),
      ),

      //Upload Photo
      BlocProvider(
        create: (context) =>
            UploadPhotoBloc(UploadImageToStorageUseCase(authRepositoryImpl)),
      ),
    ], child: child);
  }
}
