import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/controller/home_cubit.dart';
import 'package:otex_app/controller/home_state.dart';
import 'package:otex_app/helper/app_strings.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/helper/widgets/error_state_widget.dart';
import 'package:otex_app/widgets/home_view/alert_container.dart';
import 'package:otex_app/widgets/home_view/category_list.dart';
import 'package:otex_app/widgets/home_view/explore_offers.dart';
import 'package:otex_app/widgets/home_view/product_card.dart';
import 'package:otex_app/widgets/home_view/product_grid.dart';

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
            final cubit = context.read<HomeCubit>();
            //!  HomeLoadingStats
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            //*  HomeErrorStats
            if (state is HomeError) {
              return errorStateWidget(context: context, message: AppStrings.errorFetchingData, onTap: () => cubit.loadInitialData());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExploreOffers(),
                    const Gap(24),
                    CategoryList(),
                    const Gap(24),
                    const AlertContainer(),
                    const Gap(24),
                    ProductGrid(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
