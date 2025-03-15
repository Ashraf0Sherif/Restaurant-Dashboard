import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/services/firebase/firebase_exceptions.dart';
import '../../data/models/revenue_model.dart';
import '../../data/repos/dashboard_repo.dart';

part 'revenue_state.dart';

part 'revenue_cubit.freezed.dart';

class RevenueCubit extends Cubit<RevenueState> {
  final DashboardRepo dashboardRepo;

  RevenueCubit(this.dashboardRepo) : super(const RevenueState.initial());
  late final double currentWeekRevenue;
  late final double lastWeekRevenue;

  void fetchWeeklyRevenueData() async {
    emit(const RevenueState.loading());
    final response = await dashboardRepo.fetchWeeklyRevenueData();
    response.when(
      success: (revenueData) {
        currentWeekRevenue = revenueData.getCurrentWeekRevenue();
        lastWeekRevenue = revenueData.getLastWeekRevenue();
        emit(RevenueState.loaded(revenueData: revenueData));
      },
      failure: (error) {
        emit(RevenueState.error(
            message: FirebaseExceptions.getErrorMessage(error)));
      },
    );
  }
}
