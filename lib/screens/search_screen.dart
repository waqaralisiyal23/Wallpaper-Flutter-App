import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaperapp/controllers/wallpaper_controller.dart';
import 'package:wallpaperapp/utils/utils.dart';
import 'package:wallpaperapp/widgets/category_wallpaper_grid_list.dart';
import 'package:wallpaperapp/widgets/grid_shimmer_loading.dart';
import 'package:wallpaperapp/widgets/search_field.dart';
import 'package:wallpaperapp/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  final String searchTerm;
  const SearchScreen({Key? key, required this.searchTerm}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchTerm;
    Get.find<WallpaperController>()
        .getSearchedWallpapers(widget.searchTerm, 50);
  }

  void _onSearchTap() {
    if (_searchController.text.trim() != '') {
      Utils.isConnected().then((isConnected) {
        if (isConnected) {
          FocusScope.of(context).unfocus();
          Get.find<WallpaperController>()
              .getSearchedWallpapers(_searchController.text.trim(), 50);
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
      appBar: appBar('Search Wallpapers', fontSize: 24.0),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SearchField(
                    controller: _searchController,
                    onSearchTap: _onSearchTap,
                    onSubmitted: (String searchTerm) {
                      _searchController.text = searchTerm;
                      _onSearchTap();
                    },
                  ),
                ),
                SizedBox(height: 12.0),
                Obx(() {
                  if (Get.find<WallpaperController>().isSearchLoading.value) {
                    return GridShimmerLoading();
                  } else if (!(Get.find<WallpaperController>()
                          .isSearchLoading
                          .value) &&
                      Get.find<WallpaperController>()
                              .searchedWallpapersList
                              .length ==
                          0) {
                    return _noResultsFound();
                  }
                  return CategoryWallpaperGridList(
                    wallpaperList:
                        Get.find<WallpaperController>().searchedWallpapersList,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _noResultsFound() {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              color: Colors.black,
              size: 100.0,
            ),
            Text(
              'No Results Found',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
