import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/domain/repositories/implementation/auth_repository_impl.dart';
import 'package:geotrackr/domain/use_cases/forgot_password.dart';
import 'package:geotrackr/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:geotrackr/presentation/widgets/forgot_password/forgot_password_form.dart';

/// The [ForgotPasswordPage] widget is a stateless widget that represents the forgot password page of the application.
/// It uses the Bloc pattern to manage the state of the forgot password process.
class ForgotPasswordPage extends StatelessWidget {
  // Controller for the email input field.
  final TextEditingController emailController = TextEditingController();

  /// Constructor for [ForgotPasswordPage].
  /// It initializes the class with the given key.
  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // The BlocProvider is used to provide the ForgotPasswordBloc to the widget tree.
      create: (context) => ForgotPasswordBloc(
        // Create an instance of ForgotPasswordBloc with the ForgotPassword use case.
        forgotPassword: ForgotPassword(
          AuthRepositoryImpl(),
        ),
      ),
      // The ForgotPasswordForm widget is the child of the BlocProvider.
      // It will have access to the ForgotPasswordBloc provided by the BlocProvider.
      child: ForgotPasswordForm(
        emailController: emailController,
      ),
    );
  }
}
