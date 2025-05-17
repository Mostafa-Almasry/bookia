import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/back_arrow_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});

  final List<Map<String, String>> faqList = [
    {
      "question": "What is Bookia?",
      "answer": "Bookia is a platform for discovering and Shopping Books.",
    },
    {
      "question": "How do I change my password?",
      "answer":
          "Go to your profile, then tap on 'Change Password' to update your credentials.",
    },
    {
      "question": "Can I delete my account?",
      "answer":
          "Yes, please contact support through the 'Contact Us' page and request account deletion.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: BackArrowWidget(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            children: [
              const Gap(50),
              Text('FAQs', style: getTitleTextStyle(context, fontSize: 30)),
              const Gap(75),
              Expanded(
                child: ListView.builder(
                  itemCount: faqList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Theme(
                          data: Theme.of(
                            context,
                          ).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.all(8),
                            title: Text(
                              faqList[index]["question"]!,
                              style: getBodyTextStyle(
                                context,
                                fontSize: 21,
                                color: AppColors.blackColor,
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  faqList[index]["answer"]!,
                                  style: getBodyTextStyle(
                                    context,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
