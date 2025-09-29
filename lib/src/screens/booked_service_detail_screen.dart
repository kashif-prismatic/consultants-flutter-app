import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/general_controller.dart';

import '../routes.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';

class BookedServiceDetailScreen extends StatefulWidget {
  const BookedServiceDetailScreen({super.key});

  @override
  State<BookedServiceDetailScreen> createState() =>
      BookedServiceDetailScreenState();
}

class BookedServiceDetailScreenState extends State<BookedServiceDetailScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
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
              text: LanguageConstant.bookedServiceDetail.tr,
              style: AppTextStyles.appbarTextStyle2,
              children: <TextSpan>[],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
                decoration: BoxDecoration(
                  gradient: AppColors.gradientOne,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    generalController
                                .selectedBookedServiceForView.serviceImage ==
                            null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.asset(
                              scale: 4.h,
                              'assets/images/lawyer-image.png',
                              fit: BoxFit.cover,
                              height: 110.h,
                              width: 120.w,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              scale: 4.h,
                              '$mediaUrl${generalController.selectedBookedServiceForView.serviceImage!}',
                              fit: BoxFit.cover,
                              height: 110.h,
                              width: 120.w,
                            ),
                          ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // "Lawyer Name",
                              generalController.selectedBookedServiceForView
                                      .lawyerName ??
                                  generalController.selectedBookedServiceForView
                                      .lawFirmName ??
                                  "",
                              style: AppTextStyles.bodyTextStyle5,
                            ),
                            SizedBox(height: 16.h),
                            Container(
                              padding:
                                  EdgeInsets.fromLTRB(10.w, 4.h, 10.w, 4.h),
                              decoration: BoxDecoration(
                                  color: generalController
                                              .selectedBookedServiceForView
                                              .serviceStatusCode! ==
                                          1
                                      ? AppColors.primaryColor
                                      : generalController
                                                  .selectedBookedServiceForView
                                                  .serviceStatusCode! ==
                                              5
                                          ? AppColors.green.withOpacity(0.5)
                                          : generalController
                                                      .selectedBookedServiceForView
                                                      .serviceStatusCode! ==
                                                  2
                                              ? AppColors.orange
                                                  .withOpacity(0.5)
                                              : AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                // "Pending",
                                generalController.selectedBookedServiceForView
                                    .serviceStatusName!,
                                style: AppTextStyles.bodyTextStyle13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
              Container(
                padding: EdgeInsets.fromLTRB(14.w, 17.h, 14.w, 17.h),
                margin: EdgeInsets.only(bottom: 18.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.tertiaryBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LanguageConstant.serviceName.tr,
                      style: AppTextStyles.headingTextStyle5,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      generalController
                              .selectedBookedServiceForView.serviceName ??
                          "",
                      style: AppTextStyles.bodyTextStyle7,
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      LanguageConstant.date.tr,
                      style: AppTextStyles.headingTextStyle5,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      generalController.selectedBookedServiceForView.date!,
                      style: AppTextStyles.bodyTextStyle7,
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      LanguageConstant.questions.tr,
                      style: AppTextStyles.headingTextStyle5,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      generalController.selectedBookedServiceForView.question ??
                          "",
                      style: AppTextStyles.bodyTextStyle7,
                    ),
                    SizedBox(height: 18.h),
                    Text(
                      LanguageConstant.paymentStatus.tr,
                      style: AppTextStyles.headingTextStyle5,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      generalController.selectedBookedServiceForView.isPaid == 1
                          ? LanguageConstant.paid.tr
                          : LanguageConstant.notPaid.tr,
                      style: AppTextStyles.bodyTextStyle7,
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 18.h),
              Container(
                padding: EdgeInsets.fromLTRB(14.w, 17.h, 14.w, 17.h),
                margin: EdgeInsets.only(bottom: 18.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.tertiaryBgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LanguageConstant.attachments.tr,
                      style: AppTextStyles.headingTextStyle5,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "",
                      // generalController
                      //     .selectedBookedServiceForView.attachmentUrl!
                      //     .toString(),
                      style: AppTextStyles.bodyTextStyle7,
                    ),
                  ],
                ),
              ),

              generalController
                          .selectedBookedServiceForView.serviceStatusCode ==
                      2
                  ? ButtonWidgetOne(
                      onTap: () {
                        Get.toNamed(PageRoutes.liveServiceChatScreen);
                      },
                      buttonText: LanguageConstant.chatNow.tr,
                      buttonTextStyle: AppTextStyles.buttonTextStyle1,
                      borderRadius: 10,
                    )
                  : Container(),
            ],
          ),
        ),
      );
    });
  }
}
