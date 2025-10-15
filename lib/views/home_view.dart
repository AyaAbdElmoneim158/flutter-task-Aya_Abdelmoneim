import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/controller/home_cubit.dart';
import 'package:otex_app/controller/home_state.dart';
import 'package:otex_app/helper/app_assets.dart';
import 'package:otex_app/helper/app_colors.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/models/category.dart';
import 'package:otex_app/models/product.dart';
import 'package:otex_app/views/filter_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..loadInitialData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 45,
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('An error occurred while fetching plans.', style: AppStyles.font16BlackMedium),
                    const Gap(16),
                    ElevatedButton(
                      onPressed: () => context.read<HomeCubit>().loadInitialData(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const DiscoveryRow(),
                      const Gap(24),
                      _buildCategoryList(context, state),
                      const Gap(24),
                      AlertContainer(),
                      const Gap(24),
                      _buildProductGrid(context, state),
                    ],
                  ),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context, HomeLoaded state) {
    return SizedBox(
      height: 39,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            context.read<HomeCubit>().selectCategory(index);
          },
          child: CategoryCard(
            state.categories[index],
            isSelected: state.selectedCategoryIndex == index,
          ),
        ),
        separatorBuilder: (context, index) => const Gap(8),
        itemCount: state.categories.length,
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, HomeLoaded state) {
    final products = context.read<HomeCubit>().filteredProducts;

    if (products.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
            Gap(16),
            Text(
              'No products available',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: .7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class AlertContainer extends StatelessWidget {
  const AlertContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF95B1C).withOpacity(0.05),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.check, color: Color(0xFF3A813F)),
              Text('شحن مجانى', style: AppStyles.font12BlackRegular.copyWith(color: Color(0xFF3A813F))),
            ],
          ),
          Text('لأى عرض تطلبه دلوقتى !', style: AppStyles.font12BlackRegular),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product? product;

  const ProductCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    // If product is null, show a placeholder
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
                product?.image ?? AppAssets.jaket, // Use product image if available
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
                        // const Gap(8),
                        // SvgPicture.asset(
                        //   AppAssets.chat,
                        //   width: 16,
                        // ),
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

class CategoryWithImageCard extends StatelessWidget {
  const CategoryWithImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 73,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.10),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Image.asset(AppAssets.watch),
        ),
        const Gap(8),
        Text(
          'ساعات',
          style: AppStyles.font12BlackRegular,
        ),
      ],
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;

  const CategoryCard(this.category, {super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.secondary.withOpacity(0.05) : const Color(0x4DFFFFFF),
        border: Border.all(
          color: const Color(0x1A000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category.name,
        style: AppStyles.font16GrayBold.copyWith(
          color: isSelected ? AppColors.secondary : AppColors.gray,
        ),
      ),
    );
  }
}

class DiscoveryRow extends StatelessWidget {
  const DiscoveryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "أستكشف العروض",
          style: AppStyles.font16BlackMedium,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FilterView(),
              ),
            );
          },
          child: Row(
            children: [
              Text(
                "الكل",
                style: AppStyles.font16GrayBold,
              ),
              SvgPicture.asset(
                AppAssets.arrowBack,
                width: 24,
              ),
            ],
          ),
        )
      ],
    );
  }
}
