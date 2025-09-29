import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/config/app_colors.dart';
import 'package:lawyer_consultant/src/controllers/search_controller.dart';
import 'package:lawyer_consultant/src/widgets/home_banner_slider_widget.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../config/app_text_styles.dart';
import '../controllers/general_controller.dart';
import '../controllers/lawyer_appointment_types_controller.dart';
import '../routes.dart';
import '../widgets/home_all_lawyers_list_widget.dart';
import '../widgets/home_buy_services_list_widget.dart';
import '../widgets/home_categories_list_widget.dart';
import '../widgets/home_featured_lawyers_list_widget.dart';
import '../widgets/home_law_firms_list_widget.dart';
import '../widgets/home_top_rated_lawyers_list_widget.dart';
import '../widgets/home_upcoming_events_list_widget.dart';
import '../widgets/search_filter_widget.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback allCategoryOnTap, searchOnTap;
  const HomeScreen(
      {super.key, required this.allCategoryOnTap, required this.searchOnTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int isLawyerListSelected = 0;

  final lawyerAppointmentTypeslogic =
      Get.put(LawyerAppointmentTypesController());

  @override
  void initState() {
    Get.find<SearchBarController>().searchTextController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 30),
                child: HomeBannerSliderWidget(),
              ),
              generalController.storageBox.read('authToken') != null
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                      child: RichText(
                        textAlign: TextAlign.start,
                        softWrap: true,
                        text: TextSpan(
                          text:
                              "Hello ${generalController.currentUserModel!.loginInfo!.name} ",
                          style: AppTextStyles.headingTextStyle1,
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '| ${LanguageConstant.findYourConsultant.tr}',
                              style: AppTextStyles.headingTextStyle2,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(PageRoutes.signinScreen);
                        },
                        child: RichText(
                          textAlign: TextAlign.start,
                          softWrap: true,
                          text: TextSpan(
                            text: "${LanguageConstant.signIn.tr} ",
                            style: AppTextStyles.headingTextStyle1,
                            children: <TextSpan>[
                              TextSpan(
                                text:
                                    '| ${LanguageConstant.findYourConsultant.tr}',
                                style: AppTextStyles.headingTextStyle2,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              SearchFilterWidget(
                onSearchTap: widget.searchOnTap,
                controller:
                    Get.find<SearchBarController>().searchTextController,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      LanguageConstant.categories.tr,
                      style: AppTextStyles.headingTextStyle2,
                    ),
                    GestureDetector(
                      onTap: widget.allCategoryOnTap,
                      child: Text(
                        LanguageConstant.all.tr,
                        style: AppTextStyles.headingTextStyle3,
                      ),
                    ),
                  ],
                ),
              ),
              HomeCategoriesListWidget(
                categoryOnTap: widget.allCategoryOnTap,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      LanguageConstant.qualifiedLawyers.tr,
                      style: AppTextStyles.headingTextStyle2,
                    ),
                    Row(
                      children: [
                        isLawyerListSelected == 0
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  LanguageConstant.all.tr,
                                  style: AppTextStyles.buttonTextStyle6,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLawyerListSelected = 0;
                                  });
                                },
                                child: Text(
                                  LanguageConstant.all.tr,
                                  style: AppTextStyles.buttonTextStyle4,
                                ),
                              ),
                        const SizedBox(width: 10),
                        isLawyerListSelected == 1
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  LanguageConstant.topRated.tr,
                                  style: AppTextStyles.buttonTextStyle6,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLawyerListSelected = 1;
                                  });
                                },
                                child: Text(
                                  LanguageConstant.topRated.tr,
                                  style: AppTextStyles.buttonTextStyle4,
                                ),
                              ),
                        SizedBox(width: 10.w),
                        isLawyerListSelected == 2
                            ? Container(
                                padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Text(
                                  LanguageConstant.featured.tr,
                                  style: AppTextStyles.buttonTextStyle6,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLawyerListSelected = 2;
                                  });
                                },
                                child: Text(
                                  LanguageConstant.featured.tr,
                                  style: AppTextStyles.buttonTextStyle4,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
              isLawyerListSelected == 0
                  ? const HomeAllLawyersListWidget()
                  : isLawyerListSelected == 1
                      ? const HomeTopRatedLawyersListWidget()
                      : isLawyerListSelected == 2
                          ? const HomeFeaturedLawyersListWidget()
                          : SizedBox(
                              child: Center(
                                child: Text(
                                  LanguageConstant.noDataFound.tr,
                                  style: AppTextStyles.bodyTextStyle2,
                                ),
                              ),
                            ),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Law Firms",
                      style: AppTextStyles.headingTextStyle2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(PageRoutes.lawFirmsScreen);
                      },
                      child: Text(
                        LanguageConstant.all.tr,
                        style: AppTextStyles.headingTextStyle3,
                      ),
                    ),
                  ],
                ),
              ),
              const HomeLawFirmsListWidget(),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      LanguageConstant.quickBuyServices.tr,
                      style: AppTextStyles.headingTextStyle2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(PageRoutes.servicesScreen);
                      },
                      child: Text(
                        LanguageConstant.all.tr,
                        style: AppTextStyles.headingTextStyle3,
                      ),
                    ),
                  ],
                ),
              ),
              const HomeBuyServicesListWidget(),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      LanguageConstant.upcomingEvents.tr,
                      style: AppTextStyles.headingTextStyle2,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(PageRoutes.eventsScreen);
                      },
                      child: Text(
                        LanguageConstant.all.tr,
                        style: AppTextStyles.headingTextStyle3,
                      ),
                    ),
                  ],
                ),
              ),
              const HomeUpcomingEventsListWidget(),
            ],
          ),
        ),
      );
    });
  }
}
