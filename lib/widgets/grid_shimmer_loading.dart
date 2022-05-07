import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridShimmerLoading extends StatelessWidget {
  const GridShimmerLoading({Key? key}) : super(key: key);

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
          children: List.generate(10, (index) {
            return GridTile(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[350]!,
                highlightColor: Colors.grey[200]!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[350],
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            );
          }).toList()),
    );
  }
}
