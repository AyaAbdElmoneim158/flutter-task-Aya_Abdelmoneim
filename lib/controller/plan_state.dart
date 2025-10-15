import 'package:otex_app/models/plan.dart';

abstract class PlanState {}

class PlanInitial extends PlanState {}

class PlanLoading extends PlanState {}

class PlanEmpty extends PlanState {}

class PlanLoaded extends PlanState {
  final List<Plan> plans;
  PlanLoaded(this.plans);
}

class PlanError extends PlanState {
  final String message;
  PlanError(this.message);
}
