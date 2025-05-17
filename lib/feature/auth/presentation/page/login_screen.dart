import 'dart:developer';

import 'package:bookia/core/constants/assets_manager.dart';
import 'package:bookia/core/extentions/extentions.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/back_arrow_widget.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/auth/data/models/request/auth_params.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_states.dart';
import 'package:bookia/feature/auth/presentation/page/forget_password_screen.dart';
import 'package:bookia/feature/auth/presentation/page/register_screen.dart';
import 'package:bookia/feature/auth/presentation/widgets/social_login.dart';
import 'package:bookia/intro/welcome_screen.dart';
import 'package:bookia/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            BackArrowWidget(
              onTap: () async {
                FocusScope.of(context).unfocus();
                await Future.delayed(
                  const Duration(milliseconds: 250),
                ); // To dismiss keyboard before navigating back to the WelcomeScreen
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const WelcomeScreen()),
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
            context.pushAndRemoveUntil(const MainAppScreen());
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Text(
                    'Welcome back! Glad to see you, Again!,',
                    style: getHeadlineTextStyle(context),
                  ),
                  const SizedBox(height: 30),

                  // Email
                  CustomTextFormField(
                    hintText: 'Enter your email',
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address';
                      } else if (!isEmailValid(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 15),

                  // Password
                  CustomTextFormField(
                    hintText: 'Enter your password',
                    controller: passwordController,
                    obscureText: isPasswordVisible,
                    keyboardType: TextInputType.visiblePassword,

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
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                      onPressed: () {
                        context.pushTo(const ForgetScreen());
                      },
                      child: Text(
                        'Forgot your password?',
                        style: getSmallTextStyle(color: AppColors.darkColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Login Button
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login(
                          AuthParams(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 35),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'Or Login with',
                          style: getSmallTextStyle(color: AppColors.darkColor),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 21),
                  Row(
                    children: [
                      SocialLogin(asset: AssetsManager.facebook),
                      SizedBox(width: 8),
                      SocialLogin(asset: AssetsManager.google),
                      SizedBox(width: 8),
                      SocialLogin(asset: AssetsManager.apple),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account?',
              style: getSmallTextStyle(
                fontSize: 15,
                color: AppColors.blackColor,
              ),
            ),
            TextButton(
              onPressed: () {
                context.pushReplacement(const RegisterScreen());
              },
              child: Text(
                'Register Now',
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
