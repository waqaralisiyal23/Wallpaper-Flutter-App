import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:wallpaperapp/controllers/wallpaper_controller.dart';

// ignore: must_be_immutable
class FullImageScreen extends StatelessWidget {
  final String imageUrl;
  FullImageScreen({Key? key, required this.imageUrl}) : super(key: key);
  var _showFunctionalRow = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: Stack(
        children: [
          Hero(
            tag: imageUrl,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
                    _showFunctionalRow(false);
                  });
                  return Container(
                    color: Colors.grey[350],
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 24.0,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          Obx(() => _showFunctionalRow.value
              ? Positioned(bottom: 12.0, child: _buildFunctionalRow(context))
              : Text('')),
        ],
      ),
    );
  }

  Widget _buildFunctionalRow(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleButton(
            Icons.download_sharp,
            () => Get.find<WallpaperController>().downloadImage(imageUrl),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.indigoAccent]),
            ),
            child: TextButton(
              onPressed: () => _showApplyWallpaperBottomSheet(context),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 30, top: 10, right: 30, bottom: 10),
                child: Text(
                  'Apply Wallpaper',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          _buildCircleButton(
            Icons.share,
            () => Get.find<WallpaperController>().shareImage(imageUrl),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white54,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }

  void _showApplyWallpaperBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: new BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[900]?.withOpacity(0.80)
                        : Colors.white.withOpacity(0.80),
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _getBottomSheetBarWidget(
                        context,
                        'Set Lock Screen',
                        () => Get.find<WallpaperController>().setWallpaper(
                          imageUrl,
                          WallpaperManagerFlutter.LOCK_SCREEN,
                          'Lock Screen',
                        ),
                      ),
                      Divider(),
                      _getBottomSheetBarWidget(
                        context,
                        'Set Home Screen',
                        () => Get.find<WallpaperController>().setWallpaper(
                          imageUrl,
                          WallpaperManagerFlutter.HOME_SCREEN,
                          'Home Screen',
                        ),
                      ),
                      Divider(),
                      _getBottomSheetBarWidget(
                        context,
                        'Set Both',
                        () => Get.find<WallpaperController>().setWallpaper(
                          imageUrl,
                          WallpaperManagerFlutter.BOTH_SCREENS,
                          'Both Screens',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: new BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.grey[900]?.withOpacity(0.99)
                          : Colors.white.withOpacity(0.90),
                      borderRadius: new BorderRadius.circular(10.0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _getBottomSheetBarWidget(
                          context, 'Cancel', () => Get.back()),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  Widget _getBottomSheetBarWidget(
      BuildContext context, String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).brightness != Brightness.dark
                ? Colors.black.withOpacity(0.90)
                : Colors.white.withOpacity(0.90),
          ),
        ),
      ),
    );
  }
}
