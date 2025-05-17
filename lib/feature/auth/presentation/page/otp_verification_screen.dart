import 'dart:developer';

import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/back_arrow_widget.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/auth/data/models/otp_verfication/send_forgot_password.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_states.dart';
import 'package:bookia/feature/auth/presentation/page/login_screen.dart';
import 'package:bookia/feature/auth/presentation/page/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String verifyCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackArrowWidget(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.pushAndRemoveUntil(
              ResetPasswordScreen(email: widget.email, verifyCode: verifyCode),
            );
            log(
              'Success Verifying OTP Verification Code, Navigating to SplashScreen',
            );
          } else if (state is AuthErrorState) {
            Navigator.pop(context);
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
                    'OTP Verification',
                    style: getHeadlineTextStyle(context),
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  "Enter the verification code we just sent on your email address.",
                  style: getBodyTextStyle(
                    context,
                    color: AppColors.greyColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),

                Column(
                  children: [
                    Pinput(
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 70,
                        height: 60,
                        textStyle: getBodyTextStyle(
                          context,
                          fontSize: 35,
                          color: AppColors.blackColor,
                        ),

                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.greyColor),
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      focusedPinTheme: PinTheme(
                        width: 70,
                        height: 60,
                        textStyle: getBodyTextStyle(
                          context,
                          fontSize: 22,
                          color: AppColors.blackColor,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 70,
                        height: 60,
                        textStyle: getBodyTextStyle(
                          context,
                          fontSize: 22,
                          color: AppColors.blackColor,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),

                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),

                      // showCursor: true,
                      onCompleted: (pin) => verifyCode = pin,
                    ),
                  ],
                ),

                const SizedBox(height: 32),
                CustomButton(
                  text: 'Verify',
                  onPressed: () {
                    context.read<AuthCubit>().checkForgetPasswordCode(
                      CheckForgetPasswordCode(
                        verifyCode: verifyCode,
                        email: widget.email,
                      ),
                    );
                  },
                ),
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
              "Didn't receive code?",
              style: getSmallTextStyle(
                fontSize: 15,
                color: AppColors.blackColor,
              ),
            ),
            TextButton(
              onPressed: () {
                context.pushReplacement(const LoginScreen());
              },
              child: Text(
                'Resend',
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
