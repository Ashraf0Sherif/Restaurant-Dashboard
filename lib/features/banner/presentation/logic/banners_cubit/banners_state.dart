part of 'banners_cubit.dart';

@immutable
abstract class BannersState {}

class BannersInitial extends BannersState {}

class BannersLoading extends BannersState {}

class BannersFailure extends BannersState {
  final String errorMessage;

  BannersFailure({required this.errorMessage});
}

class BannersSuccess extends BannersState {
  final List<BannerModel> banners;

  BannersSuccess({required this.banners});
}
