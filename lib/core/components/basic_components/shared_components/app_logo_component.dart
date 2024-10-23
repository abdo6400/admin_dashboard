import 'package:flutter/material.dart';

import '../../../utils/app_images.dart';
import '../../../utils/app_sizes.dart';

class AppLogoComponent extends StatelessWidget {
  const AppLogoComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: context.paddingHeight * 20),
      child: CircleAvatar(
        radius: context.radius * 40,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(context.radius * 100),
            child: Image.asset(AppImages.appLogo)),
      ),
    );
  }
}
