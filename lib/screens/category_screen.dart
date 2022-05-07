import 'package:flutter/material.dart';
import 'package:wallpaperapp/models/wallpaper_model.dart';
import 'package:wallpaperapp/widgets/category_wallpaper_grid_list.dart';
import 'package:wallpaperapp/widgets/widgets.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryTitle;
  final List<WallpaperModel> wallpapers;
  const CategoryScreen({
    Key? key,
    required this.categoryTitle,
    required this.wallpapers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(categoryTitle),
      body: SingleChildScrollView(
        child: CategoryWallpaperGridList(wallpaperList: wallpapers),
      ),
    );
  }
}
