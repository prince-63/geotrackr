import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/use_cases/upload_profile_image.dart';

class UploadProfileImageBloc extends Cubit<UploadProfileImageState> {
  final UploadProfileImage uploadProfileImage;

  UploadProfileImageBloc({required this.uploadProfileImage})
      : super(UploadProfileImageInitial());

  Future<void> upload(
      Stream<List<int>> stream, int length, String filePath) async {
    try {
      emit(UploadProfileImageInProgress());
      final String message =
          await uploadProfileImage.call(stream, length, filePath);
      emit(UploadProfileImageSuccess(message));
    } catch (e) {
      emit(UploadProfileImageFailure(e.toString()));
    }
  }
}

abstract class UploadProfileImageState {}

class UploadProfileImageInitial extends UploadProfileImageState {}

class UploadProfileImageInProgress extends UploadProfileImageState {}

class UploadProfileImageSuccess extends UploadProfileImageState {
  final String message;

  UploadProfileImageSuccess(this.message);
}

class UploadProfileImageFailure extends UploadProfileImageState {
  final String error;

  UploadProfileImageFailure(this.error);
}
