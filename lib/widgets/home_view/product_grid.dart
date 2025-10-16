import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otex_app/controller/home_cubit.dart';
import 'package:otex_app/controller/home_state.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/widgets/empty_state_widget.dart';
import 'package:otex_app/helper/widgets/error_state_widget.dart';
import 'package:otex_app/widgets/home_view/product_card.dart';
import 'package:otex_app/widgets/home_view/product_card_shimmer.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is ProductsHomeLoading ||
          current is ProductsHomeLoaded ||
          current is ProductsHomeError ||
          current is ProductsHomeEmpty ||
          current is FilterProductsHomeLoading ||
          current is FilterProductsHomeLoaded ||
          current is FilterProductsHomeError ||
          current is FilterProductsHomeEmpty,
      builder: (context, state) {
        final products = cubit.filteredProducts;

        if (state is ProductsHomeLoading || state is FilterProductsHomeLoading) {
          return _buildProductsHomeLoadingState();
        } else if (state is ProductsHomeError) {
          return _buildProductsHomeErrorState(
            context,
            cubit,
            AppStrings.failedToLoadProducts,
            state.message,
          );
        } else if (state is FilterProductsHomeError) {
          return _buildProductsHomeErrorState(
            context,
            cubit,
            AppStrings.failedToFilterProducts,
            state.message,
          );
        } else if (state is ProductsHomeEmpty) {
          return _buildProductsHomeEmptyState();
        } else if (state is FilterProductsHomeEmpty) {
          return _buildFilteredProductsHomeEmptyState(cubit);
        } else if (products.isNotEmpty) {
          return _buildProductsHomeLoadedState(products);
        } else {
          return _buildProductsHomeEmptyState();
        }
      },
    );
  }

  Widget _buildProductsHomeLoadingState() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: .7,
      ),
      itemCount: 6,
      itemBuilder: (context, index) => const ProductCardShimmer(),
    );
  }

  Widget _buildProductsHomeLoadedState(List products) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: .7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) => ProductCard(product: products[index]),
    );
  }

  Widget _buildProductsHomeErrorState(BuildContext context, HomeCubit cubit, String title, String message) {
    return SizedBox(
      height: 300,
      child: errorStateWidget(
        context: context,
        message: title,
        onTap: () => cubit.refreshProducts(),
      ),
    );
  }

  Widget _buildProductsHomeEmptyState() {
    return SizedBox(
      height: 250,
      child: EmptyStateWidget(
        imageUrl: "https://cdn-icons-png.flaticon.com/512/10608/10608894.png",
        imageSize: 80,
        message: AppStrings.noProductsAvailable,
      ),
    );
  }

  Widget _buildFilteredProductsHomeEmptyState(HomeCubit cubit) {
    return SizedBox(
      height: 250,
      child: EmptyStateWidget(
        imageUrl: "https://cdn-icons-png.flaticon.com/512/10608/10608894.png",
        imageSize: 80,
        message: AppStrings.noFilteredProducts,
      ),
    );
  }
}
