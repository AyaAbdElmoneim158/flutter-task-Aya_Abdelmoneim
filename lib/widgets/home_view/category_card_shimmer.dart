import 'package:flutter/material.dart';
import 'package:otex_app/helper/app_extension.dart';

class CategoryCardShimmer extends StatelessWidget {
  const CategoryCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: _roundedBox(height: 24, width: 80),
    );
  }

  Widget _roundedBox({required double height, required double width}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        height: height,
        width: width,
        color: Colors.grey[300],
      ).withShimmer(),
    );
  }
}
