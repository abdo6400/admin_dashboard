import 'package:admin/config/locale/app_localizations.dart';
import 'package:admin/core/components/default_components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_sizes.dart';
import '../../cubits/auth_check_cubit/auth_check_cubit.dart';

class AuthenticationCheckerComponent extends StatefulWidget {
  final Widget child;
  const AuthenticationCheckerComponent({super.key, required this.child});

  @override
  State<AuthenticationCheckerComponent> createState() => _AuthenticationCheckerComponentState();
}

class _AuthenticationCheckerComponentState extends State<AuthenticationCheckerComponent> {

  @override
  void initState() {
    super.initState();
    context.read<AuthCheckCubit>().checkAuthentication();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCheckCubit, bool>(
      listener: (context, isAuthenticated) {},
      builder: (context, isAuthenticated) {
        if (isAuthenticated) {
          return widget.child;
        } else {
          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.paddingWidth * 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  size: context.font * 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(height: context.sizeHeight * 10),
                Text(
                  AppStrings.pleaseSignToUseAllFeatures.tr(context),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: context.sizeHeight * 20),
                DefaultButton(
                    text: AppStrings.login,
                    onPressed: () =>
                        {}),
                SizedBox(height: context.sizeHeight * 10),
                DefaultButton(
                    text: AppStrings.signUp,
                    background: Colors.transparent,
                    elevation: 0,
                    textColor: Theme.of(context).textTheme.titleSmall!.color!,
                    borderColor: Theme.of(context).textTheme.titleSmall!.color!,
                    onPressed: () =>
                        {}),
              ],
            ),
          );
        }
      },
    );
  }
}
