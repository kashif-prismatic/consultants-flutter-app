import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../../multi_language/language_constants.dart';
import '../api_services/post_service.dart';
import '../api_services/urls.dart';
import '../config/app_colors.dart';
import '../config/app_text_styles.dart';
import '../controllers/all_lawyers_controller.dart';
import '../controllers/general_controller.dart';
import '../controllers/search_controller.dart';
import '../repositories/all_lawyers_repo.dart';
import '../routes.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_skeleton_loader.dart';
import '../widgets/search_filter_widget.dart';

class LawyersScreen extends StatefulWidget {
  const LawyersScreen({super.key});

  @override
  State<LawyersScreen> createState() => _LawyersScreenState();
}

class _LawyersScreenState extends State<LawyersScreen> {
  final logic = Get.put(AllLawyersController());

  @override
  void initState() {
    super.initState();
    Get.find<SearchBarController>().searchTextController.clear();
    // postMethod(
    //     context, '$getAllLawyers?page=1', null, false, getAllLawyersRepo);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GeneralController>(builder: (generalController) {
      return GetBuilder<AllLawyersController>(builder: (allLawyersController) {
        return !allLawyersController.allLawyersLoader
            ? CustomVerticalSkeletonLoader(
                height: 200.h,
                highlightColor: AppColors.grey,
                seconds: 2,
                totalCount: 5,
                width: 140.w,
              )
            : Scaffold(
                backgroundColor: AppColors.white,
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 18),
                      SearchFilterWidget(
                        onSearchTap: () {
                          postMethod(
                              context,
                              getAllLawyers,
                              {
                                'search': Get.find<SearchBarController>()
                                    .searchTextController
                                    .text
                              },
                              false,
                              getAllSearchedLawyersRepo);
                        },
                        controller: Get.find<SearchBarController>()
                            .searchTextController,
                      ),
                      allLawyersController.lawyerListForPagination.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: allLawyersController
                                  .lawyerListForPagination.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                  margin:
                                      const EdgeInsets.fromLTRB(18, 0, 18, 18),
                                  decoration: BoxDecoration(
                                    color: AppColors.tertiaryBgColor,
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  child: Row(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: allLawyersController
                                                    .lawyerListForPagination[
                                                        index]
                                                    .image
                                                    ?.length !=
                                                null
                                            ? Image(
                                                image: NetworkImage(
                                                    "$mediaUrl${allLawyersController.lawyerListForPagination[index].image}"),
                                                height: 110.h,
                                              )
                                            : Image(
                                                image: const AssetImage(
                                                    'assets/images/lawyer-image.png'),
                                                height: 110.h,
                                              ),
                                      ),
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
                                                "${allLawyersController.lawyerListForPagination[index].name}",
                                                textAlign: TextAlign.start,
                                                style: AppTextStyles
                                                    .bodyTextStyle2,
                                              ),
                                              SizedBox(
                                                height: 4.h,
                                              ),
                                              SizedBox(
                                                height: 16.h,
                                                child: ListView(
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  children: List.generate(
                                                    allLawyersController
                                                        .lawyerListForPagination[
                                                            index]
                                                        .lawyerCategories!
                                                        .length,
                                                    (index1) {
                                                      return Text(
                                                        "${allLawyersController.lawyerListForPagination[index].lawyerCategories![index1].name} | ",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: AppTextStyles
                                                            .bodyTextStyle3,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                'LLB | Master of Dispute Resolution | Master of Legal Studies | Master of Laws',
                                                textAlign: TextAlign.start,
                                                style: AppTextStyles
                                                    .bodyTextStyle4,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 14.h, 0, 0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        RatingBar.builder(
                                                          initialRating:
                                                              allLawyersController
                                                                  .lawyerListForPagination[
                                                                      index]
                                                                  .rating!
                                                                  .toDouble(),
                                                          minRating: 1,
                                                          itemSize: 15.h,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating: true,
                                                          itemCount: 5,
                                                          ignoreGestures: true,
                                                          itemPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      0.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  const Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate:
                                                              (double value) {},
                                                        ),
                                                        SizedBox(width: 5.w),
                                                        Text(
                                                          // '4.5',
                                                          allLawyersController
                                                              .lawyerListForPagination[
                                                                  index]
                                                              .rating
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: AppTextStyles
                                                              .bodyTextStyle4,
                                                        ),
                                                      ],
                                                    ),
                                                    ButtonWidgetOne(
                                                      buttonText:
                                                          LanguageConstant
                                                              .profile.tr,
                                                      onTap: () {
                                                        generalController
                                                            .updateSelectedLawyerForView(
                                                                allLawyersController
                                                                        .lawyerListForPagination[
                                                                    index]);

                                                        Get.toNamed(PageRoutes
                                                            .lawyerProfileScreen);
                                                      },
                                                      buttonTextStyle:
                                                          AppTextStyles
                                                              .buttonTextStyle2,
                                                      borderRadius: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              })
                          : SizedBox(
                              height: 100.h,
                              child: Center(
                                child: Text(
                                  LanguageConstant.noDataFound.tr,
                                  style: AppTextStyles.bodyTextStyle2,
                                ),
                              ),
                            ),

                      // allLawyersController
                      //         .lawyerListForPagination.isNotEmpty
                      allLawyersController.lawyerListForPagination.length ==
                              allLawyersController
                                  .getAllLawyersModel.data!.data!.length
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
                                        allLawyersController
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
