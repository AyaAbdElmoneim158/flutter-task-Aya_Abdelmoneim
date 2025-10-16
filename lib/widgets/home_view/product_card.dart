import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/helper/app_assets.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product? product;

  const ProductCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0x1A090F1F), width: 1),
        ),
        child: const Center(
          child: Text('Loading...'),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: const Color(0x1A090F1F), width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Material(
              color: Colors.black.withOpacity(0.10),
              child: Image.asset(
                product?.image ?? "https://tinasbotanicals.com/wp-content/uploads/2025/01/No-Product-Image-Available.png",
                width: double.infinity,
                // height: 120,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Gap(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product?.name ?? 'جاكيت من الصوف مناسب',
                        style: AppStyles.font14BlackMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    SvgPicture.asset(AppAssets.bxsOffer, width: 20),
                  ],
                ),
                const Gap(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        _formatPrice(product!.price, product!.oldPrice),
                        style: AppStyles.font14BlackMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SvgPicture.asset(AppAssets.favorite, width: 24),
                  ],
                ),
                const Gap(4),
                Row(
                  children: [
                    SvgPicture.asset(AppAssets.fire, width: 12),
                    Text(
                      'تم بيع 3.3k+',
                      style: AppStyles.font10BlackRegular,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      AppAssets.fare,
                      width: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.cart,
                          width: 16,
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price, double? oldPrice) {
    final formattedPrice = '${price.toStringAsFixed(0)} جم';
    if (oldPrice != null && oldPrice > price) {
      return '$formattedPrice / ${oldPrice.toStringAsFixed(0)}';
    }
    return formattedPrice;
  }
}
