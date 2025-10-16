import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:otex_app/controller/plan_cubit.dart';
import 'package:otex_app/helper/app_colors.dart';
import 'package:otex_app/helper/app_styles.dart';
import 'package:otex_app/views/home_view.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  int selectedTypes = 0;
  int selectedRooms = 0;
  int selectedPaymentWays = 0;
  int selectedPropertyStates = 0;

  List<String> types = ['الكل', 'توين هاوس', 'فيلا منفصلة', 'تاون هاوس'];
  List<String> rooms = ['4 غرف', '5 غرف', 'الكل', 'غرفتين', '3 غرف'];
  List<String> paymentWays = ['كاش', 'تقسيط', 'أى'];
  List<String> propertyStates = ['قيد الأنشاء', 'جاهز', 'أى'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 76,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("فلترة", style: AppStyles.font24BlackMedium),
            GestureDetector(
              onTap: () {
                // Reset all filters to default
                setState(() {
                  selectedTypes = 0;
                  selectedRooms = 0;
                  selectedPaymentWays = 0;
                  selectedPropertyStates = 0;
                });
              },
              child: Text(
                "رجوع للأفتراضى",
                style: AppStyles.font16GrayBold.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AlertContainer(),
                // const Gap(16),
                // SpecialPlan(),
                const Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Icon(Icons.location_on_outlined, color: AppColors.black),
                      Column(
                        children: [
                          Text("الموقع", style: AppStyles.font14BlackMedium),
                          Text("مصر", style: AppStyles.font12BlackRegular.copyWith(color: AppColors.black.withOpacity(0.5))),
                        ],
                      ),
                    ]),
                    Icon(Icons.arrow_forward_ios, color: AppColors.black, size: 12),
                  ],
                ),
                const Gap(16),

                _buildSectionHeader('الفئة'),
                const Gap(16),
                Row(
                  children: [],
                ),
                Divider(color: AppColors.black.withOpacity(0.1)),

                // Monthly Installments Section
                _buildSectionHeader('الأقساط الشهرية'),
                Row(
                  spacing: 16,
                  children: [CustomField(), CustomField()],
                ),
                const Gap(8),
                Divider(color: AppColors.black.withOpacity(0.1)),

                // Type Section
                _buildSectionHeader('النوع'),
                const Gap(8),
                _buildHorizontalList(
                  items: types,
                  selectedIndex: selectedTypes,
                  onItemSelected: (index) {
                    setState(() {
                      selectedTypes = index;
                    });
                  },
                ),
                const Gap(16),
                Divider(color: AppColors.black.withOpacity(0.1)),

                // Rooms Section
                _buildSectionHeader('عدد الغرف'),
                const Gap(8),
                _buildHorizontalList(
                  items: rooms,
                  selectedIndex: selectedRooms,
                  onItemSelected: (index) {
                    setState(() {
                      selectedRooms = index;
                    });
                  },
                ),
                const Gap(16),
                Divider(color: AppColors.black.withOpacity(0.1)),

                // Price Section
                _buildSectionHeader('السعر'),
                const Gap(16),
                Row(
                  spacing: 16,
                  children: [CustomField(hintText: 'أقل سعر'), CustomField(hintText: 'أقصى سعر')],
                ),
                Divider(color: AppColors.black.withOpacity(0.1)),

                // Payment Method Section
                _buildSectionHeader('طريقة الدفع'),
                const Gap(8),
                _buildHorizontalList(
                  items: paymentWays,
                  selectedIndex: selectedPaymentWays,
                  onItemSelected: (index) {
                    setState(() {
                      selectedPaymentWays = index;
                    });
                  },
                ),
                const Gap(16),
                Divider(color: AppColors.black.withOpacity(0.1)),

                // Property State Section
                _buildSectionHeader('حالة العقار'),
                const Gap(8),
                _buildHorizontalList(
                  items: propertyStates,
                  selectedIndex: selectedPropertyStates,
                  onItemSelected: (index) {
                    setState(() {
                      selectedPropertyStates = index;
                    });
                  },
                ),
                const Gap(16),
                Divider(color: AppColors.black.withOpacity(0.1)),

                // Apply Filter Button
                const Gap(32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Apply filters logic
                      _applyFilters();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'شاهد 10,000+ نتائج',
                      style: AppStyles.font16GrayBold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppStyles.font16BlackMedium.copyWith(
        color: AppColors.black.withOpacity(0.5),
      ),
    );
  }

  Widget _buildHorizontalList({
    required List<String> items,
    required int selectedIndex,
    required Function(int) onItemSelected,
  }) {
    return SizedBox(
      height: 39,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onItemSelected(index),
          child: CustomCard(
            items[index],
            isSelected: selectedIndex == index,
          ),
        ),
        separatorBuilder: (context, index) => const Gap(8),
        itemCount: items.length,
      ),
    );
  }

  void _applyFilters() {
    // Implement your filter logic here
    final selectedType = types[selectedTypes];
    final selectedRoom = rooms[selectedRooms];
    final selectedPayment = paymentWays[selectedPaymentWays];
    final selectedPropertyState = propertyStates[selectedPropertyStates];

    print('Applied Filters:');
    print('Type: $selectedType');
    print('Rooms: $selectedRoom');
    print('Payment: $selectedPayment');
    print('Property State: $selectedPropertyState');

    // You can use Bloc here to update the state
    // context.read<PlanCubit>().applyFilters(...);

    // Navigate back or show results
    Navigator.pop(context);
  }
}

class CustomField extends StatelessWidget {
  const CustomField({super.key, this.hintText});
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xFF000000).withOpacity(0.1),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xFF000000).withOpacity(0.1),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xFF000000).withOpacity(0.1),
              width: 1,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String category;
  final bool isSelected;

  const CustomCard(this.category, {super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withOpacity(0.05) : const Color(0x4DFFFFFF),
        border: Border.all(
          color: isSelected ? AppColors.primary : const Color(0x1A000000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        category,
        style: AppStyles.font16GrayBold.copyWith(
          color: isSelected ? AppColors.primary : AppColors.gray,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
