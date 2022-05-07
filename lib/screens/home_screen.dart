import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaperapp/constants/strings.dart';
import 'package:wallpaperapp/controllers/wallpaper_controller.dart';
import 'package:wallpaperapp/models/wallpaper_model.dart';
import 'package:wallpaperapp/screens/category_screen.dart';
import 'package:wallpaperapp/screens/search_screen.dart';
import 'package:wallpaperapp/utils/utils.dart';
import 'package:wallpaperapp/widgets/search_field.dart';
import 'package:wallpaperapp/widgets/wallpaper_row.dart';
import 'package:wallpaperapp/widgets/wallpaper_row_shimmer_loading.dart';
import 'package:wallpaperapp/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    // Get.find<WallpaperController>().getTrendingWallpapers(30);
    // Get.find<WallpaperController>().getCategoryWallpapers(NATURE, 30);
    // Get.find<WallpaperController>().getCategoryWallpapers(WILD_LIFE, 30);
    // Get.find<WallpaperController>().getCategoryWallpapers(CODING, 30);
    // Get.find<WallpaperController>().getCategoryWallpapers(STREET_ART, 30);
    // Get.find<WallpaperController>().getCategoryWallpapers(CITY, 30);
    // Get.find<WallpaperController>().getCategoryWallpapers(MOTIVATION, 30);
    // Get.find<WallpaperController>().getCategoryWallpapers(CARS, 30);
    // Get.find<WallpaperController>().getCategoryWallpapers(BIKES, 30);

    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        if (Get.find<WallpaperController>().trendingWallpapersList.length == 0)
          Get.find<WallpaperController>().getTrendingWallpapers(30);
        if (Get.find<WallpaperController>().natureWallpapersList.length == 0)
          Get.find<WallpaperController>().getCategoryWallpapers(NATURE, 30);
        if (Get.find<WallpaperController>().wildLifeWallpapersList.length == 0)
          Get.find<WallpaperController>().getCategoryWallpapers(WILD_LIFE, 30);
        if (Get.find<WallpaperController>().codingWallpapersList.length == 0)
          Get.find<WallpaperController>().getCategoryWallpapers(CODING, 30);
        if (Get.find<WallpaperController>().streetArtWallpapersList.length == 0)
          Get.find<WallpaperController>().getCategoryWallpapers(STREET_ART, 30);
        if (Get.find<WallpaperController>().cityWallpapersList.length == 0)
          Get.find<WallpaperController>().getCategoryWallpapers(CITY, 30);
        if (Get.find<WallpaperController>().motivationWallpapersList.length ==
            0)
          Get.find<WallpaperController>().getCategoryWallpapers(MOTIVATION, 30);
        if (Get.find<WallpaperController>().carWallpapersList.length == 0)
          Get.find<WallpaperController>().getCategoryWallpapers(CARS, 30);
        if (Get.find<WallpaperController>().bikeWallpapersList.length == 0)
          Get.find<WallpaperController>().getCategoryWallpapers(BIKES, 30);
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _onSearchTap() {
    if (_searchController.text.trim() != '') {
      Utils.isConnected().then((isConnected) {
        if (isConnected) {
          FocusScope.of(context).unfocus();
          Utils.loadAd(AD_UNIT_ID);
          Get.to(SearchScreen(searchTerm: _searchController.text.trim()));
        } else
          showSnackbar(
            'Error',
            'Internet Disconnected',
            Icon(Icons.error, color: Colors.white),
          );
      });
    } else
      showSnackbar(
        'Error',
        'Search term cannot be empty',
        Icon(Icons.error, color: Colors.white),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Stunning Wallpapers'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: GestureDetector(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    SearchField(
                      controller: _searchController,
                      onSearchTap: _onSearchTap,
                      onSubmitted: (String searchTerm) {
                        _searchController.text = searchTerm;
                        _onSearchTap();
                      },
                    ),
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pexels',
                          style: TextStyle(fontSize: 20.0, color: Colors.blue),
                        ),
                        Text(
                          'Collection',
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.black54),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    _headingRow(
                      TRENDING,
                      Get.find<WallpaperController>().trendingWallpapersList,
                    ),
                    Obx(() {
                      if (Get.find<WallpaperController>()
                          .isTrendingLoading
                          .value) {
                        return WallpaperRowShimmerLoading();
                      }
                      return WallpaperRow(
                        wallpaperList: Get.find<WallpaperController>()
                            .trendingWallpapersList,
                      );
                    }),
                    SizedBox(height: 12.0),
                    _headingRow(
                      NATURE,
                      Get.find<WallpaperController>().natureWallpapersList,
                    ),
                    Obx(() {
                      if (Get.find<WallpaperController>()
                          .isNatureLoading
                          .value) {
                        return WallpaperRowShimmerLoading();
                      }
                      return WallpaperRow(
                        wallpaperList: Get.find<WallpaperController>()
                            .natureWallpapersList,
                      );
                    }),
                    SizedBox(height: 12.0),
                    _headingRow(
                      WILD_LIFE,
                      Get.find<WallpaperController>().wildLifeWallpapersList,
                    ),
                    Obx(() {
                      if (Get.find<WallpaperController>()
                          .isWildLifeLoading
                          .value) {
                        return WallpaperRowShimmerLoading();
                      }
                      return WallpaperRow(
                        wallpaperList: Get.find<WallpaperController>()
                            .wildLifeWallpapersList,
                      );
                    }),
                    SizedBox(height: 12.0),
                    _headingRow(
                      CODING,
                      Get.find<WallpaperController>().codingWallpapersList,
                    ),
                    Obx(() {
                      if (Get.find<WallpaperController>()
                          .isCodingLoading
                          .value) {
                        return WallpaperRowShimmerLoading();
                      }
                      return WallpaperRow(
                        wallpaperList: Get.find<WallpaperController>()
                            .codingWallpapersList,
                      );
                    }),
                    SizedBox(height: 12.0),
                    _headingRow(
                      STREET_ART,
                      Get.find<WallpaperController>().streetArtWallpapersList,
                    ),
                    Obx(() {
                      if (Get.find<WallpaperController>()
                          .isStreetArtLoading
                          .value) {
                        return WallpaperRowShimmerLoading();
                      }
                      return WallpaperRow(
                        wallpaperList: Get.find<WallpaperController>()
                            .streetArtWallpapersList,
                      );
                    }),
                    SizedBox(height: 12.0),
                    _headingRow(
                      CITY,
                      Get.find<WallpaperController>().cityWallpapersList,
                    ),
                    Obx(() {
                      if (Get.find<WallpaperController>().isCityLoading.value) {
                        return WallpaperRowShimmerLoading();
                      }
                      return WallpaperRow(
                        wallpaperList:
                            Get.find<WallpaperController>().cityWallpapersList,
                      );
                    }),
                    SizedBox(height: 12.0),
                    _headingRow(
                      MOTIVATION,
                      Get.find<WallpaperController>().motivationWallpapersList,
                    ),
                    Obx(() {
                      if (Get.find<WallpaperController>()
                          .isMotivationLoading
                          .value) {
                        return WallpaperRowShimmerLoading();
                      }
                      return WallpaperRow(
                        wallpaperList: Get.find<WallpaperController>()
                            .motivationWallpapersList,
                      );
                    }),
                    SizedBox(height: 12.0),
                    _headingRow(
                      CARS,
                      Get.find<WallpaperController>().carWallpapersList,
                    ),
                    Obx(() {
                      if (Get.find<WallpaperController>().isCarLoading.value) {
                        return WallpaperRowShimmerLoading();
                      }
                      return WallpaperRow(
                        wallpaperList:
                            Get.find<WallpaperController>().carWallpapersList,
                      );
                    }),
                    SizedBox(height: 12.0),
                    _headingRow(
                      BIKES,
                      Get.find<WallpaperController>().bikeWallpapersList,
                    ),
                    Obx(() {
                      if (Get.find<WallpaperController>().isBikeLoading.value) {
                        return WallpaperRowShimmerLoading();
                      }
                      return WallpaperRow(
                        wallpaperList:
                            Get.find<WallpaperController>().bikeWallpapersList,
                      );
                    }),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headingRow(String category, List<WallpaperModel> wallpapers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        titleHeading(category),
        TextButton(
          onPressed: () {
            if (wallpapers.length > 0) {
              Utils.isConnected().then((isConnected) {
                if (isConnected) {
                  Get.to(CategoryScreen(
                    categoryTitle: category,
                    wallpapers: wallpapers,
                  ));
                } else {
                  showSnackbar(
                    'Error',
                    'Internet Disconnected',
                    Icon(Icons.error, color: Colors.white),
                  );
                }
              });
            }
          },
          child: Text(
            'show more',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
