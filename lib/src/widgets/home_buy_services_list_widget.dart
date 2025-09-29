import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/all_services_controller.dart';
import '../controllers/all_settings_controller.dart';
import '../controllers/general_controller.dart';
import '../routes.dart';
import 'custom_skeleton_loader.dart';

class HomeBuyServicesListWidget extends StatefulWidget {
  const HomeBuyServicesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  _HomeBuyServicesListWidgetState createState() =>
      _HomeBuyServicesListWidgetState();
}

class _HomeBuyServicesListWidgetState extends State<HomeBuyServicesListWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<AllServicesController>(
          builder: (allServicesController) {
        return !allServicesController.allServicesLoader
            ? CustomHorizontalSkeletonLoader(
                containerHeight: 140.h,
                listHeight: 140.h,
                highlightColor: AppColors.grey,
                seconds: 2,
                totalCount: 5,
                containerWidth: 110.w,
              )
            : allServicesController.getAllServicesModel.data!.data!.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 3 / 1.74,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: allServicesController
                              .getAllServicesModel.data!.data!.length,
                          padding: EdgeInsets.fromLTRB(18.w, 0, 18.w, 0),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                allServicesController
                                    .updateSelectedServiceForView(
                                        allServicesController
                                            .getAllServicesModel
                                            .data!
                                            .data![index]);
                                Get.toNamed(PageRoutes.serviceDetailScreen);
                              },
                              child: Container(
                                padding:
                                    EdgeInsets.fromLTRB(8.w, 8.w, 8.w, 8.w),
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.black),
                                    borderRadius: BorderRadius.circular(18)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: allServicesController
                                                  .getAllServicesModel
                                                  .data!
                                                  .data![index]
                                                  .image
                                                  .toString !=
                                              'null'
                                          ? Image(
                                              image: NetworkImage(
                                                  "$mediaUrl${allServicesController.getAllServicesModel.data!.data![index].image}"),
                                              height: 150.h,
                                            )
                                          : Image(
                                              image: const AssetImage(
                                                  'assets/images/events-image-2.png'),
                                              height: 150.h,
                                            ),
                                    ),
                                    SizedBox(height: 12.h),
                                    Text(
                                      allServicesController.getAllServicesModel
                                          .data!.data![index].name
                                          .toString(),
                                      // "Legal Consultation",
                                      style: AppTextStyles.bodyTextStyle2,
                                    ),
                                    SizedBox(height: 6.h),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          Get.find<GetAllSettingsController>()
                                              .getDisplayAmount(
                                                  allServicesController
                                                      .getAllServicesModel
                                                      .data!
                                                      .data![index]
                                                      .price),
                                          style: AppTextStyles.bodyTextStyle3,
                                        ),
                                        SizedBox(width: 8.w),
                                        Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: AppColors.black,
                                                  width: 2)),
                                          child: ImageIcon(
                                            AssetImage(
                                                "assets/icons/Expand_right.png"),
                                            size: 16.h,
                                            color: AppColors.secondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, position) {
                            return SizedBox(width: 18.w);
                          },
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    child: Center(
                      child: Text(
                        "No Data Found",
                        style: AppTextStyles.bodyTextStyle2,
                      ),
                    ),
                  );
      });
    });
  }
}
