import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WallpaperRowShimmerLoading extends StatelessWidget {
  const WallpaperRowShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      child: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _placeholderContainer();
        },
      ),
    );
  }

  Widget _placeholderContainer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        width: 130.0,
        height: 180.0,
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
