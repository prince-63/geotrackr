import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:geotrackr/presentation/widgets/custom_button.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';
import 'package:geotrackr/presentation/widgets/labeled_input.dart';

/// The [ForgotPasswordForm] widget is a stateless widget that represents the forgot password form.
/// It uses the Bloc pattern to manage the state of the forgot password process.
class VerifyForgotPasswordForm extends StatelessWidget {
  final TextEditingController codeController;

  /// Constructor for [ForgotPasswordForm].
  /// It initializes the class with the given email controller.
  const VerifyForgotPasswordForm({
    super.key,
    required this.codeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LabeledInput(label: 'Verification Code', controller: codeController),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'Verify',
            onPressed: () {
              final email = codeController.text;
              context.read<ForgotPasswordBloc>().forgotPassword(email);
            },
          ),
        ),
        BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
            if (state is ForgotPasswordLoading) {
              return const CircularProgressIndicator();
            } else if (state is ForgotPasswordSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(context, '/set-new-password');
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
