import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/forgot_password/set_new_password_bloc.dart';
import 'package:geotrackr/presentation/widgets/custom_button.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';
import 'package:geotrackr/presentation/widgets/labeled_input.dart';

class SetNewPasswordForm extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const SetNewPasswordForm({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LabeledInput(
            label: 'Password',
            controller: passwordController,
            obscureText: true),
        const SizedBox(height: 20),
        LabeledInput(
            label: 'Conform Password',
            controller: confirmPasswordController,
            obscureText: true),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'Submit',
            onPressed: () {
              final password = passwordController.text;
              final conformPassword = confirmPasswordController.text;

              if ((password != conformPassword) || password.isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  CustomMessages.showErrorMessage(
                      context, 'Passwords do not match');
                });
              }
              context.read<SetNewPasswordBloc>().setNewPassword(password);
            },
          ),
        ),
        BlocBuilder<SetNewPasswordBloc, SetNewPasswordState>(
          builder: (context, state) {
            if (state is SetNewPasswordLoading) {
              return const CircularProgressIndicator();
            } else if (state is SetNewPasswordSuccess) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(context, '/');
              });
              return Container();
            } else if (state is SetNewPasswordError) {
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
