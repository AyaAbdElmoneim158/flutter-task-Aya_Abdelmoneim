import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/helper/app_extension.dart';

class PlanCardShimmer extends StatelessWidget {
  const PlanCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header (Plan name + Price)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _roundedBox(height: 16, width: 120),
              _roundedBox(height: 16, width: 60),
            ],
          ),
          const Gap(12),

          // Divider
          _roundedBox(height: 1, width: double.infinity),

          const Gap(12),

          // Features list (simulate 3 lines)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    _circleBox(size: 16),
                    const Gap(8),
                    Expanded(child: _roundedBox(height: 14, width: double.infinity)),
                  ],
                ),
              ),
            ),
          ),

          const Gap(8),

          // Views indicator placeholder
          Align(
            alignment: Alignment.centerRight,
            child: _roundedBox(height: 20, width: 70),
          ),
        ],
      ),
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
