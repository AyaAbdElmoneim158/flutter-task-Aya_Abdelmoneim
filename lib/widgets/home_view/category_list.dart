import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/controller/home_cubit.dart';
import 'package:otex_app/controller/home_state.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/widgets/empty_state_widget.dart';
import 'package:otex_app/helper/widgets/error_state_widget.dart';
import 'package:otex_app/widgets/home_view/category_card.dart';
import 'package:otex_app/widgets/home_view/category_card_shimmer.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is CategoriesHomeLoading || current is CategoriesHomeLoaded || current is CategoriesHomeError || current is CategoriesHomeEmpty,
      builder: (context, state) {
        return (state is CategoriesHomeLoading)
            ? _buildCategoriesHomeLoadingState(cubit)
            : (state is CategoriesHomeError)
                ? _buildCategoriesHomeErrorState(context, cubit)
                : (state is CategoriesHomeEmpty)
                    ? _buildCategoriesHomeEmptyState()
                    : (cubit.categories.isNotEmpty)
                        ? _buildCategoriesHomeLoadedState(cubit)
                        : SizedBox.shrink();
      },
    );
  }

  Widget _buildCategoriesHomeLoadingState(HomeCubit cubit) {
    return SizedBox(
      height: 39,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => CategoryCardShimmer(),
        separatorBuilder: (context, index) => const Gap(8),
        itemCount: 6,
      ),
    );
  }

  Widget _buildCategoriesHomeLoadedState(HomeCubit cubit) {
    return SizedBox(
      height: 39,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => cubit.selectCategory(index),
          child: CategoryCard(
            cubit.categories[index],
            isSelected: cubit.selectedCategoryIndex == index,
          ),
        ),
        separatorBuilder: (context, index) => const Gap(8),
        itemCount: cubit.categories.length,
      ),
    );
  }

  Widget _buildCategoriesHomeEmptyState() {
    return SizedBox(
      height: 100,
      child: EmptyStateWidget(
        imageUrl: "https://cdn-icons-png.flaticon.com/512/11244/11244162.png",
        imageSize: 32,
        message: AppStrings.noCategoriesAvailable,
      ),
    );
  }

  Widget _buildCategoriesHomeErrorState(BuildContext context, HomeCubit cubit) {
    return SizedBox(
      height: 250,
      child: errorStateWidget(
        context: context,
        message: AppStrings.failedToLoadCategories,
        onTap: () => cubit.loadCategories(),
      ),
    );
  }
}
