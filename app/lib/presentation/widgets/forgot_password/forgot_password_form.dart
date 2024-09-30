import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:geotrackr/presentation/widgets/custom_button.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';
import 'package:geotrackr/presentation/widgets/labeled_input.dart';

/// The [ForgotPasswordForm] widget is a stateless widget that represents the forgot password form.
/// It uses the Bloc pattern to manage the state of the forgot password process.
class ForgotPasswordForm extends StatelessWidget {
  final TextEditingController emailController;

  /// Constructor for [ForgotPasswordForm].
  /// It initializes the class with the given email controller.
  const ForgotPasswordForm({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LabeledInput(
          label: 'Email',
          controller: emailController,
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'Send Verification Email',
            onPressed: () {
              final email = emailController.text;
              if (email.isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  CustomMessages.showErrorMessage(context, 'Email is required');
                });
              } else {
                context.read<ForgotPasswordBloc>().forgot(email);
              }
            },
          ),
        ),
        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
            if (state is ForgotPasswordLoading) {
              return const CircularProgressIndicator();
            } else if (state is ForgotPasswordSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                CustomMessages.showBeautifulMessage(context, state.message);
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(context, '/verify-forgot-password');
              });
              return Container();
            } else if (state is ForgotPasswordError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                CustomMessages.showErrorMessage(context, state.message);
              });
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
