import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/core/use_cases/use_case.dart';
import 'package:ricky_mobile/features/authentication/data/models/auth_model.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/get_user_data_use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/register_use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/save_user_to_db_use_case.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/upload_image_to_storage_use_case.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final RegisterUseCase registerUseCase;
  final GetUserDataUseCase getUserDataUseCase;
  final LoginUseCase loginUseCase;
  final SaveUserToDBUseCase saveUserToDBUseCase;
  final UploadImageToStorageUseCase uploadImageToStorageUseCase;

  AuthenticationBloc(
      this.registerUseCase,
      this.saveUserToDBUseCase,
      this.loginUseCase,
      this.getUserDataUseCase,
      this.uploadImageToStorageUseCase)
      : super(AuthenticationInitial()) {
    on<Register>((event, emit) async {
      emit(AuthenticationIsLoading());
      final result = await registerUseCase(
          RegisterParams(email: event.email, password: event.password));
      await saveUserToDBUseCase(UserParams(
          email: event.email,
          phoneNumber: event.phoneNumber,
          fullName: event.fullName,
          photoUrl: event.photoUrl));

      result.fold((l) => emit(AuthenticationIsFailed(l)), (r) {
        emit(AuthenticationIsSuccess(user: r));
      });
    });
    on<Login>((event, emit) async {
      emit(AuthenticationIsLoading());
      final result =
          await loginUseCase(LoginParams(event.email, event.password));
      emit(result.fold((l) => AuthenticationIsFailed(l), (r) {
        add(GetUserData());
        return AuthenticationIsSuccess(user: r);
      }));
    });
    on<GetUserData>((event, emit) async {
      emit(AuthenticationIsLoading());
      final result = await getUserDataUseCase(NoParams());
      emit(result.fold((l) => AuthenticationIsFailed(l),
          (r) => AuthenticationIsSuccess(data: r)));
    });
  }
}
