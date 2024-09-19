import 'package:flutter/material.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';

class ErrorHandlingWidget extends StatelessWidget {
  final String message;

  const ErrorHandlingWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CustomMessages.showErrorMessage(context, message);
    });
    return Container();
  }
}
