import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/auth_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/set_new_password.dart';
import 'package:geotrackr/presentation/blocs/forgot_password/set_new_password_bloc.dart';
import 'package:geotrackr/presentation/widgets/forgot_password/set_new_password_body.dart';

class SetNewPasswordPage extends StatelessWidget {
  const SetNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetNewPasswordBloc(
        setNewPassword: SetNewPassword(
          AuthRepositoryImpl(),
        ),
      ),
      child: SetNewPasswordBody(),
    );
  }
}