import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:restaurant_admin_panel/core/services/firebase/firebase_exceptions.dart';

import '../../data/models/revenue_model.dart';
import '../../data/repos/dashboard_repo.dart';

part 'dashboard_state.dart';
part 'dashboard_cubit.freezed.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardRepo dashboardRepo;
  DashboardCubit(this.dashboardRepo) : super(const DashboardState.initial());
  late final double currentWeekRevenue;
  late final double lastWeekRevenue;
  void fetchWeeklyRevenueData() async {
    emit(const DashboardState.loading());
    final response = await dashboardRepo.fetchWeeklyRevenueData();
    response.when(
      success: (revenueData) {
        currentWeekRevenue = revenueData.getCurrentWeekRevenue();
        lastWeekRevenue = revenueData.getLastWeekRevenue();
        emit(DashboardState.loaded(revenueData: revenueData));
      },
      failure: (error) {
        emit(DashboardState.error(
            message: FirebaseExceptions.getErrorMessage(error)));
      },
    );
  }
}
