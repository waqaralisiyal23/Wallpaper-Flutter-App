import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearchTap;
  final onSubmitted;

  const SearchField({
    Key? key,
    required this.controller,
    required this.onSearchTap,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: Color(0xfff5f8fd),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                hintText: 'Search Wallpaper',
                border: InputBorder.none,
              ),
            ),
          ),
          InkWell(
            onTap: onSearchTap,
            child: Container(child: Icon(Icons.search)),
          ),
        ],
      ),
    );
  }
}
