import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lawyer_consultant/src/controllers/all_services_controller.dart';

import 'package:lawyer_consultant/src/widgets/button_widget.dart';
import 'package:resize/resize.dart';
import 'package:dio/dio.dart' as dio_instance;
import '../../multi_language/language_constants.dart';
import '../api_services/get_service.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/all_settings_controller.dart';

import '../controllers/lawyer_book_service_controller.dart';
import '../controllers/make_payment_controller.dart';
import '../controllers/payment_gateways_controller.dart';
import '../repositories/get_payment_gateways_repo.dart';

import '../repositories/make_payment_repo.dart';
import '../widgets/appbar_widget.dart';

class BookServiceScreen extends StatefulWidget {
  // final num? appointmentTypeId;
  const BookServiceScreen({
    super.key,
    // this.appointmentTypeId,
  });

  @override
  State<BookServiceScreen> createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  final lawyerBookServicelogic = Get.put(LawyerBookServiceController());

  final paymentGatewaysLogic = Get.put(PaymentGatewaysController());
  final makePaymentLogic = Get.put(MakePaymentController());

  String formattedDate = DateFormat.yMd().format(DateTime.now());
  String values = 'no';
  int indexPage = 0;
  int activeStep = 3;
  int upperBound = 4;
  bool boolValue = false;
  int? value;
  var selectedSlot;
  File? file;
  dynamic selectedPaymentGateway;
  DateTime selectedDate = DateTime.now();

  var dayToday = DateFormat('EEEE').format(DateTime.now());
  filePick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        file = File(result.files.single.path!);
      });

      print(file!.path);
    } else {
      // User canceled the picker
    }
  }

  @override
  void initState() {
    super.initState();

    print(
        "${Get.find<AllServicesController>().selectedServiceForView.id} SERVICE ID");

    getMethod(
        context, getPaymentGatewaysURL, null, false, getPaymentGatewaysRepo);
    print("$selectedDate DateNow");
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LawyerBookServiceController>(
        builder: (lawyerBookServiceController) {
      return Scaffold(
        backgroundColor: AppColors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: AppBarWidget(
            richTextSpan: TextSpan(
              text: LanguageConstant.bookService.tr,
              style: AppTextStyles.appbarTextStyle2,
              children: <TextSpan>[],
            ),
            leadingIcon: "assets/icons/Expand_left.png",
            leadingOnTap: () {
              if (indexPage > 0) {
                setState(() {
                  indexPage--;
                });
              } else {
                Get.back();
                indexPage = 0;
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Divider(
                        thickness: 4,
                        height: 4,
                        color: indexPage >= 0
                            ? AppColors.primaryColor
                            : AppColors.lightGrey,
                      ),
                    ),
                  ),
                  Container(
                    height: 21,
                    width: 21,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: indexPage >= 0
                          ? AppColors.primaryColor
                          : AppColors.lightGrey,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Divider(
                        thickness: 4,
                        height: 4,
                        color: indexPage >= 1
                            ? AppColors.primaryColor
                            : AppColors.lightGrey,
                      ),
                    ),
                  ),
                  Container(
                    height: 21,
                    width: 21,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: indexPage >= 1
                          ? AppColors.primaryColor
                          : AppColors.lightGrey,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Divider(
                        thickness: 4,
                        height: 4,
                        color: indexPage >= 2
                            ? AppColors.primaryColor
                            : AppColors.lightGrey,
                      ),
                    ),
                  ),
                  Container(
                    height: 21,
                    width: 21,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: indexPage >= 2
                          ? AppColors.primaryColor
                          : AppColors.lightGrey,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Divider(
                        thickness: 4,
                        height: 4,
                        color: indexPage >= 3
                            ? AppColors.primaryColor
                            : AppColors.lightGrey,
                      ),
                    ),
                  ),
                ],
              ),
              indexPage == 0
                  ? personalInformation()
                  : indexPage == 1
                      ?
                      // ? !lawyerBookServiceController.getLawyerBookServiceLoader
                      //     ?
                      //     Padding(
                      //         padding: EdgeInsets.fromLTRB(0, 250.h, 0, 250.h),
                      //         child: const CircularProgressIndicator(
                      //           backgroundColor: AppColors.transparent,
                      //           color: AppColors.primaryColor,
                      //         ),
                      //       )
                      //     :
                      timeSchedule()
                      : indexPage == 2
                          ? paymentMethod()
                          : paymentMethod(),
            ],
          ),
        ),
      );
    });
  }

// Payment Method
  Widget paymentMethod() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageConstant.chooseYourPaymentMethod.tr,
            style: AppTextStyles.headingTextStyle4,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              gradient: AppColors.gradientThree,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  // "Total you have to pay: ",
                  LanguageConstant.totalYouHaveToPay.tr,
                  style: AppTextStyles.subHeadingTextStyle1,
                ),
                Text(
                  Get.find<GetAllSettingsController>().getDisplayAmount(
                      Get.find<AllServicesController>()
                          .selectedServiceForView
                          .price!),
                  style: AppTextStyles.subHeadingTextStyle2,
                )
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.white, //background color of dropdown button
              border: Border.all(
                  color: AppColors.black, width: 1), //border of dropdown button
              borderRadius:
                  BorderRadius.circular(10), //border raiuds of dropdown button
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 5.h),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 1,
                  physics: const AlwaysScrollableScrollPhysics(),
                  // padding: const EdgeInsets.only(top: 18),
                  itemBuilder: (context, index) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButtonFormField(
                        hint: Text(
                          LanguageConstant.pleaseChoosePaymentMethod.tr,
                          style: AppTextStyles.bodyTextStyle11,
                        ), // Not necessary for Option 1
                        value: selectedPaymentGateway,

                        items: Get.find<PaymentGatewaysController>()
                            .getPaymentGatewaysModel
                            .data!
                            .map((gatewaysName) {
                          return DropdownMenuItem(
                            value: gatewaysName.code,
                            child: DropdownMenuItem(
                              child: Row(
                                children: [
                                  Image.network(
                                    "$mediaUrl${gatewaysName.image!}",
                                    height: 35.h,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(gatewaysName.name!,
                                      style: AppTextStyles.bodyTextStyle11),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedPaymentGateway = newValue;

                            print(
                                "GATEWAYS SELECTED NAME ${selectedPaymentGateway}");
                          });
                        },
                        decoration:
                            const InputDecoration.collapsed(hintText: ''),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.secondaryColor,
                        ),
                        iconEnabledColor: Colors.white, //Icon color
                        style: AppTextStyles.subHeadingTextStyle1,
                        dropdownColor:
                            AppColors.white, //dropdown background color
                        isExpanded: true, //make true to make width 100%
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidgetOne(
                onTap: () {
                  // Book Service API Make Payment
                  postMethodwithFile(
                      context,
                      customerBookService,
                      dio_instance.FormData.fromMap(
                        <String, dynamic>{
                          "service_id": Get.find<AllServicesController>()
                              .selectedServiceForView
                              .id,
                          "question": Get.find<LawyerBookServiceController>()
                              .serviceQuestionFieldController
                              .text,
                          "date": selectedDate.toString(),
                          "attachment": file?.path,
                          "gateway": selectedPaymentGateway,
                        },
                      ),
                      true,
                      makeServicePaymentRepo);
                },
                buttonText: LanguageConstant.makePayment.tr,
                buttonTextStyle: AppTextStyles.buttonTextStyle9,
                borderRadius: 10,
              ),
              Get.find<GetAllSettingsController>()
                          .getAllSettingsModel
                          .data!
                          .enableWalletSystem ==
                      "1"
                  ? Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: ButtonWidgetOne(
                        onTap: () {
                          // Book Service API Make Payment via Wallet
                          postMethod(
                              context,
                              customerBookService,
                              {
                                "service_id": Get.find<AllServicesController>()
                                    .selectedServiceForView
                                    .id,
                                "question":
                                    Get.find<LawyerBookServiceController>()
                                        .serviceQuestionFieldController
                                        .text,
                                "date": selectedDate.toString(),
                                "attachment": file?.path,
                                "gateway": "wallet",
                              },
                              true,
                              makeServicePaymentViaWalletRepo);
                        },
                        buttonText: LanguageConstant.payViaWallet.tr,
                        buttonTextStyle: AppTextStyles.buttonTextStyle9,
                        borderRadius: 10,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

// Time Schedule
  Widget timeSchedule() {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 18.h),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 18.h),
              Row(
                children: [
                  Text(
                    "$dayToday / ",
                    textAlign: TextAlign.start,
                    style: AppTextStyles.subHeadingTextStyle1,
                  ),
                  Text(
                    "${selectedDate.toLocal()}".split(' ')[0],
                    textAlign: TextAlign.start,
                    style: AppTextStyles.subHeadingTextStyle1,
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
                      padding: EdgeInsets.fromLTRB(0, 18.h, 0, 18.h),
                      decoration: BoxDecoration(
                          color: AppColors.tertiaryBgColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.black)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LanguageConstant.serviceBy.tr,
                            style: AppTextStyles.headingTextStyle2,
                          ),
                          Text(
                            Get.find<AllServicesController>()
                                    .selectedServiceForView
                                    .lawyer
                                    ?.name ??
                                Get.find<AllServicesController>()
                                    .selectedServiceForView
                                    .lawFirm
                                    ?.name ??
                                "",
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
                      padding: EdgeInsets.fromLTRB(0, 18.h, 0, 18.h),
                      decoration: BoxDecoration(
                          color: AppColors.tertiaryBgColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.black)),
                      child: Column(
                        children: [
                          Text(
                            LanguageConstant.serviceFee.tr,
                            style: AppTextStyles.headingTextStyle2,
                          ),
                          Text(
                            Get.find<GetAllSettingsController>()
                                .getDisplayAmount(
                                    Get.find<AllServicesController>()
                                        .selectedServiceForView
                                        .price!),
                            style: AppTextStyles.subHeadingTextStyle1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18.h),
              ButtonWidgetOne(
                onTap: () {
                  setState(() {
                    indexPage++;
                  });
                },
                buttonText: LanguageConstant.continuE.tr,
                buttonTextStyle: AppTextStyles.buttonTextStyle1,
                borderRadius: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }

// Personal Information
  Widget personalInformation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LanguageConstant.enterYourInformation.tr,
            style: AppTextStyles.headingTextStyle4,
          ),
          SizedBox(height: 18.h),
          TextField(
            style: AppTextStyles.hintTextStyle1,
            maxLines: 5,
            controller: Get.find<LawyerBookServiceController>()
                .serviceQuestionFieldController,
            decoration: InputDecoration(
              hintText: LanguageConstant.writeYourQuestionHere.tr,
              hintStyle: AppTextStyles.hintTextStyle1,
              labelStyle: AppTextStyles.hintTextStyle1,
              contentPadding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColors.black),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            LanguageConstant.doYouHaveImageWithYou.tr,
            style: AppTextStyles.subHeadingTextStyle1,
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: Text(
                    LanguageConstant.no.tr,
                    style: AppTextStyles.bodyTextStyle7,
                  ),
                  activeColor: AppColors.primaryColor,
                  selected: true,
                  value: "no",
                  groupValue: values,
                  onChanged: (value) {
                    setState(() {
                      values = value.toString();
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: Text(
                    LanguageConstant.yes.tr,
                    style: AppTextStyles.bodyTextStyle7,
                  ),
                  activeColor: AppColors.primaryColor,
                  value: "yes",
                  groupValue: values,
                  onChanged: (value) {
                    setState(() {
                      values = value.toString();
                    });
                  },
                ),
              ),
            ],
          ),
          values == 'no'
              ? Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 24),
                )
              : GestureDetector(
                  onTap: () {
                    filePick();
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 24),
                    decoration: BoxDecoration(
                        color: AppColors.tertiaryBgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.black)),
                    child: file == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LanguageConstant.uploadImage.tr,
                                style: AppTextStyles.buttonTextStyle7,
                              ),
                              SizedBox(width: 10.w),
                              Image.asset("assets/icons/Upload.png")
                            ],
                          )
                        : Center(
                            child: Text(
                              file!.path.toString().split("/").last.toString(),
                              style: AppTextStyles.buttonTextStyle7,
                            ),
                          ),
                  ),
                ),
          ButtonWidgetOne(
            onTap: () {
              setState(() {
                indexPage++;
                print(
                    "${Get.find<LawyerBookServiceController>().serviceQuestionFieldController.text} SERVICEQUESTION");
                print("${file?.path} PATHSERVICE");
              });
            },
            buttonText: LanguageConstant.continuE.tr,
            buttonTextStyle: AppTextStyles.buttonTextStyle1,
            borderRadius: 10,
          ),
        ],
      ),
    );
  }
}
