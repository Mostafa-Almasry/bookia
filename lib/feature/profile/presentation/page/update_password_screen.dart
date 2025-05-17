import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/back_arrow_widget.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/profile/data/model/change_password/change_password.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _newPasswordConfirmationController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccessState) {
          _currentPasswordController.clear();
          _newPasswordController.clear();
          _newPasswordConfirmationController.clear();
          showToast(
            context,
            type: ToastType.success,
            'Password Changed Successfully!',
          );
          Navigator.pop(context, true);
        } else if (state is ProfileErrorState) {
          showToast(context, 'Failed to Change Password');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Stack(
            alignment: Alignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: BackArrowWidget(),
              ),
            ],
          ),
        ),
        body: LayoutBuilder(
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
                      Text(
                        'New Password',
                        style: getTitleTextStyle(context, fontSize: 30),
                      ),
                      const Gap(75),
                      Expanded(
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: _currentPasswordController,
                              hintText: 'Current Password',
                            ),
                            Gap(15),
                            CustomTextFormField(
                              controller: _newPasswordController,
                              hintText: 'New Password',
                              obscureText: !isPasswordVisible,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child:
                                      isPasswordVisible
                                          ? Icon(
                                            Icons.visibility_off,
                                            color: AppColors.greyColor,
                                          )
                                          : Icon(
                                            Icons.visibility,
                                            color: AppColors.greyColor,
                                          ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value.length < 6) {
                                  return 'Password must be atleast 6 characters';
                                }
                                return null;
                              },
                            ),
                            Gap(15),
                            CustomTextFormField(
                              controller: _newPasswordConfirmationController,
                              hintText: 'Confirm Password',
                              obscureText: !isConfirmPasswordVisible,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isConfirmPasswordVisible =
                                        !isConfirmPasswordVisible;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child:
                                      isConfirmPasswordVisible
                                          ? Icon(
                                            Icons.visibility_off,
                                            color: AppColors.greyColor,
                                          )
                                          : Icon(
                                            Icons.visibility,
                                            color: AppColors.greyColor,
                                          ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please confirm password';
                                } else if (value !=
                                    _newPasswordController.text) {
                                  return "Passwords don't match";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        text: 'Update Password',
                        fontSize: 18,
                        onPressed: () {
                          final changePasswordData = ChangePasswordRequest(
                            currentPassword: _currentPasswordController.text,
                            newPassword: _newPasswordController.text,
                            newPasswordConfirmation:
                                _newPasswordConfirmationController.text,
                          );
                          context.read<ProfileCubit>().changePassword(
                            changePasswordData,
                          );
                        },
                      ),
                      Gap(25),
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
