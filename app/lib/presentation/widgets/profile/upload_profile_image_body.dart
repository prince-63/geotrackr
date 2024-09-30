import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geotrackr/presentation/blocs/employee/upload_profile_image_bloc.dart';
import 'package:geotrackr/presentation/widgets/custom_button.dart';
import 'package:geotrackr/presentation/widgets/custom_messages.dart';
import 'package:geotrackr/presentation/widgets/default_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadProfileImageBody extends StatelessWidget {
  const UploadProfileImageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: "Upload Profile Image",
        onBackButtonPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 130),
                  Image.asset(
                    'assets/images/image-upload.webp',
                    height: 300,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          context.read<UploadProfileImageBloc>().upload(
                                http.ByteStream(image.openRead()),
                                await image.length(),
                                image.path,
                              );
                        }
                      },
                      text: 'Upload Profile Image',
                    ),
                  ),
                  BlocBuilder<UploadProfileImageBloc, UploadProfileImageState>(
                    builder: (context, state) {
                      if (state is UploadProfileImageInProgress) {
                        return const CircularProgressIndicator();
                      } else if (state is UploadProfileImageSuccess) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          CustomMessages.showBeautifulMessage(
                              context, state.message);
                        });
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(context, '/home');
                        });
                        return Container();
                      } else if (state is UploadProfileImageFailure) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          CustomMessages.showErrorMessage(context, state.error);
                        });
                        return Container();
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
