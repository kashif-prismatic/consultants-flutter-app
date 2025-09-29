import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lawyer_consultant/multi_language/language_constants.dart';
import 'package:resize/resize.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

import '../widgets/appbar_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBarWidget(
          leadingIcon: 'assets/icons/Expand_left.png',
          leadingOnTap: () {
            Get.back();
          },
          richTextSpan: TextSpan(
            text: LanguageConstant.aboutUs.tr,
            style: AppTextStyles.appbarTextStyle2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset("assets/images/aboutus-banner.png"),
              ),
              SizedBox(height: 18.h),
              Text(
                LanguageConstant.joinUsBeaLifeSaverForEachOthers.tr,
                style: AppTextStyles.bodyTextStyle8,
              ),
              SizedBox(height: 18.h),
              Text(
                LanguageConstant.loremIpsum.tr,
                // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae arcu ac elit dapibus pharetra. Aliquam magna elit, porttitor a elementum Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae arcu ac elit dapibus pharetra. Aliquam magna elit, porttitor a elementum",
                style: AppTextStyles.bodyTextStyle7,
              ),
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "1000+",
                            style: AppTextStyles.headingTextStyle2,
                          ),
                          Text(
                            LanguageConstant.lawyers.tr,
                            style: AppTextStyles.subHeadingTextStyle1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 18.w),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "5000+",
                            style: AppTextStyles.headingTextStyle2,
                          ),
                          Text(
                            LanguageConstant.users.tr,
                            style: AppTextStyles.subHeadingTextStyle1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "500+",
                            style: AppTextStyles.headingTextStyle2,
                          ),
                          Text(
                            LanguageConstant.lawCompanies.tr,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.subHeadingTextStyle1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 18.w),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "150+",
                            style: AppTextStyles.headingTextStyle2,
                          ),
                          Text(
                            LanguageConstant.eventOrganiser.tr,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.subHeadingTextStyle1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
