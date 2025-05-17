import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/back_arrow_widget.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/profile/data/model/contact_us/contact_us_request.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  Future<void> contactUs() async {
    final contactData = ContactUsRequest(
      name: nameController.text,
      email: emailController.text,
      subject: subjectController.text,
      message: messageController.text,
    );

    final cubit = context.read<ProfileCubit>();
    await cubit.contactUs(contactData);

    if (cubit.state is ProfileSuccessState) {
      nameController.clear();
      emailController.clear();
      subjectController.clear();
      messageController.clear();

      showToast(context, type: ToastType.success, 'Message Sent Successfully!');

      Navigator.pop(context, true);
    } else if (cubit.state is ProfileErrorState) {
      showToast(context, 'Failed to Send Message');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: BackArrowWidget(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Gap(50),
            Text(
              'Contact Us',
              style: getTitleTextStyle(context, fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const Gap(75),
            CustomTextFormField(controller: nameController, hintText: 'Name'),
            const Gap(15),
            CustomTextFormField(controller: emailController, hintText: 'Email'),
            const Gap(15),
            CustomTextFormField(
              controller: subjectController,
              hintText: 'Subject',
            ),
            const Gap(15),
            CustomTextFormField(
              controller: messageController,
              hintText: 'Message',
              minLines: 4,
            ),
            const Gap(30),
            CustomButton(text: 'Send', fontSize: 18, onPressed: contactUs),
            const Gap(18),
          ],
        ),
      ),
    );
  }
}
