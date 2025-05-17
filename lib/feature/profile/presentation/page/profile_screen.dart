import 'dart:io';

import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/core/services/local_helper.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/page/contact_us_screen.dart';
import 'package:bookia/feature/profile/presentation/page/edit_profile_screen.dart';
import 'package:bookia/feature/profile/presentation/page/faq_screen.dart';
import 'package:bookia/feature/profile/presentation/page/privacy_and_terms_screen.dart';
import 'package:bookia/feature/profile/presentation/page/update_password_screen.dart';
import 'package:bookia/feature/profile/presentation/widgets/profile_item.dart';
import 'package:bookia/intro/welcome_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? cachedImageFile;

  @override
  void initState() {
    super.initState();
    _loadCachedImage();
  }

  Future<void> _loadCachedImage() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedPath = prefs.getString('cached_profile_image');
    if (cachedPath != null && File(cachedPath).existsSync()) {
      setState(() {
        cachedImageFile = File(cachedPath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getProfile(),

      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile', style: getTitleTextStyle(context)),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                // Logout
                AppLocalStorage.clearCashedData(AppLocalStorage.tokenKey);
                context.pushReplacement(WelcomeScreen());
              },
              icon: Icon(
                Icons.exit_to_app_rounded,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ProfileSuccessState) {
              var cubit = context.read<ProfileCubit>();
              var name = cubit.profileResponse?.data?.name ?? '';
              var email = cubit.profileResponse?.data?.email ?? '';
              var image = cubit.profileResponse?.data?.image ?? '';

              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  cachedImageFile != null
                                      ? FileImage(cachedImageFile!)
                                      : (image.isNotEmpty
                                          ? CachedNetworkImageProvider(image)
                                          : null),
                              radius: 35,
                              backgroundColor: AppColors.avatarColor,
                            ),
                            const Gap(13),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: getBodyTextStyle(
                                      context,
                                      fontSize: 20,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(email, style: getSmallTextStyle()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(35),
                      Expanded(
                        child: ListView(
                          children: [
                            ProfileItem(
                              title: 'Edit Profile',
                              onTap: () async {
                                final updated = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => BlocProvider.value(
                                          value: context.read<ProfileCubit>(),
                                          child: EditProfileScreen(
                                            currentImageUrl: image,
                                          ),
                                        ),
                                  ),
                                );
                                if (updated == true) {
                                  await _loadCachedImage(); // Reload the cached image after editing
                                  setState(
                                    () {},
                                  ); // Force rebuild to update the PFP
                                  context.read<ProfileCubit>().getProfile();
                                }
                              },
                            ),
                            ProfileItem(
                              title: 'Reset Password',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => BlocProvider.value(
                                          value:
                                              context
                                                  .read<
                                                    ProfileCubit
                                                  >(), // Use the existing cubit
                                          child: UpdatePasswordScreen(),
                                        ),
                                  ),
                                );
                              },
                            ),
                            ProfileItem(
                              title: 'FAQ',
                              onTap: () {
                                context.pushTo(FaqScreen());
                              },
                            ),
                            ProfileItem(
                              title: 'Contact Us',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => BlocProvider.value(
                                          value:
                                              context
                                                  .read<
                                                    ProfileCubit
                                                  >(), // Use the existing cubit
                                          child: ContactUsScreen(),
                                        ),
                                  ),
                                );
                              },
                            ),
                            ProfileItem(
                              title: 'Privacy & Terms',
                              onTap: () {
                                context.pushTo(PrivacyAndTermsScreen());
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
