import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyer_consultant/src/config/app_colors.dart';
import 'package:lawyer_consultant/src/controllers/get_carousel_banner_controller.dart';

import '../api_services/urls.dart';
import '../controllers/themes_controller.dart';

class HomeBannerSliderWidget extends StatefulWidget {
  HomeBannerSliderWidget({Key? key}) : super(key: key);

  @override
  State<HomeBannerSliderWidget> createState() => _HomeBannerSliderWidgetState();
}

class _HomeBannerSliderWidgetState extends State<HomeBannerSliderWidget> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2 / 0.718,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Positioned(
          bottom: 5,
          right: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageSliders.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                    width: _current == entry.key ? 30.0 : 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: _current == entry.key
                          ? BorderRadius.circular(4)
                          : null,
                      shape: _current == entry.key
                          ? BoxShape.rectangle
                          : BoxShape.circle,
                      color: _current == entry.key
                          ? AppColors.primaryColor
                          : AppColors.white,
                    )),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

final List<Widget> imageSliders = List.generate(
    Get.find<GetAllCarouselBannerController>()
        .getAllCarouselBannerModel
        .data!
        .length, (index) {
  return SliderImageStyle(
    staticImages:
        Get.find<GetThemesController>().getThemesModel.data![index].themeCode ==
                "default"
            ? 'assets/images/home-banner.png'
            : Get.find<GetThemesController>()
                        .getThemesModel
                        .data![index]
                        .themeCode ==
                    "theme_1"
                ? 'assets/images/home-banner-1.png'
                : Get.find<GetThemesController>()
                            .getThemesModel
                            .data![index]
                            .themeCode ==
                        "theme_2"
                    ? 'assets/images/home-banner-2.png'
                    : 'assets/images/home-banner.png',
    dynamicImages: Get.find<GetAllCarouselBannerController>()
        .getAllCarouselBannerModel
        .data![index]
        .image,
  );
});

class SliderImageStyle extends StatelessWidget {
  final String? staticImages;
  final String? dynamicImages;

  const SliderImageStyle({
    Key? key,
    this.staticImages,
    this.dynamicImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          Get.find<GetAllCarouselBannerController>()
                  .getAllCarouselBannerModel
                  .data!
                  .isNotEmpty
              ? Image.network("$mediaUrl$dynamicImages", fit: BoxFit.cover)
              : Image.asset(staticImages!, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
