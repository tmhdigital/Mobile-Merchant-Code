import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:merchent/screen/common_widget/common_text_widget.dart';
import 'package:merchent/utils/app_size.dart';
import 'package:merchent/widget/app_image/app_image.dart';

class DevLogoText extends StatelessWidget {
  final TextAlign textAlignment;
  final double logoSize;
  const DevLogoText({
    super.key,
    this.textAlignment = TextAlign.center,
    this.logoSize = 100,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isSmallScreen = screenHeight < 700;
    final isMobile = screenWidth < 400;

    return AppImage(
      path: "assets/images/rewaldo-logo.png",
      width: 250,
      height: 150,
    );

    // return TextWidget(
    //   text: 'Logo',
    //   textAlignment: textAlignment,
    //   fontSize: AppSize.width(value: logoSize),
    //   fontWeight: FontWeight.w700,
    //   fontColor: Colors.white,

    // );
  }
}
