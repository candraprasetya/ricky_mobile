import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:ricky_mobile/core/size_config/extensions.dart';
import 'package:ricky_mobile/features/authentication/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:ricky_mobile/features/authentication/presentation/bloc/upload_photo/upload_photo_bloc.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({Key? key}) : super(key: key);

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  XFile? pickedImage;
  bool isGallery = true;
  _uploadImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = isGallery
        ? await picker.pickImage(
            source: ImageSource.gallery,
            imageQuality: 70,
            maxHeight: 200,
            maxWidth: 200,
          )
        : await picker.pickImage(
            source: ImageSource.camera,
            imageQuality: 70,
            maxHeight: 200,
            maxWidth: 200,
          );

    setState(() {
      pickedImage = image;
    });

    if (pickedImage != null) {
      if (context.mounted) {
        BlocProvider.of<UploadPhotoBloc>(context)
            .add(UploadNewPhoto(File(pickedImage!.path)));
      }
    }
  }

  @override
  void initState() {
    BlocProvider.of<AuthenticationBloc>(context).add(GetUserData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadPhotoBloc, UploadPhotoState>(
      listener: (context, state) {
        if (state is UploadPhotoIsSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(GetUserData());
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Column(
        children: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationIsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is AuthenticationIsSuccess) {
                if (state.data?.photoUrl != null) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(
                      state.data!.photoUrl!,
                    ),
                    backgroundColor: Colors.transparent,
                    radius: 45,
                  );
                } else {
                  pickedImage == null
                      ? const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/cartoon_chef.png',
                          ),
                          backgroundColor: Colors.transparent,
                          radius: 45,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(
                            File(pickedImage!.path),
                          ),
                          backgroundColor: Colors.transparent,
                          radius: 45,
                        );
                }
              }
              return const SizedBox();
            },
          ),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticationIsSuccess) {
                return TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent),
                  ),
                  onPressed: () {
                    _onPressedHandler(context);
                  },
                  icon: Icon(
                    Icons.image,
                    color: Colors.brown[300],
                  ),
                  label: Text(
                    state.data?.photoUrl == null
                        ? 'Upload Photo'
                        : 'Update Photo',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 18.width,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }

  Future<dynamic> _onPressedHandler(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Profile Photo Upload",
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 20.width,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isGallery = false;
                      _uploadImage();
                    });
                  },
                  child: SizedBox(
                    height: 50,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Take Photo",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 18.width,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isGallery = true;
                      _uploadImage();
                    });
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Choose from Library",
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 18.width,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(color: Colors.grey[100]),
                      child: Center(
                        child: Text(
                          'CANCEL',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18.width,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
