import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaperapp/constants/strings.dart';
import 'package:wallpaperapp/models/wallpaper_model.dart';

class ApiService {
  static Future<List<WallpaperModel>> fetchTrendingWallpapers(
      int perPage) async {
    List<WallpaperModel> wallpaperList = [];

    final response = await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=$perPage&page=1'),
      headers: {"Authorization": API_KEY},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData['photos'].forEach(
          (element) => wallpaperList.add(WallpaperModel.fromMap(element)));
      return wallpaperList;
    }
    return [];
  }

  static Future<List<WallpaperModel>> fetchCategoriesWallpapers(
    String category,
    int perPage,
  ) async {
    List<WallpaperModel> wallpaperList = [];

    final response = await http.get(
      Uri.parse(
          'https://api.pexels.com/v1/search?query=$category&per_page=$perPage&page=1'),
      headers: {"Authorization": API_KEY},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      jsonData['photos'].forEach(
          (element) => wallpaperList.add(WallpaperModel.fromMap(element)));
      return wallpaperList;
    }
    return [];
  }
}
