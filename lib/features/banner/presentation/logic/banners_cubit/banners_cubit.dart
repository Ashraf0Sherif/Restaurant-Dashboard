import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:restaurant_admin_panel/features/banner/data/models/banner_model.dart';
import 'package:restaurant_admin_panel/features/banner/repo/banner_repo_implementation.dart';

import '../../../../../core/firebase/firebase_exceptions.dart';

part 'banners_state.dart';

class BannersCubit extends Cubit<BannersState> {
  BannersCubit(this.bannerRepoImplementation) : super(BannersInitial());
  BannerRepoImplementation bannerRepoImplementation;
  List<BannerModel> banners = [];

  Future<void> getBanners() async {
    emit(BannersLoading());
    var response = await bannerRepoImplementation.getBanners();
    response.when(
      success: (banners) {
        this.banners = banners;
        emit(BannersSuccess(banners: banners));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(BannersFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }

  void searchBanners(String query) {
    final searchQuery = query.toLowerCase();
    final filteredBanners = banners.where((banner) {
      return banner.title.toLowerCase().contains(searchQuery);
    }).toList();
    emit(BannersSuccess(banners: filteredBanners));
  }

  Future<void> addBanner(
      {required BannerModel banner, required Uint8List imageFile}) async {
    emit(BannersLoading());
    var response = await bannerRepoImplementation.addBanner(
        banner: banner, imageFile: imageFile);
    response.when(
      success: (banner) {
        banners.insert(0, banner);
        emit(BannersSuccess(banners: banners));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(BannersFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }

  Future<void> deleteBanner({required String bannerId}) async {
    emit(BannersLoading());
    var response =
        await bannerRepoImplementation.deleteBanner(bannerId: bannerId);
    response.when(
      success: (done) {
        banners.removeWhere((element) => element.bannerId == bannerId);
        emit(BannersSuccess(banners: banners));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(BannersFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }

  Future<void> updateBanner(
      {required BannerModel banner, required Uint8List imageFile}) async {
    emit(BannersLoading());
    var response = await bannerRepoImplementation.updateBanner(
        banner: banner, imageFile: imageFile);
    response.when(
      success: (banner) {
        int bannerIndex = banners
            .indexWhere((element) => element.bannerId == banner.bannerId);
        banners[bannerIndex] = banner;
        emit(BannersSuccess(banners: banners));
      },
      failure: (FirebaseExceptions firebaseExceptions) {
        emit(BannersFailure(
            errorMessage:
                FirebaseExceptions.getErrorMessage(firebaseExceptions)));
      },
    );
  }
}
