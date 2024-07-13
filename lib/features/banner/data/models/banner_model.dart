import 'package:freezed_annotation/freezed_annotation.dart';
part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  String bannerId;
  String title;
  String description;
  String image;
  String startDate;
  String endDate;

  BannerModel(
      {required this.bannerId,
      required this.title,
      required this.description,
      required this.image,
      required this.startDate,
      required this.endDate});
  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
