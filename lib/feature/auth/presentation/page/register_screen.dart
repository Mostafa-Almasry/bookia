import 'dart:developer';

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
import 'package:bookia/feature/auth/presentation/page/login_screen.dart';
import 'package:bookia/intro/welcome_screen.dart';
import 'package:bookia/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

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
                    'Hello! Register to get started',
                    style: getHeadlineTextStyle(context),
                  ),
                  const SizedBox(height: 32),

                  // Username
                  CustomTextFormField(
                    controller: nameController,
                    hintText: 'Username',
                    keyboardType: TextInputType.name,

                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 11),

                  // Email
                  CustomTextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address';
                      } else if (!isEmailValid(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 11),

                  // Password
                  CustomTextFormField(
                    hintText: 'Password',
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,

                    obscureText: !isPasswordVisible,
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
                                  Icons.visibility,
                                  color: AppColors.greyColor,
                                )
                                : Icon(
                                  Icons.visibility_off,
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
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,

                    obscureText: !isConfirmPasswordVisible,
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
                            isConfirmPasswordVisible
                                ? Icon(
                                  Icons.visibility,
                                  color: AppColors.greyColor,
                                )
                                : Icon(
                                  Icons.visibility_off,
                                  color: AppColors.greyColor,
                                ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please confirm password';
                      } else if (value != passwordController.text) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // Register Button
                  CustomButton(
                    text: 'Register',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthCubit>().register(
                          AuthParams(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            passwordConfirmation:
                                confirmPasswordController.text,
                          ),
                        );
                      }
                    },
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
              "Already have an account?",
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
                'Login Now',
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
