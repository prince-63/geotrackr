import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/login/login_bloc.dart';
import 'package:geotrackr/presentation/widgets/custom_button.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';
import 'package:geotrackr/presentation/widgets/labeled_input.dart';
import 'package:geotrackr/utils/custom_color.dart';

/// The [LoginForm] widget is a stateless widget that represents the login form.
/// It uses the Bloc pattern to manage the state of the login process.
class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginForm(
      {super.key,
      required this.emailController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDarkMode ? CustomColor.darkTextColor : CustomColor.lightTextColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LabeledInput(label: 'Email', controller: emailController),
        const SizedBox(height: 20),
        LabeledInput(
            label: 'Password',
            controller: passwordController,
            obscureText: true),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/forgot-password');
            },
            child: Text('Forgot Password?', style: TextStyle(color: textColor)),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            text: 'Login',
            onPressed: () {
              final email = emailController.text;
              final password = passwordController.text;
              context.read<LoginBloc>().login(email, password);
            },
          ),
        ),
        BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const CircularProgressIndicator();
            } else if (state is LoginLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamed(context, '/home');
              });
              return Container();
            } else if (state is LoginError) {
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
