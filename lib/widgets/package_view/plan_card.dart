import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/controller/plan_cubit.dart';
import 'package:otex_app/helper/app_colors.dart';
import 'package:otex_app/helper/app_extension.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/helper/widgets/custom_divider.dart';
import 'package:otex_app/models/plan.dart';
import 'package:otex_app/widgets/package_view/custom_arrow_painter.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.plan,
    this.isSelected = false,
    this.isLoading = false,
  });

  final bool isSelected;
  final bool isLoading;
  final Plan plan;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: AppStyles.planCardBoxDecoration,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardHeader(context),
              CustomDivider().withShimmer(isShow: isLoading),
              const Gap(4),
              _buildCardFeatures(),
            ],
          ),
        ).withShimmer(isShow: isLoading),
        if (plan.description.isNotEmpty && !isLoading) _buildCardArrow(),
      ],
    );
  }

  Widget _buildCardArrow() {
    return Positioned(
      top: -20,
      child: IntrinsicWidth(
        child: CustomPaint(
          painter: CustomArrowPainter(
            color: const Color(0XFFFFDBDB),
            notchPosition: 12.0,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              plan.description,
              style: TextStyle(color: AppColors.secondary),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardFeatures() {
    if (isLoading) {
      // 🔸 shimmer placeholder for features
      return Column(
        children: List.generate(
          3,
          (i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Container(width: 16, height: 16, color: Colors.white).withShimmer(isShow: true),
                const Gap(8),
                Expanded(
                  child: Container(height: 12, color: Colors.white).withShimmer(isShow: true),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: plan.features
                .map(
                  (feature) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        SvgPicture.string(feature.icon, width: 16),
                        const Gap(6),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                feature.name,
                                style: AppStyles.font14BlackMedium,
                              ),
                              if (feature.description.isNotEmpty)
                                Text(
                                  feature.description,
                                  style: AppStyles.font14BlackMedium.copyWith(color: AppColors.secondary),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        if (plan.viewsNumber > 0) _buildPlanViewsNumber()
      ],
    );
  }

  Widget _buildPlanViewsNumber() {
    return Column(
      children: [
        Container(
          height: 42,
          width: 72,
          decoration: AppStyles.planViewsNumberBoxDecoration,
          child: Center(
            child: Text(
              "${plan.viewsNumber}x",
              style: AppStyles.font14BlackRegular.copyWith(color: const Color(0xFF3A813F), fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Center(
          child: Text(
            AppStrings.doubleViews,
            style: AppStyles.font12BlackRegular.copyWith(
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardHeader(BuildContext context) {
    if (isLoading) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(width: 100, height: 16, color: Colors.white).withShimmer(isShow: true),
          Container(width: 60, height: 14, color: Colors.white).withShimmer(isShow: true),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                checkboxTheme: CheckboxThemeData(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  checkColor: WidgetStateProperty.all(AppColors.white),
                  fillColor: isSelected ? WidgetStateProperty.all(AppColors.primary) : WidgetStateProperty.all(AppColors.white),
                ),
              ),
              child: Checkbox(
                value: isSelected,
                onChanged: (v) {
                  context.read<PlanCubit>().selectPlan(plan.id!, v ?? false);
                },
              ),
            ),
            Text(
              plan.name,
              style: AppStyles.font16BlackMedium.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Text(
          "${plan.price.toStringAsFixed(2)} ج.م",
          style: AppStyles.font16BlackMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.secondary,
            decoration: TextDecoration.underline,
            decorationThickness: 32,
            decorationStyle: TextDecorationStyle.solid,
            decorationColor: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}
