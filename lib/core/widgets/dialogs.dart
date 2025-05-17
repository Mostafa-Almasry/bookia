import 'package:bookia/core/services/image_helper.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

enum ToastType { success, error }

showToast(
  BuildContext context,
  String message, {
  ToastType type = ToastType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor:
          type == ToastType.success
              ? AppColors.primaryColor
              : AppColors.redColor,
      content: Center(
        child: Text(
          message,
          style: getSmallTextStyle(color: AppColors.whiteColor, fontSize: 16),
        ),
      ),
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible:
        false, // So that the user can't dissmiss the loading circle

    barrierColor: AppColors.darkColor.withOpacity(0.7),
    context: context,
    builder:
        (context) => Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LottieBuilder.asset('assets/images/loading.json')],
          ),
        ),
  );
}

showPfpBottomSheet(BuildContext context, Function(String) onImageSelected) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isDismissible: true,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: 'Upload From Camera',
              width: double.infinity,

              onPressed: () async {
                final navigator = Navigator.of(context);
                String? imagePath = await ImageHelper.pickImage(
                  fromCamera: true,
                );
                if (imagePath != null) {
                  onImageSelected(imagePath);
                }
                navigator.pop();
              },
            ),
            const SizedBox(height: 15),
            CustomButton(
              text: 'Upload From Gallery',
              width: double.infinity,
              onPressed: () async {
                final navigator = Navigator.of(context);
                String? imagePath = await ImageHelper.pickImage(
                  fromCamera: false,
                );
                if (imagePath != null) {
                  onImageSelected(imagePath);
                }
                navigator.pop();
              },
            ),
            const Gap(5),
          ],
        ),
      );
    },
  );
}

// final TextEditingController nameController = TextEditingController();

// Future<String?> showNameBottomSheet(BuildContext context) async {
//   return await showModalBottomSheet<String>(
//     context: context,
//     backgroundColor: Colors.white,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     isDismissible: true,
//     isScrollControlled: true,
//     builder: (context) {
//       return Padding(
//         padding: EdgeInsets.only(
//           left: 16,
//           right: 16,
//           top: 16,
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 controller: nameController,
//                 decoration: InputDecoration(labelText: 'Enter new name'),
//               ),
//               const SizedBox(height: 10),
//               CustomButton(
//                 text: 'Update Your Name',
//                 width: double.infinity,
//                 onPressed: () {
//                   Navigator.pop(context, nameController.text);
//                 },
//               ),
//               const Gap(10)
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }
