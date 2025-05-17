import 'dart:io';

import 'package:bookia/core/constants/assets_manager.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/back_arrow_widget.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/profile/data/model/update_profile/update_profile.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.currentImageUrl});

  final String currentImageUrl;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? imageFile;
  final nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Initialize with current profile data
    final cubit = context.read<ProfileCubit>();
    nameController.text = cubit.profileResponse?.data?.name ?? '';
    emailController.text = cubit.profileResponse?.data?.email ?? '';
    phoneNumberController.text = cubit.profileResponse?.data?.phone ?? '';
    _loadCachedImage();
  }

  Future<void> _loadCachedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedPath = prefs.getString('cached_profile_image');
    if (cachedPath != null && File(cachedPath).existsSync()) {
      setState(() {
        imageFile = File(cachedPath);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  Future<void> onImageSelected(String imagePath) async {
    setState(() {
      imageFile = File(imagePath);
    });
  }

  Future<void> updateProfile() async {
    final updateData = UpdateProfile(
      name: nameController.text,
      email: emailController.text,
      address: addressController.text,
      phoneNumber: phoneNumberController.text,
      // image: imageFile
      // Backend doesn't accept image uploads
      // Therefore I'm going to only cache it
    );
    final cubit = context.read<ProfileCubit>();
    await cubit.updateProfile(updateData);

    if (cubit.state is ProfileSuccessState) {
      nameController.clear();
      phoneNumberController.clear();
      addressController.clear();

      // Save the image path only after successful update
      if (imageFile != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('cached_profile_image', imageFile!.path);
      }

      showToast(
        context,
        type: ToastType.success,
        'Profile Updated Successfully!',
      );

      Navigator.pop(context, true);
    } else if (cubit.state is ProfileErrorState) {
      showToast(context, 'Failed to Update Profile.');
    } else if (cubit.state is ProfileLoadingState) {
      CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Stack(
            alignment: Alignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: BackArrowWidget(),
              ),
              Text('Edit Profile', style: getTitleTextStyle(context)),
            ],
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Stack(
          alignment: Alignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: BackArrowWidget(),
            ),
            Text('Edit Profile', style: getTitleTextStyle(context)),
          ],
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      const Gap(50),
                      GestureDetector(
                        onTap:
                            () => showPfpBottomSheet(context, onImageSelected),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              // If the user cached an image, use it.
                              // If not check if the backend image is available,
                              // If it is use, if not return null(circle avatar default icon).
                              backgroundImage:
                                  imageFile != null
                                      ? FileImage(imageFile!) // User's image
                                      : widget
                                          .currentImageUrl
                                          .isNotEmpty // Backend's image
                                      ? CachedNetworkImageProvider(
                                        widget.currentImageUrl,
                                      )
                                      : null,

                              radius: 50,
                              backgroundColor: AppColors.avatarColor,
                              child:
                                  imageFile == null &&
                                          widget.currentImageUrl.isEmpty
                                      ? const Icon(
                                        Icons.person,
                                        size: 50,
                                        color: Colors.white,
                                      )
                                      : null,
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: SvgPicture.asset(
                                  AssetsManager.camera,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(40),

                      CustomTextFormField(
                        hintText: 'Full Name',
                        controller: nameController,
                      ),
                      const Gap(15),
                      CustomTextFormField(
                        hintText: 'Phone Number',
                        controller: phoneNumberController,
                        keyboardType: TextInputType.phone,
                      ),
                      const Gap(15),
                      CustomTextFormField(
                        hintText: 'Address',
                        controller: addressController,
                        keyboardType: TextInputType.streetAddress,
                      ),
                      const Spacer(),
                      CustomButton(
                        text: 'Update Profile',
                        fontSize: 18,
                        onPressed: updateProfile,
                      ),
                      const Gap(15),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
