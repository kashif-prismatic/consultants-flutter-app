import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/all_services_controller.dart';
import '../controllers/all_settings_controller.dart';
import '../controllers/general_controller.dart';
import '../routes.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_skeleton_loader.dart';
import '../widgets/lawyer_card_widget.dart';

// ignore: must_be_immutable
class QuickBuyServicesDetailScreen extends StatelessWidget {
  QuickBuyServicesDetailScreen({super.key});
  final logic = Get.put(AllServicesController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(
      builder: (generalController) {
        return GetBuilder<AllServicesController>(
          builder: (allServicesController) {
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
                    text: allServicesController.selectedServiceForView.name,
                    style: AppTextStyles.appbarTextStyle2,
                    children: const <TextSpan>[],
                  ),
                ),
              ),
              body: !allServicesController.allServicesLoader
                  ? CustomVerticalSkeletonLoader(
                      height: 200.h,
                      highlightColor: AppColors.grey,
                      seconds: 2,
                      totalCount: 5,
                      width: 140.w,
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: allServicesController
                                          .selectedServiceForView
                                          .image
                                          ?.length
                                          .toString !=
                                      'null'
                                  ? Image(
                                      image: NetworkImage(
                                          "$mediaUrl${allServicesController.selectedServiceForView.image}"),
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
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                    ),
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              // "Blog post title here Lorum Ipsum Dollar sit emit",
                              "${allServicesController.selectedServiceForView.name}",
                              style: AppTextStyles.bodyTextStyle8,
                            ),
                            SizedBox(height: 14.h),
                            Text(
                              // "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae arcu ac elit dapibus pharetra. Aliquam magna elit, porttitor a elementum Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae arcu ac elit dapibus pharetra. Aliquam magna elit, porttitor a elementum Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae arcu ac elit dapibus pharetra. Aliquam magna elit, porttitor a elementum Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam vitae arcu ac elit dapibus pharetra. Aliquam magna elit, porttitor a elementum",
                              "${allServicesController.selectedServiceForView.description}",
                              style: AppTextStyles.bodyTextStyle7,
                            ),
                            SizedBox(height: 14.h),
                            Container(
                                padding:
                                    EdgeInsets.fromLTRB(6.w, 6.h, 6.w, 6.h),
                                decoration: BoxDecoration(
                                    color: AppColors.tertiaryBgColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${LanguageConstant.fee.tr} ${Get.find<GetAllSettingsController>().getDisplayAmount(allServicesController.selectedServiceForView.price)}",
                                        style: AppTextStyles.bodyTextStyle11),
                                    ButtonWidgetOne(
                                      buttonText: LanguageConstant.buyNow.tr,
                                      onTap: () {
                                        Get.toNamed(
                                          PageRoutes.bookServiceScreen,
                                        );
                                      },
                                      buttonTextStyle:
                                          AppTextStyles.buttonTextStyle7,
                                      borderRadius: 10,
                                    ),
                                  ],
                                )),
                            SizedBox(height: 14.h),
                            Text(
                              LanguageConstant.serviceBy.tr,
                              textAlign: TextAlign.start,
                              style: AppTextStyles.bodyTextStyle10,
                            ),
                            SizedBox(height: 8.h),
                            allServicesController
                                        .selectedServiceForView.lawyer !=
                                    null
                                ? Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    margin: const EdgeInsets.only(bottom: 14),
                                    decoration: BoxDecoration(
                                      color: AppColors.tertiaryBgColor,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            // ignore: unrelated_type_equality_checks
                                            child: allServicesController
                                                        .selectedServiceForView
                                                        .lawyer!
                                                        .image
                                                        ?.length !=
                                                    null
                                                ? Image(
                                                    image: NetworkImage(
                                                        "$mediaUrl${allServicesController.selectedServiceForView.lawyer!.image}"),
                                                    height: 110.h,
                                                  )
                                                : Image(
                                                    image: const AssetImage(
                                                        'assets/images/lawyer-image.png'),
                                                    height: 110.h,
                                                  )),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 0, 6, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  allServicesController
                                                      .selectedServiceForView
                                                      .lawyer!
                                                      .name!,
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyles
                                                      .bodyTextStyle2,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  allServicesController
                                                      .selectedServiceForView
                                                      .lawyer!
                                                      .userName!,
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyles
                                                      .bodyTextStyle1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    margin: const EdgeInsets.only(bottom: 18),
                                    decoration: BoxDecoration(
                                      color: AppColors.tertiaryBgColor,
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            // ignore: unrelated_type_equality_checks
                                            child: allServicesController
                                                        .selectedServiceForView
                                                        .lawFirm!
                                                        .image
                                                        ?.length !=
                                                    null
                                                ? Image(
                                                    image: NetworkImage(
                                                        "$mediaUrl${allServicesController.selectedServiceForView.lawFirm!.image}"),
                                                    height: 110.h,
                                                  )
                                                : Image(
                                                    image: const AssetImage(
                                                        'assets/images/lawyer-image.png'),
                                                    height: 110.h,
                                                  )),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                12, 0, 6, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  allServicesController
                                                      .selectedServiceForView
                                                      .lawFirm!
                                                      .name!,
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyles
                                                      .bodyTextStyle2,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  allServicesController
                                                      .selectedServiceForView
                                                      .lawFirm!
                                                      .userName!,
                                                  textAlign: TextAlign.start,
                                                  style: AppTextStyles
                                                      .bodyTextStyle1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                            Text(
                              // "Frequently Ask a Question",
                              LanguageConstant.frequentlyAskaQuestion.tr,
                              textAlign: TextAlign.start,
                              style: AppTextStyles.bodyTextStyle10,
                            ),
                            SizedBox(height: 8.h),
                            ListView(
                              shrinkWrap: true,
                              // scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(
                                  allServicesController.selectedServiceForView
                                      .faqs!.length, (index) {
                                return Container(
                                  margin: EdgeInsets.fromLTRB(0, 8.h, 0, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppColors.tertiaryBgColor,
                                      border:
                                          Border.all(color: AppColors.black)),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      listTileTheme:
                                          ListTileTheme.of(context).copyWith(
                                        dense: true,
                                      ),
                                    ),
                                    child: ExpansionTile(
                                      leading: const Icon(
                                          Icons.question_mark_outlined),
                                      iconColor: AppColors.secondaryColor,
                                      title: Text(
                                        allServicesController
                                            .selectedServiceForView
                                            .faqs![index]
                                            .question!,
                                        style: AppTextStyles.bodyTextStyle2,
                                      ),
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              16.w, 8.h, 16.w, 16.h),
                                          child: Text(
                                            allServicesController
                                                .selectedServiceForView
                                                .faqs![index]
                                                .answer!,
                                            style: AppTextStyles.bodyTextStyle2,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
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
