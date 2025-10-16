import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/controller/plan_cubit.dart';
import 'package:otex_app/controller/plan_state.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/helper/widgets/custom_btn.dart';
import 'package:otex_app/widgets/package_view/app_bar.dart';
import 'package:otex_app/widgets/package_view/plan_card.dart';
import 'package:otex_app/widgets/package_view/plan_card_shimmer.dart';
import 'package:otex_app/widgets/package_view/special_plan.dart';

class PackageView extends StatelessWidget {
  const PackageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanCubit()..getPlans(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PackageViewAppBar(),
        body: BlocBuilder<PlanCubit, PlanState>(
          builder: (context, state) {
            return (state is PlanLoading)
                ? _buildPlanLoadingStateWidget()
                : (state is PlanEmpty)
                    ? _buildPlanEmptyStateWidget()
                    : (state is PlanError)
                        ? _buildPlanErrorStateWidget(context)
                        : (state is PlanLoaded)
                            ? _buildPlanLoadedStateWidget(state)
                            : SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildPlanLoadingStateWidget() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: 5,
      separatorBuilder: (_, __) => const Gap(32),
      itemBuilder: (context, index) {
        return PlanCardShimmer();
      },
    );
  }

  Widget _buildPlanLoadedStateWidget(PlanLoaded state) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: state.plans.length,
            separatorBuilder: (_, __) => const Gap(32),
            itemBuilder: (context, index) {
              final plan = state.plans[index];
              final isSelected = plan.isSelected;
              return PlanCard(isSelected: isSelected, plan: plan);
            },
          ),
        ),
        SpecialPlan(),
        Gap(8),
        CustomBtn(label: AppStrings.next),
        Gap(12),
      ],
    );
  }

  Widget _buildPlanErrorStateWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network("https://cdn-icons-png.flaticon.com/512/2797/2797387.png", width: 70),
            Gap(12),
            Text(AppStrings.errorFetchingPlans, style: AppStyles.font16BlackMedium),
            const Gap(32),
            IntrinsicWidth(child: CustomBtn(label: AppStrings.retry, onTap: () => context.read<PlanCubit>().getPlans())),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanEmptyStateWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network("https://cdn-icons-png.flaticon.com/512/4946/4946348.png", width: 100),
        Gap(8),
        Center(child: Text(AppStrings.noPlansAvailable, style: AppStyles.font10BlackRegular)),
      ],
    );
  }
}
