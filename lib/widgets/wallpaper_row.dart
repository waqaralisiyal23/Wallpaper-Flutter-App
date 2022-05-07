import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaperapp/constants/strings.dart';
import 'package:wallpaperapp/models/wallpaper_model.dart';
import 'package:wallpaperapp/screens/full_image_screen.dart';
import 'package:wallpaperapp/utils/utils.dart';

// ignore: must_be_immutable
class WallpaperRow extends StatelessWidget {
  final List<WallpaperModel> wallpaperList;
  RxBool _hasError = false.obs;

  WallpaperRow({
    Key? key,
    required this.wallpaperList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: wallpaperList.length == 0 ? 0 : wallpaperList.length - 20,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _wallpaperContainer(
            wallpaperList[index].src.portrait,
          );
        },
      ),
    );
  }

  Widget _wallpaperContainer(String imageUrl) {
    return GestureDetector(
      onTap: () {
        if (!(_hasError.value)) {
          Utils.loadAd(AD_2_UNIT_ID);
          Get.to(FullImageScreen(imageUrl: imageUrl));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: 130.0,
            height: 180.0,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              _hasError(true);
              return Container(
                width: 130.0,
                height: 180.0,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(12.0),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
