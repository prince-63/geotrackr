import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/auth_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/verify_forgot_password.dart';
import 'package:geotrackr/presentation/blocs/forgot_password/verify_forgot_password_bloc.dart';
import 'package:geotrackr/presentation/widgets/forgot_password/verify_forgot_password_body.dart';

/// The [VerifyForgotPasswordPage] widget is a stateless widget that represents the verify forgot password page of the application.
/// It uses the Bloc pattern to manage the state of the verify forgot password process.
class VerifyForgotPasswordPage extends StatelessWidget {
  /// Constructor for [VerifyForgotPasswordPage].
  /// It initializes the class with the given key.
  const VerifyForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // The BlocProvider is used to provide the VerifyForgotPasswordBloc to the widget tree.
      create: (context) => VerifyForgotPasswordBloc(
        // Create an instance of VerifyForgotPasswordBloc with the AuthRepositoryImpl.
        verifyForgotPassword: VerifyForgotPassword(
          AuthRepositoryImpl(),
        ),
      ),
      // The VerifyForgotPasswordForm widget is the child of the BlocProvider.
      // It will have access to the VerifyForgotPasswordBloc provided by the BlocProvider.
      child: VerifyForgotPasswordBody(),
    );
  }
}
