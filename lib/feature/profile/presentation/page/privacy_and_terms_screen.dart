import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/back_arrow_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PrivacyAndTermsScreen extends StatelessWidget {
  const PrivacyAndTermsScreen({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(50),
                Text(
                  'Privacy Policy & Terms of Use',
                  style: getTitleTextStyle(context, fontSize: 25),
                ),
                const Gap(75),

                Row(
                  children: [
                    Text('Privacy Policy:', style: getTitleTextStyle(context)),
                  ],
                ),
                Gap(20),
                Text(
                  """Lorem ipsum dolor sit amet, consectetur adipiscing elit. . In nec sodales purus. Donec ornare massa in magna fermentum, et pharetra nisi auctor. Nunc rhoncus volutpat porttitor. Nullam vehicula erat elit, a ultricies est porta quis. Vestibulum ac accumsan sapien. Duis eget erat sed nisi mollis pretium. Phasellus pharetra urna risus, ut vestibulum enim congue sit amet. Vivamus a dui cursus, porta purus et, luctus elit. Nam vitae dictum enim, vitae laoreet purus. Fusce at nulla eu augue ultrices porttitor""",
                ),
                Gap(40),
                Row(
                  children: [
                    Text('Terms Of Use:', style: getTitleTextStyle(context)),
                  ],
                ),
                Gap(20),
                Text(
                  """Lorem ipsum dolor sit amet, consectetur adipiscing elit. In ultricies dui et turpis posuere, eu varius turpis dapibus. Sed non risus ut turpis semper fringilla in eu odio. Pellentesque commodo lorem tempus, venenatis turpis vel, ultrices lectus. Nam laoreet rutrum nisi, at porttitor nibh varius a. Mauris quis lacus dignissim tellus lobortis vulputate. Sed vitae eros nibh. Ut a vehicula nibh, nec varius leo. Nam vitae odio aliquet, convallis ex vitae, cursus nisl. In leo purus, sodales quis ipsum sit amet, sagittis malesuada mi. Integer et ex eget enim congue consequat a a felis. Nam ut nisi a arcu tincidunt fermentum eget ut diam. Vivamus lobortis porttitor luctus. Proin viverra et urna id suscipit. Praesent fringilla lacus nec vestibulum maximus. Donec metus metus, eleifend in porta vel, posuere vel leo. Phasellus id suscipit lectus, a tristique ligula. Sed consequat eget dui eget vulputate. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer ac fermentum nisi. Ut a leo est. Suspendisse cursus leo id orci pulvinar, sed posuere diam commodo.""",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
