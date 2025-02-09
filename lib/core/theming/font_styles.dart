import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_admin_panel/core/theming/font_weight_helper.dart';

import 'colors.dart';

abstract class FontStyles {
  static double getScaleFactor(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    if (width < 600) {
      return width / 400;
    } else if (width < 900) {
      return width / 700;
    } else {
      return width / 1000;
    }
  }

  static double getResponsiveFontSize(BuildContext context, double fontSize) {
    double scaleFactor = getScaleFactor(context);
    double responseFontSize = fontSize * scaleFactor;
    double lowerLimit = fontSize * 0.8;
    double upperLimit = fontSize * 1.2;
    return responseFontSize.clamp(lowerLimit, upperLimit);
  }

  static TextStyle font20BlackBold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.black,
  );
  static TextStyle font24BlackMedium = TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeightHelper.medium,
      color: Colors.black);
  static TextStyle font20BlackMedium = TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeightHelper.medium,
      color: Colors.black);
  static TextStyle font18PassiveRegular = TextStyle(
    fontSize: 18.sp,
    color: ColorsStyles.kPassiveColor,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font18BlackSemiBold = TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeightHelper.semiBold,
      color: Colors.black);
  static TextStyle font24SecondaryColorBold = TextStyle(
    color: ColorsStyles.kSecondaryColor,
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font12PassiveBold = TextStyle(
    color: ColorsStyles.kPassiveColor,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font12PassiveRegular = TextStyle(
    color: ColorsStyles.kPassiveColor,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font12BlackRegular = TextStyle(
    color: Colors.black,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font12PrimaryColorRegular = TextStyle(
    color: ColorsStyles.kPrimaryColor,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font24Bold = TextStyle(
    color: Colors.black,
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font16GreyRegular = TextStyle(
    color: Colors.grey,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font18GreyMedium = TextStyle(
    color: Colors.grey,
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font16BlackBold = TextStyle(
    color: Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font16BlackMedium = TextStyle(
    color: Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font17PrimaryColorMedium = TextStyle(
    color: ColorsStyles.kPrimaryColor,
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font13GreyRegular = TextStyle(
    color: Colors.grey,
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font13BlackBold = TextStyle(
    color: Colors.black,
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font16SecondaryColorBold = TextStyle(
    color: ColorsStyles.kSecondaryColor,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font16PassiveRegular = TextStyle(
    color: ColorsStyles.kPassiveColor,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font14SecondaryColorMedium = TextStyle(
    color: ColorsStyles.kSecondaryColor,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
  );
  static TextStyle font12SecondaryColorBold = TextStyle(
    color: ColorsStyles.kSecondaryColor,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font14WhiteBold = TextStyle(
    color: Colors.white,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
  );
  static TextStyle font14PassiveRegular = TextStyle(
    color: ColorsStyles.kPassiveColor,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font14GreyRegular = TextStyle(
    color: Colors.grey,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font14BlackRegular = TextStyle(
    color: Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
  );
  static TextStyle font16WhiteSemiBold = TextStyle(
    color: Colors.white,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font16BlackSemiBold = TextStyle(
    color: Colors.black,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font16PrimaryColoSemiBold = TextStyle(
    color: ColorsStyles.kPrimaryColor,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font20PrimaryColoSemiBold = TextStyle(
    color: ColorsStyles.kPrimaryColor,
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.semiBold,
  );
  static TextStyle font13CustomRedColorBold = TextStyle(
    color: ColorsStyles.kCustomRedColor,
    fontSize: 13.sp,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font18PrimaryColorBold = TextStyle(
    color: ColorsStyles.kPrimaryColor,
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font24PrimaryColorBold = TextStyle(
    color: ColorsStyles.kPrimaryColor,
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
  );

  static TextStyle font12GreyRegular = TextStyle(
    color: Colors.grey[400],
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
  );
}
