import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:wallpaperapp/constants/strings.dart';
import 'package:wallpaperapp/models/wallpaper_model.dart';
import 'package:wallpaperapp/services/api_service.dart';
import 'package:wallpaperapp/utils/utils.dart';
import 'package:wallpaperapp/widgets/widgets.dart';

class WallpaperController extends GetxController {
  RxBool isTrendingLoading = true.obs;
  List<WallpaperModel> trendingWallpapersList = RxList<WallpaperModel>([]);

  RxBool isNatureLoading = true.obs;
  List<WallpaperModel> natureWallpapersList = RxList<WallpaperModel>([]);

  RxBool isWildLifeLoading = true.obs;
  List<WallpaperModel> wildLifeWallpapersList = RxList<WallpaperModel>([]);

  RxBool isCodingLoading = true.obs;
  List<WallpaperModel> codingWallpapersList = RxList<WallpaperModel>([]);

  RxBool isStreetArtLoading = true.obs;
  List<WallpaperModel> streetArtWallpapersList = RxList<WallpaperModel>([]);

  RxBool isCityLoading = true.obs;
  List<WallpaperModel> cityWallpapersList = RxList<WallpaperModel>([]);

  RxBool isMotivationLoading = true.obs;
  List<WallpaperModel> motivationWallpapersList = RxList<WallpaperModel>([]);

  RxBool isCarLoading = true.obs;
  List<WallpaperModel> carWallpapersList = RxList<WallpaperModel>([]);

  RxBool isBikeLoading = true.obs;
  List<WallpaperModel> bikeWallpapersList = RxList<WallpaperModel>([]);

  RxBool isSearchLoading = true.obs;
  List<WallpaperModel> searchedWallpapersList = RxList<WallpaperModel>([]);

  Future<void> getTrendingWallpapers(int perPage) async {
    try {
      isTrendingLoading(true);
      List<WallpaperModel> wallpapers =
          await ApiService.fetchTrendingWallpapers(perPage);
      if (wallpapers.length > 0) {
        trendingWallpapersList.addAll(wallpapers);
        isTrendingLoading(false);
      }
    } catch (e) {}
  }

  Future<void> getCategoryWallpapers(String category, int perPage) async {
    try {
      switch (category) {
        case NATURE:
          isNatureLoading(true);
          List<WallpaperModel> wallpapers =
              await ApiService.fetchCategoriesWallpapers(category, perPage);
          if (wallpapers.length > 0) {
            natureWallpapersList.addAll(wallpapers);
            isNatureLoading(false);
          }
          break;
        case WILD_LIFE:
          isWildLifeLoading(true);
          List<WallpaperModel> wallpapers =
              await ApiService.fetchCategoriesWallpapers(category, perPage);
          if (wallpapers.length > 0) {
            wildLifeWallpapersList.addAll(wallpapers);
            isWildLifeLoading(false);
          }
          break;
        case CODING:
          isCodingLoading(true);
          List<WallpaperModel> wallpapers =
              await ApiService.fetchCategoriesWallpapers(category, perPage);
          if (wallpapers.length > 0) {
            codingWallpapersList.addAll(wallpapers);
            isCodingLoading(false);
          }
          break;
        case STREET_ART:
          isStreetArtLoading(true);
          List<WallpaperModel> wallpapers =
              await ApiService.fetchCategoriesWallpapers(category, perPage);
          if (wallpapers.length > 0) {
            streetArtWallpapersList.addAll(wallpapers);
            isStreetArtLoading(false);
          }
          break;
        case CITY:
          isCityLoading(true);
          List<WallpaperModel> wallpapers =
              await ApiService.fetchCategoriesWallpapers(category, perPage);
          if (wallpapers.length > 0) {
            cityWallpapersList.addAll(wallpapers);
            isCityLoading(false);
          }
          break;
        case MOTIVATION:
          isMotivationLoading(true);
          List<WallpaperModel> wallpapers =
              await ApiService.fetchCategoriesWallpapers(category, perPage);
          if (wallpapers.length > 0) {
            motivationWallpapersList.addAll(wallpapers);
            isMotivationLoading(false);
          }
          break;
        case CARS:
          isCarLoading(true);
          List<WallpaperModel> wallpapers =
              await ApiService.fetchCategoriesWallpapers(category, perPage);
          if (wallpapers.length > 0) {
            carWallpapersList.addAll(wallpapers);
            isCarLoading(false);
          }
          break;
        case BIKES:
          isBikeLoading(true);
          List<WallpaperModel> wallpapers =
              await ApiService.fetchCategoriesWallpapers(category, perPage);
          if (wallpapers.length > 0) {
            bikeWallpapersList.addAll(wallpapers);
            isBikeLoading(false);
          }
          break;
      }
    } catch (e) {}
  }

  Future<void> getSearchedWallpapers(String searchTerm, int perPage) async {
    try {
      if (searchedWallpapersList.length > 0) searchedWallpapersList.clear();
      isSearchLoading(true);
      List<WallpaperModel> wallpapers =
          await ApiService.fetchCategoriesWallpapers(searchTerm, perPage);
      if (wallpapers.length > 0) {
        searchedWallpapersList.addAll(wallpapers);
      }
      isSearchLoading(false);
    } catch (e) {}
  }

  Future<void> setWallpaper(
      String imageUrl, int location, String successScreen) async {
    File imageFile = await DefaultCacheManager().getSingleFile(imageUrl);
    await WallpaperManagerFlutter().setwallpaperfromFile(imageFile, location);
    Get.back();
    showSnackbar(
      'Success',
      'Wallpaper set to $successScreen',
      Icon(Icons.check_circle, color: Colors.white),
      backgroundColor: Colors.greenAccent.withOpacity(0.8),
    );
  }

  void downloadImage(String imageUrl) {
    Utils.isConnected().then((isConnected) async {
      if (isConnected) {
        try {
          var imageId = await ImageDownloader.downloadImage(imageUrl);
          if (imageId == null) {
            showSnackbar(
              'Error',
              'Failed to download image',
              Icon(Icons.error, color: Colors.white),
            );
            return;
          }
          showSnackbar(
            'Success',
            'Image Successfully Downloaded',
            Icon(Icons.check_circle, color: Colors.white),
            backgroundColor: Colors.greenAccent.withOpacity(0.8),
          );
        } on PlatformException {
          showSnackbar(
            'Error',
            'Failed to download image',
            Icon(Icons.error, color: Colors.white),
          );
        }
      } else {
        showSnackbar(
          'Error',
          'Internet Disconnected',
          Icon(Icons.error, color: Colors.white),
        );
      }
    });
  }

  Future<void> shareImage(String imageUrl) async {
    File imageFile = await DefaultCacheManager().getSingleFile(imageUrl);
    Share.shareFiles([imageFile.path]);
  }
}
