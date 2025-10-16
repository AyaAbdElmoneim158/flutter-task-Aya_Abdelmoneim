import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/helper/app_extension.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0x1A090F1F), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 🖼️ Image placeholder
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              child: Container(
                width: double.infinity,
                color: Colors.grey[300],
              ).withShimmer(),
            ),
          ),

          // 📦 Details placeholders
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Gap(4),

                // Name + Offer Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _roundedBox(height: 14, width: 100),
                    ),
                    _circleBox(size: 20),
                  ],
                ),

                const Gap(8),

                // Price + Favorite Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _roundedBox(height: 14, width: 70),
                    _circleBox(size: 24),
                  ],
                ),

                const Gap(8),

                // Sold count
                Row(
                  children: [
                    _circleBox(size: 12),
                    const Gap(8),
                    _roundedBox(height: 10, width: 60),
                  ],
                ),

                const Gap(16),

                // Bottom icons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _circleBox(size: 16),
                    Row(
                      children: [
                        _circleBox(size: 16),
                        const Gap(12),
                        _circleBox(size: 16),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🧩 Helpers
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

  Widget _circleBox({required double size}) {
    return ClipOval(
      child: Container(
        height: size,
        width: size,
        color: Colors.grey[300],
      ).withShimmer(),
    );
  }
}
