part of 'upload_photo_bloc.dart';

abstract class UploadPhotoState extends Equatable {
  const UploadPhotoState();

  @override
  List<Object> get props => [];
}

class UploadPhotoInitial extends UploadPhotoState {}

class UploadPhotoIsLoading extends UploadPhotoState {}

class UploadPhotoIsFailed extends UploadPhotoState {
  final Failure failure;

  const UploadPhotoIsFailed(this.failure);
}

class UploadPhotoIsSuccess extends UploadPhotoState {
  final String message;

  const UploadPhotoIsSuccess(this.message);
}
