import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/controller/plan_cubit.dart';
import 'package:otex_app/controller/plan_state.dart';
import 'package:otex_app/helper/app_colors.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/views/filter_view.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlanCubit()..getPlans(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 76,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("أختر الباقات اللى تناسبك", style: AppStyles.font24BlackMedium),
              Text("أختار من باقات التمييز بل أسفل اللى تناسب أحتياجاتك", style: AppStyles.font14BlackRegular),
            ],
          ),
        ),
        body: BlocBuilder<PlanCubit, PlanState>(
          builder: (context, state) {
            if (state is PlanLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PlanEmpty) {
              return const Center(child: Text('No plans available'));
            }

            if (state is PlanError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(state.message),
                    Text('An error occurred while fetching plans.', style: AppStyles.font16BlackMedium),
                    const Gap(16),
                    ElevatedButton(
                      onPressed: () => context.read<PlanCubit>().getPlans(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is PlanLoaded) {
              final plans = state.plans;

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: plans.length,
                      separatorBuilder: (_, __) => const Gap(32),
                      itemBuilder: (context, index) {
                        final plan = plans[index];
                        final isSelected = plan.isSelected;

                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0x1A000000),
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x0A090F1F),
                                    offset: Offset(0, 4),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // --- Header row: checkbox + title + price
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Theme(
                                            data: Theme.of(context).copyWith(
                                              checkboxTheme: CheckboxThemeData(
                                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                visualDensity: VisualDensity.compact,
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
                                            style: AppStyles.font16BlackMedium.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${plan.price.toStringAsFixed(2)} ج.م",
                                        style: AppStyles.font16BlackMedium.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(color: AppColors.black.withOpacity(0.1)),
                                  const Gap(4),
                                  // --- Features list
                                  Column(
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
                                                  child: Text(
                                                    feature.name,
                                                    style: AppStyles.font14BlackMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                            (plan.description.isEmpty)
                                ? const SizedBox.shrink()
                                : Positioned(
                                    top: -20,
                                    child:
                                        // Usage with custom properties:
                                        IntrinsicWidth(
                                      child: CustomPaint(
                                        painter: CustomShapePainter(
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
                                  )
                          ],
                        );
                      },
                    ),
                  ),
                  // Expanded(child: const Gap(16)),
                  SpecialPlan(),
                  // Next Button
                  BlocBuilder<PlanCubit, PlanState>(
                    builder: (context, state) {
                      final selectedCount = context.read<PlanCubit>().selectedPlans.length;
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: selectedCount > 0 ? AppColors.lightPrimary : Colors.grey,
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "التالي",
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class CustomShapePainter extends CustomPainter {
  final Color color;
  final double notchPosition;

  const CustomShapePainter({
    this.color = const Color(0xffFFDBDB),
    this.notchPosition = 9.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Path path = Path();

    path.moveTo(0, 6.1);
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(notchPosition, size.height / 2); // Dynamic notch position
    path.lineTo(0, 6.1);
    path.close();

    final Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is CustomShapePainter && (oldDelegate.color != color || oldDelegate.notchPosition != notchPosition);
  }
}
