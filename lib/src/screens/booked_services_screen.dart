import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/models/customer_appointment_history_model.dart';
import 'package:lawyer_consultant/src/models/customer_booked_services_model.dart';
import 'package:resize/resize.dart';

import '../../multi_language/language_constants.dart';
import '../api_services/get_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/customer_booked_services_controller.dart';
import '../controllers/general_controller.dart';

import '../repositories/customer_booked_services_repo.dart';
import '../routes.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_skeleton_loader.dart';
import 'appointment_detail_screen.dart';

class BookedServicesScreen extends StatefulWidget {
  const BookedServicesScreen({super.key});

  @override
  State<BookedServicesScreen> createState() => _BookedServicesScreenState();
}

class _BookedServicesScreenState extends State<BookedServicesScreen> {
  final logic = Get.put(CustomerBookedServicesController());

  List<GetCustomerBookedServicesModel>? pendingList = [];
  String? fromBookService = Get.parameters["fromBookService"];

  @override
  void initState() {
    super.initState();
    getMethod(context, "$getCustomerBookedServicesHistory?page=1", null, true,
        getAllCustomerBookedServicesRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerBookedServicesController>(
        builder: (customerBookedServicesController) {
      return GetBuilder<GeneralController>(builder: (generalController) {
        return DefaultTabController(
          length: 4, // length of tabs
          initialIndex: 0,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: AppBarWidget(
                richTextSpan: TextSpan(
                  text: LanguageConstant.bookedServices.tr,
                  style: AppTextStyles.appbarTextStyle2,
                  children: <TextSpan>[],
                ),
                leadingIcon: "assets/icons/Expand_left.png",
                leadingOnTap: () {
                  fromBookService == "Yes"
                      ? Get.toNamed(PageRoutes.homeScreen)
                      : Get.back();
                },
              ),
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Theme(
                    data: ThemeData()
                        .copyWith(dividerColor: AppColors.primaryColor),
                    child: TabBar(
                      labelColor: AppColors.white,
                      unselectedLabelColor: AppColors.secondaryColor,
                      dividerColor: AppColors.transparent,
                      padding: const EdgeInsets.fromLTRB(3, 6, 3, 6),
                      indicatorPadding: const EdgeInsets.fromLTRB(-6, 4, -6, 4),
                      labelPadding: EdgeInsets.zero,
                      labelStyle: AppTextStyles.buttonTextStyle2,
                      unselectedLabelStyle: AppTextStyles.buttonTextStyle7,
                      indicator: BoxDecoration(
                          gradient: AppColors.gradientOne,
                          borderRadius: BorderRadius.circular(10)),
                      tabs: [
                        Tab(text: LanguageConstant.all.tr),
                        Tab(text: LanguageConstant.pending.tr),
                        Tab(text: LanguageConstant.accepted.tr),
                        Tab(text: LanguageConstant.completed.tr),
                      ],
                    ),
                  ),
                  !customerBookedServicesController
                          .allCustomerBookedServicesLoader
                      ? Expanded(
                          child: CustomVerticalSkeletonLoader(
                            height: 200.h,
                            highlightColor: AppColors.grey,
                            seconds: 2,
                            totalCount: 5,
                            width: 140.w,
                          ),
                        )
                      : Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 1))),
                            child: TabBarView(children: <Widget>[
                              // All Appointment History
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: customerBookedServicesController
                                    .customerAllBookedServicesListForPagination
                                    .length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: const EdgeInsets.only(top: 18),
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        18, 0, 18, 18),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 12, 12, 12),
                                          // margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                          decoration: BoxDecoration(
                                            color: AppColors.tertiaryBgColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  customerBookedServicesController
                                                              .customerAllBookedServicesListForPagination[
                                                                  index]
                                                              .serviceImage ==
                                                          null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                          child: Image.asset(
                                                            scale: 4.h,
                                                            'assets/images/lawyer-image.png',
                                                            fit: BoxFit.cover,
                                                            height: 110.h,
                                                            width: 120.w,
                                                          ))
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                          child: Image.network(
                                                            scale: 4.h,
                                                            '$mediaUrl${customerBookedServicesController.customerAllBookedServicesListForPagination[index].serviceImage!}',
                                                            fit: BoxFit.cover,
                                                            height: 110.h,
                                                            width: 120.w,
                                                          )),
                                                  SizedBox(
                                                    width: 12.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                // "Jhon Doe",
                                                                customerBookedServicesController
                                                                        .customerAllBookedServicesListForPagination[
                                                                            index]
                                                                        .serviceName ??
                                                                    "",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style: AppTextStyles
                                                                    .bodyTextStyle10,
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      5,
                                                                      2,
                                                                      5,
                                                                      2),
                                                              decoration: BoxDecoration(
                                                                  color: customerBookedServicesController.customerAllBookedServicesListForPagination[index].serviceStatusCode! == 1
                                                                      ? AppColors.primaryColor
                                                                      : customerBookedServicesController.customerAllBookedServicesListForPagination[index].serviceStatusCode! == 5
                                                                          ? AppColors.green.withOpacity(0.5)
                                                                          : customerBookedServicesController.customerAllBookedServicesListForPagination[index].serviceStatusCode! == 2
                                                                              ? AppColors.orange.withOpacity(0.5)
                                                                              : AppColors.primaryColor,
                                                                  borderRadius: BorderRadius.circular(5)),
                                                              child: Text(
                                                                // "Pending",
                                                                customerBookedServicesController
                                                                    .customerAllBookedServicesListForPagination[
                                                                        index]
                                                                    .serviceStatusName!,
                                                                style: AppTextStyles
                                                                    .bodyTextStyle4,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 16.h,
                                                        ),
                                                        Text(
                                                          customerBookedServicesController
                                                                  .customerAllBookedServicesListForPagination[
                                                                      index]
                                                                  .lawyerName ??
                                                              customerBookedServicesController
                                                                  .customerAllBookedServicesListForPagination[
                                                                      index]
                                                                  .lawFirmName ??
                                                              "",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: AppTextStyles
                                                              .bodyTextStyle3,
                                                        ),
                                                        SizedBox(
                                                          height: 16.h,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            generalController
                                                                .updateSelectedBookedServicesForView(
                                                                    customerBookedServicesController
                                                                            .customerAllBookedServicesListForPagination[
                                                                        index]);
                                                            Get.toNamed(PageRoutes
                                                                .bookedServiceDetailScreen);
                                                          },
                                                          child: Text(
                                                            LanguageConstant
                                                                .viewDetail.tr,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: AppTextStyles
                                                                .bodyTextStyle1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 8, 20, 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomRight:
                                                    Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                              gradient: AppColors.gradientOne),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/Date_range_light.png",
                                                    color: AppColors.white,
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Text(
                                                    // "Mon, 28th March, 2023",
                                                    customerBookedServicesController
                                                        .customerAllBookedServicesListForPagination[
                                                            index]
                                                        .date!,
                                                    style: AppTextStyles
                                                        .bodyTextStyle6,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/🦆 icon _Video_.png",
                                                    height: 16.h,
                                                    color: AppColors.white,
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Text(
                                                    LanguageConstant.service.tr,
                                                    style: AppTextStyles
                                                        .bodyTextStyle6,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              // Pending Appointment History
                              bookedServicesWidget(
                                  1,
                                  customerBookedServicesController,
                                  generalController),
                              // Accepted Appointment History
                              bookedServicesWidget(
                                  2,
                                  customerBookedServicesController,
                                  generalController),
                              // Completed Appointment History
                              bookedServicesWidget(
                                  5,
                                  customerBookedServicesController,
                                  generalController),
                            ]),
                          ),
                        )
                ]),
          ),
        );
      });
    });
  }

  // Booked Services
  Widget bookedServicesWidget(
      int statusCode,
      CustomerBookedServicesController customerBookedServicesController,
      GeneralController generalController) {
    return customerBookedServicesController
            .customerAllBookedServicesListForPagination
            .where((i) => i.serviceStatusCode == statusCode)
            .toList()
            .isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            // ignore: iterable_contains_unrelated_type
            itemCount: customerBookedServicesController
                .customerAllBookedServicesListForPagination
                .where((i) => i.serviceStatusCode == statusCode)
                .toList()
                .length,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 18),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      // margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                      decoration: BoxDecoration(
                        color: AppColors.tertiaryBgColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              customerBookedServicesController
                                          .customerAllBookedServicesListForPagination
                                          .where((i) =>
                                              i.serviceStatusCode == statusCode)
                                          .toList()[index]
                                          .serviceImage ==
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
                                        '$mediaUrl${customerBookedServicesController.customerAllBookedServicesListForPagination.where((i) => i.serviceStatusCode == statusCode).toList()[index].serviceImage!}',
                                        fit: BoxFit.cover,
                                        height: 110.h,
                                        width: 120.w,
                                      )),
                              SizedBox(
                                width: 12.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            // "Jhon Doe",
                                            customerBookedServicesController
                                                    .customerAllBookedServicesListForPagination
                                                    .where((i) =>
                                                        i.serviceStatusCode ==
                                                        statusCode)
                                                    .toList()[index]
                                                    .serviceName ??
                                                "",
                                            textAlign: TextAlign.start,
                                            style:
                                                AppTextStyles.bodyTextStyle10,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 2, 5, 2),
                                          decoration: BoxDecoration(
                                              color: customerBookedServicesController
                                                          .customerAllBookedServicesListForPagination
                                                          .where((i) =>
                                                              i.serviceStatusCode ==
                                                              statusCode)
                                                          .toList()[index]
                                                          .serviceStatusCode! ==
                                                      1
                                                  ? AppColors.primaryColor
                                                  : customerBookedServicesController
                                                              .customerAllBookedServicesListForPagination
                                                              .where((i) =>
                                                                  i.serviceStatusCode ==
                                                                  statusCode)
                                                              .toList()[index]
                                                              .serviceStatusCode! ==
                                                          5
                                                      ? AppColors.green
                                                          .withOpacity(0.5)
                                                      : customerBookedServicesController
                                                                  .customerAllBookedServicesListForPagination
                                                                  .where((i) =>
                                                                      i.serviceStatusCode ==
                                                                      statusCode)
                                                                  .toList()[index]
                                                                  .serviceStatusCode! ==
                                                              2
                                                          ? AppColors.orange.withOpacity(0.5)
                                                          : AppColors.primaryColor,
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Text(
                                            // statusCode,
                                            customerBookedServicesController
                                                .customerAllBookedServicesListForPagination
                                                .where((i) =>
                                                    i.serviceStatusCode ==
                                                    statusCode)
                                                .toList()[index]
                                                .serviceStatusName!,
                                            style: AppTextStyles.bodyTextStyle4,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    Text(
                                      customerBookedServicesController
                                              .customerAllBookedServicesListForPagination
                                              .where((i) =>
                                                  i.serviceStatusCode ==
                                                  statusCode)
                                              .toList()[index]
                                              .lawyerName ??
                                          customerBookedServicesController
                                              .customerAllBookedServicesListForPagination
                                              .where((i) =>
                                                  i.serviceStatusCode ==
                                                  statusCode)
                                              .toList()[index]
                                              .lawFirmName ??
                                          "",
                                      textAlign: TextAlign.start,
                                      style: AppTextStyles.bodyTextStyle3,
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        generalController
                                            .updateSelectedBookedServicesForView(
                                                customerBookedServicesController
                                                    .customerAllBookedServicesListForPagination
                                                    .where((i) =>
                                                        i.serviceStatusCode ==
                                                        statusCode)
                                                    .toList()[index]);
                                        Get.toNamed(PageRoutes
                                            .bookedServiceDetailScreen);
                                      },
                                      child: Text(
                                        LanguageConstant.viewDetail.tr,
                                        textAlign: TextAlign.start,
                                        style: AppTextStyles.bodyTextStyle1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          gradient: AppColors.gradientOne),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/Date_range_light.png",
                                color: AppColors.white,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                // "Mon, 28th March, 2023",
                                customerBookedServicesController
                                    .customerAllBookedServicesListForPagination
                                    .where((i) =>
                                        i.serviceStatusCode == statusCode)
                                    .toList()[index]
                                    .date!,
                                style: AppTextStyles.bodyTextStyle6,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/🦆 icon _comments_.png",
                                height: 16.h,
                                color: AppColors.white,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                LanguageConstant.service.tr,
                                style: AppTextStyles.bodyTextStyle6,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        : Center(
            child: Text(
              LanguageConstant.noDataFound.tr,
              style: AppTextStyles.bodyTextStyle2,
            ),
          );
  }
}
