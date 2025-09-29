import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../../multi_language/language_constants.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/all_blogs_controller.dart';
import '../controllers/all_services_controller.dart';
import '../controllers/all_settings_controller.dart';
import '../controllers/general_controller.dart';
import '../routes.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_skeleton_loader.dart';

class QuickBuyServicesScreen extends StatefulWidget {
  const QuickBuyServicesScreen({super.key});

  @override
  State<QuickBuyServicesScreen> createState() => QuickBuyServicesScreenState();
}

class QuickBuyServicesScreenState extends State<QuickBuyServicesScreen> {
  final logic = Get.put(AllBlogsController());
  // final List numbers = List.generate(30, (index) => "Item $index");

  @override
  void initState() {
    super.initState();
    // Get All Services on Home Page
    // postMethod(
    //     context, '$getAllServices?page=1', null, false, getAllServicesRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
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
                text: LanguageConstant.quickBuyServices.tr,
                style: AppTextStyles.appbarTextStyle2,
                children: <TextSpan>[],
              ),
            ),
          ),
          body: !allServicesController.allServicesLoader
              ? const CustomGridViewSkeletonLoader(
                  highlightColor: AppColors.grey,
                  seconds: 2,
                  totalCount: 5,
                  aspectRatio: 0.9,
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.count(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                        crossAxisCount: 2,
                        crossAxisSpacing: 18.0,
                        mainAxisSpacing: 12.0,
                        childAspectRatio: 0.7,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          allServicesController
                              .servicesListForPagination.length,
                          (index) {
                            return InkWell(
                              onTap: () {
                                allServicesController
                                    .updateSelectedServiceForView(
                                        allServicesController
                                            .servicesListForPagination[index]);

                                Get.toNamed(PageRoutes.serviceDetailScreen);
                              },
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        // ignore: unrelated_type_equality_checks
                                        child: allServicesController
                                                    .servicesListForPagination[
                                                        index]
                                                    .image
                                                    ?.length
                                                    .toString !=
                                                'null'
                                            ? Image(
                                                image: NetworkImage(
                                                    "$mediaUrl${allServicesController.servicesListForPagination[index].image}"),
                                                fit: BoxFit.cover,
                                                height: 160.h,
                                                width: 160.w,
                                              )
                                            : Image(
                                                image: const AssetImage(
                                                    'assets/images/events-image-2.png'),
                                                height: 110.h,
                                              ),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      // "Blog post title here",
                                      "${allServicesController.servicesListForPagination[index].name}",
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodyTextStyle2,
                                    ),
                                    SizedBox(height: 4.h),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "${LanguageConstant.startFrom.tr} ${Get.find<GetAllSettingsController>().getDisplayAmount(allServicesController.servicesListForPagination[index].price)}",
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
                                            const AssetImage(
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
                        ),
                      ),
                      allServicesController.servicesListForPagination.length ==
                                  allServicesController
                                      .getAllServicesModel.data!.data!.length &&
                              allServicesController.getAllServicesModel.data!
                                      .meta!.currentPage !=
                                  allServicesController
                                      .getAllServicesModel.data!.meta!.lastPage
                          ? Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 18),
                              width: MediaQuery.of(context).size.width * .35,
                              child: generalController
                                      .getPaginationProgressCheck
                                  ? Container(
                                      height: generalController
                                              .getPaginationProgressCheck
                                          ? 50.0
                                          : 0,
                                      color: Colors.transparent,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                    )
                                  : ButtonWidgetOne(
                                      buttonText: LanguageConstant.loadMore.tr,
                                      onTap: () {
                                        allServicesController
                                            .paginationDataLoad(context);
                                      },
                                      buttonTextStyle:
                                          AppTextStyles.buttonTextStyle7,
                                      borderRadius: 5,
                                    ))
                          : const SizedBox(),
                    ],
                  ),
                ),
        );
      });
    });
  }
}
