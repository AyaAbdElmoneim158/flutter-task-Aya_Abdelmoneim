import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/helper/app_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  final String imageUrl;
  final String message;
  final double imageSize;
  final TextStyle? textStyle;

  const EmptyStateWidget({
    super.key,
    required this.imageUrl,
    required this.message,
    this.imageSize = 100,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl, width: imageSize),
          const Gap(8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: textStyle ?? AppStyles.font10BlackRegular,
          ),
        ],
      ),
    );
  }
}
