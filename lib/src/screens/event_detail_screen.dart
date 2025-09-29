import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

import '../controllers/all_events_controller.dart';
import '../controllers/general_controller.dart';
import '../widgets/appbar_widget.dart';

// ignore: must_be_immutable
class EventDetailScreen extends StatelessWidget {
  EventDetailScreen({super.key});
  final logic = Get.put(AllEventsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      builder: (generalController) {
        return GetBuilder<AllEventsController>(
          builder: (allEventsController) {
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
                    text: LanguageConstant.eventDetail.tr,
                    style: AppTextStyles.appbarTextStyle2,
                    children: <TextSpan>[],
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: generalController.selectedEventForView.image
                                    ?.length.toString !=
                                'null'
                            ? Image(
                                image: NetworkImage(
                                    "$mediaUrl${generalController.selectedEventForView.image}"),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200.h,
                              )
                            : Image(
                                image: const AssetImage(
                                    "assets/images/events-image-2.png"),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                              ),
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        // "Blog post title here Lorum Ipsum Dollar sit emit",
                        "${generalController.selectedEventForView.name}",
                        style: AppTextStyles.bodyTextStyle8,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae arcu ac elit dapibus pharetra. Aliquam magna elit, porttitor a elementum Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae arcu ac elit dapibus pharetra. Aliquam magna elit, porttitor a elementum Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae arcu ac elit dapibus pharetra. Aliquam magna elit, porttitor a elementum Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae arcu ac elit dapibus pharetra. Aliquam magna elit, porttitor a elementum",
                        "${generalController.selectedEventForView.description}",
                        style: AppTextStyles.bodyTextStyle7,
                      ),
                      SizedBox(height: 18.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                              decoration: BoxDecoration(
                                color: AppColors.tertiaryBgColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    LanguageConstant.eventStarts.tr,
                                    style: AppTextStyles.bodyTextStyle11,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "${DateTime.parse("${generalController.selectedEventForView.startsAt}").day}-${DateTime.parse("${generalController.selectedEventForView.startsAt}").month}-${DateTime.parse("${generalController.selectedEventForView.startsAt}").year}",
                                    style: AppTextStyles.bodyTextStyle12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 18.w),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                              decoration: BoxDecoration(
                                color: AppColors.tertiaryBgColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    LanguageConstant.eventEnds.tr,
                                    style: AppTextStyles.bodyTextStyle11,
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    "${DateTime.parse("${generalController.selectedEventForView.endsAt}").day}-${DateTime.parse("${generalController.selectedEventForView.endsAt}").month}-${DateTime.parse("${generalController.selectedEventForView.endsAt}").year}",
                                    style: AppTextStyles.bodyTextStyle12,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 18.h),
                      Text(
                        LanguageConstant.eventOrganiser.tr,
                        style: AppTextStyles.bodyTextStyle8,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "${generalController.selectedEventForView.lawyerName}",
                        style: AppTextStyles.bodyTextStyle10,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
