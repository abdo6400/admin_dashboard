import 'package:admin/config/locale/app_localizations.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_sizes.dart';

class CustomInternetConnectionChecker extends StatefulWidget {
  final Widget? child;
  const CustomInternetConnectionChecker({super.key, this.child});
  @override
  State<CustomInternetConnectionChecker> createState() =>
      _CustomInternetConnectionCheckerState();
}

class _CustomInternetConnectionCheckerState
    extends State<CustomInternetConnectionChecker> {
  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        List<ConnectivityResult> connectivity,
        Widget child,
      ) {
        if (connectivity.contains(ConnectivityResult.none)) {
          return const _NoInternet();
        } else {
          return child;
        }
      },
      builder: (BuildContext context) {
        return widget.child!;
      },
    );
  }
}

class _NoInternet extends StatelessWidget {
  const _NoInternet();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: context.radius * 40,
            backgroundColor: AppColors.white,
            child: AvatarGlow(
              animate: true,
              glowColor: AppColors.grey,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              child: Icon(
                Icons.wifi_off_outlined,
                size: context.font * 30,
                color: AppColors.primary,
              ),
            ),
          ),
          Text(
            AppStrings.noInternetConnection.tr(context),
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
