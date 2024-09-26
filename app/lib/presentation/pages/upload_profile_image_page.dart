import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/employee_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/upload_profile_image.dart';
import 'package:geotrackr/presentation/blocs/employee/upload_profile_image_bloc.dart';
import 'package:geotrackr/presentation/widgets/profile/upload_profile_image_body.dart';

class UploadProfileImagePage extends StatelessWidget {
  const UploadProfileImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UploadProfileImageBloc(
        uploadProfileImage: UploadProfileImage(
          EmployeeRepositoryImpl(),
        ),
      ),
      child: const UploadProfileImageBody(),
    );
  }
}
