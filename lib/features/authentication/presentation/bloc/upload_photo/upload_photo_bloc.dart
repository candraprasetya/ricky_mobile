import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ricky_mobile/core/error/failure.dart';
import 'package:ricky_mobile/features/authentication/domain/use_cases/upload_image_to_storage_use_case.dart';

part 'upload_photo_event.dart';
part 'upload_photo_state.dart';

class UploadPhotoBloc extends Bloc<UploadPhotoEvent, UploadPhotoState> {
  final UploadImageToStorageUseCase uploadImageToStorageUseCase;
  UploadPhotoBloc(this.uploadImageToStorageUseCase)
      : super(UploadPhotoInitial()) {
    on<UploadNewPhoto>((event, emit) async {
      emit(UploadPhotoIsLoading());
      final result = await uploadImageToStorageUseCase(event.file);
      emit(
        result.fold(
          (l) => UploadPhotoIsFailed(l),
          (r) => const UploadPhotoIsSuccess('Berhasil mengubah profile'),
        ),
      );
    });
  }
}
