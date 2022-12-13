import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psspl_bloc_demo/firebase_todo/model/profile.dart';
import 'package:psspl_bloc_demo/firebase_todo/profile/bloc/profile_bloc.dart';
import 'package:psspl_bloc_demo/main.dart';
import 'package:psspl_bloc_demo/util/const.dart';

class ProfileView extends StatelessWidget {
  final nameController = TextEditingController();
  final desController = TextEditingController();

  ProfileView({Key? key}) : super(key: key);

  get loader => const Center(
        child: CircularProgressIndicator(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(LoadProfile()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileError) {
            showSnackBar(state.msg);
          } else if (state is ProfileSuccess) {
            showSnackBar("Profile updated successfully");
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Profile",
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(20),
              width: double.maxFinite,
              child: Visibility(
                visible: state is ProfileLoader,
                replacement: getView(state, context),
                child: loader,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getView(ProfileState state, BuildContext context) {
    if (state is ProfileLoaded) {
      desController.text = state.profile.desc ?? "";
      nameController.text = state.profile.name ?? "";
    }

    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              showMyPicker(context);
            },
            child: state.profile?.file != null
                ? Image.file(
                    File(
                      state.profile?.file?.path ?? "",
                    ),
                    fit: BoxFit.fill,
                  )
                : CachedNetworkImage(
                    fadeInCurve: Curves.bounceIn,
                    imageUrl: state.profile?.url ?? "",
                    fit: BoxFit.fill,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          color: Colors.blue, value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
          ),
        ),
        const SizedBox(
          height: 20,
          width: 20,
        ),
        TextField(
          controller: nameController,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration().inputDecoration.copyWith(
              hintText: "Enter name",
              suffixIcon: const Icon(
                Icons.person,
                color: Colors.blue,
              )),
        ),
        const SizedBox(
          height: 20,
          width: 15,
        ),
        TextField(
          controller: desController,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration().inputDecoration.copyWith(
                hintText: "Enter bio or description",
                suffixIcon: const Icon(
                  Icons.description,
                  color: Colors.blue,
                ),
              ),
        ),
        const SizedBox(
          height: 20,
          width: 15,
        ),
        const Spacer(),
        Visibility(
          visible: state is ProfileUpdateLoader,
          child: loader,
          replacement: MaterialButton(
            minWidth: 200,
            onPressed: () {
              context.read<ProfileBloc>().add(
                    UpdateProfileEvent(
                      profile: Profile(
                        name: nameController.text,
                        desc: desController.text,
                      ),
                    ),
                  );
            },
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
          width: 20,
        ),
        Visibility(
          visible: state is ProfileLogoutLoader,
          child: loader,
          replacement: MaterialButton(
            minWidth: 200,
            onPressed: () {},
            color: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  void showMyPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Photo Library'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _imgFromCameraAndGallery(false, context);
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _imgFromCameraAndGallery(true, context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future _imgFromCameraAndGallery(
    bool fromCamera,
    BuildContext context,
  ) async {
    final picker = ImagePicker();
    picker
        .pickImage(
            source: fromCamera ? ImageSource.camera : ImageSource.gallery,
            imageQuality: 50)
        .then((pickedFile) {
      if (pickedFile != null) {
        context.read<ProfileBloc>().add(
              SelectPhotoEvent(
                profile: Profile(file: pickedFile),
              ),
            );
      }
    });
  }
}
