import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/auth/data/models/otp_verfication/send_forgot_password.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_states.dart';
import 'package:bookia/feature/auth/presentation/page/login_screen.dart';
import 'package:bookia/feature/auth/presentation/page/pass_changed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String verifyCode;
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.verifyCode,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmationController =
      TextEditingController();

  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _newPasswordConfirmationController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    final resetPasswordData = ResetPassword(
      verifyCode: widget.verifyCode,
      newPassword: _newPasswordController.text,
      newPasswordConfirmation: _newPasswordConfirmationController.text,
    );

    context.read<AuthCubit>().resetPassword(resetPasswordData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            Navigator.of(context, rootNavigator: true).pop(); // dismiss loading
            context.pushAndRemoveUntil(const PassChangedScreen());
          } else if (state is AuthErrorState) {
            Navigator.of(context, rootNavigator: true).pop(); // dismiss loading
            showToast(context, state.error);
          } else if (state is AuthLoadingState) {
            showLoadingDialog(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Create new password',
                    style: getHeadlineTextStyle(context),
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  "Your new password must be unique from those previously used.",
                  style: getBodyTextStyle(
                    context,
                    color: AppColors.greyColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),

                CustomTextFormField(
                  hintText: 'Password',
                  controller: _newPasswordController,

                  suffixIconConstraints: const BoxConstraints(minWidth: 24),
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
                const SizedBox(height: 11),

                // Confirm Password
                CustomTextFormField(
                  hintText: 'Confirm Password',
                  controller: _newPasswordConfirmationController,

                  suffixIconConstraints: const BoxConstraints(minWidth: 24),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
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
                      return 'Please confirm password';
                    } else if (value != _newPasswordController.text) {
                      return "Passwords don't match";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),
                CustomButton(text: 'Reset Password', onPressed: resetPassword),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Back to",
              style: getSmallTextStyle(
                fontSize: 15,
                color: AppColors.blackColor,
              ),
            ),
            TextButton(
              onPressed: () {
                context.pushTo(const LoginScreen());
              },
              child: Text(
                'Login',
                style: getSmallTextStyle(
                  fontSize: 15,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
