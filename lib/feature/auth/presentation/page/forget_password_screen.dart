import 'dart:developer';

import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/back_arrow_widget.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/auth/data/models/otp_verfication/send_forgot_password.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_states.dart';
import 'package:bookia/feature/auth/presentation/page/login_screen.dart';
import 'package:bookia/feature/auth/presentation/page/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: [BackArrowWidget()]),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.pushReplacement(
              OtpVerificationScreen(email: emailController.text),
            );
            log('Success');
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
                    'Forgot Password?',
                    style: getHeadlineTextStyle(context),
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  "Don't worry! It occurs. Please enter the email address linked with your account.",
                  style: getBodyTextStyle(
                    context,
                    color: AppColors.greyColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),

                // Email
                CustomTextFormField(
                  hintText: 'Enter your email',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email address';
                    } else if (!isEmailValid(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 32),
                CustomButton(
                  text: 'Send Code',
                  onPressed: () {
                    context.read<AuthCubit>().forgetPassword(
                      SendForgetPassword(email: emailController.text),
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
              "Remember Password?",
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
