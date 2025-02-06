import 'dart:typed_data';

import '../../../../core/firebase/firebase_result.dart';
import '../models/banner_model.dart';

abstract class BannerRepo {
  Future<FirebaseResult<List<BannerModel>>> getBanners();

  Future<FirebaseResult<BannerModel>> addBanner(
      {required BannerModel banner, required Uint8List imageFile});

  Future<void> deleteBanner({required String bannerId});

  Future<void> updateBanner(
      {required BannerModel banner, required Uint8List imageFile});
}
