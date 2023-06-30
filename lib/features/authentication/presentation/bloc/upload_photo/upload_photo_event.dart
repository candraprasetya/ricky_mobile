part of 'upload_photo_bloc.dart';

abstract class UploadPhotoEvent extends Equatable {
  const UploadPhotoEvent();

  @override
  List<Object> get props => [];
}

class UploadNewPhoto extends UploadPhotoEvent {
  final File file;

  const UploadNewPhoto(this.file);
}
