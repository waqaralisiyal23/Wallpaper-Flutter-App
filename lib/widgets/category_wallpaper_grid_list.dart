import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaperapp/constants/strings.dart';
import 'package:wallpaperapp/models/wallpaper_model.dart';
import 'package:wallpaperapp/screens/full_image_screen.dart';
import 'package:wallpaperapp/utils/utils.dart';

// ignore: must_be_immutable
class CategoryWallpaperGridList extends StatelessWidget {
  final List<WallpaperModel> wallpaperList;
  RxBool _hasError = false.obs;

  CategoryWallpaperGridList({Key? key, required this.wallpaperList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 6.0,
          crossAxisSpacing: 6.0,
          children: wallpaperList.map((WallpaperModel wallpaperModel) {
            return GridTile(
              child: GestureDetector(
                onTap: () {
                  if (!(_hasError.value)) {
                    Utils.loadAd(AD_2_UNIT_ID);
                    Get.to(
                        FullImageScreen(imageUrl: wallpaperModel.src.portrait));
                  }
                },
                child: Hero(
                  tag: wallpaperModel.src.portrait,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: wallpaperModel.src.portrait,
                        placeholder: (context, url) => Container(
                          color: Color(0xfff5f8fd),
                        ),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) {
                          _hasError(true);
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }
}
