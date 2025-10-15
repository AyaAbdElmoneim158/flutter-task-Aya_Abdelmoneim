import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otex_app/controller/plan_state.dart';
import 'package:otex_app/helper/database_helper.dart';
import 'package:otex_app/models/plan.dart';

class PlanCubit extends Cubit<PlanState> {
  PlanCubit() : super(PlanInitial());

  Future<void> getPlans() async {
    emit(PlanLoading());
    try {
      final plans = await DatabaseHelper().getAllPlans();
      if (plans.isEmpty) {
        emit(PlanEmpty());
        return;
      }
      emit(PlanLoaded(plans));
    } catch (e) {
      emit(PlanError('Failed to load plans: $e'));
    }
  }

  void togglePlanSelection(int planId) {
    if (state is PlanLoaded) {
      final currentState = state as PlanLoaded;
      final updatedPlans = currentState.plans.map((plan) {
        if (plan.id == planId) {
          return plan.copyWith(isSelected: !plan.isSelected);
        }
        return plan;
      }).toList();
      emit(PlanLoaded(updatedPlans));
    }
  }

  void selectPlan(int planId, bool isSelected) {
    if (state is PlanLoaded) {
      final currentState = state as PlanLoaded;
      final updatedPlans = currentState.plans.map((plan) {
        if (plan.id == planId) {
          return plan.copyWith(isSelected: isSelected);
        }
        return plan;
      }).toList();
      emit(PlanLoaded(updatedPlans));
    }
  }

  List<Plan> get selectedPlans {
    if (state is PlanLoaded) {
      return (state as PlanLoaded).plans.where((plan) => plan.isSelected).toList();
    }
    return [];
  }
}
