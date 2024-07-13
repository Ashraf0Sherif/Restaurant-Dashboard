import 'dart:typed_data';

import '../../../core/firebase/custom_firebase.dart';
import '../../../core/firebase/firebase_exceptions.dart';
import '../../../core/firebase/firebase_result.dart';
import '../data/models/banner_model.dart';
import 'banner_repo.dart';

class BannerRepoImplementation implements BannerRepo {
  final CustomFirebase customFirebase;

  BannerRepoImplementation(this.customFirebase);

  @override
  Future<FirebaseResult<BannerModel>> addBanner(
      {required BannerModel banner, required Uint8List imageFile}) async {
    try {
      var response = await customFirebase.addBanner(banner: banner, imageFile: imageFile);
      return  FirebaseResult.success(response);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<void>> deleteBanner({required String bannerId}) async {
    try {
      await customFirebase.deleteBanner(bannerId: bannerId);
      return const FirebaseResult.success(null);
    } catch (error) {
      print(error);
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<BannerModel>> updateBanner(
      {required BannerModel banner, required Uint8List imageFile}) async {
    try {
      var response = await customFirebase.updateBanner(banner: banner, imageFile: imageFile);
      return  FirebaseResult.success(response);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }

  @override
  Future<FirebaseResult<List<BannerModel>>> getBanners() async {
    try {
      List<BannerModel> banners = await customFirebase.getBanners();
      return FirebaseResult.success(banners);
    } catch (error) {
      return FirebaseResult.failure(
          FirebaseExceptions.getFirebaseException(error));
    }
  }
}
