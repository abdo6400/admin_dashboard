import 'package:admin/app/service_locator.dart';
import 'package:admin/config/locale/app_localizations.dart';
import 'package:admin/core/components/cubits/auth_check_cubit/auth_check_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:quickalert/quickalert.dart';
import '../../../../config/database/cache/cache_consumer.dart';
import '../../../utils/app_enums.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_sizes.dart';
import '../shared_components/app_logo_component.dart';

class DrawerMenuComponent extends StatelessWidget {
  const DrawerMenuComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isEn = AppLocalizations.of(context)!.isEnLocale;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: !isEn
              ? Radius.circular(context.radius * 50)
              : Radius.circular(context.radius * 10),
          bottomRight: isEn
              ? Radius.circular(context.radius * 50)
              : Radius.circular(context.radius * 10),
          topLeft: !isEn
              ? Radius.circular(context.radius * 50)
              : Radius.circular(context.radius * 10),
          topRight: isEn
              ? Radius.circular(context.radius * 50)
              : Radius.circular(context.radius * 10)),
    );
    return Card(
        shape: shape,
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
        margin: EdgeInsets.symmetric(
            horizontal: 0, vertical: context.marginHeight * 20),
        child: Drawer(
          width: context.screenWidth * 0.7,
          shape: shape,
          backgroundColor:
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const AppLogoComponent(),
            const Divider(),
            SizedBox(
              height: context.sizeHeight * 10,
            ),
            ListTile(
              onTap: () => Navigator.of(context).pop(),
              title: Text(AppStrings.profile.tr(context)),
              leading: const Icon(
                Icons.person,
                color: Colors.grey,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
               
              },
              title: Text(AppStrings.myOrders.tr(context)),
              leading: const Icon(
                Icons.receipt_rounded,
                color: Colors.green,
              ),
            ),
            ListTile(
              onTap: () => Navigator.of(context).pop(),
              title: Text(AppStrings.notifcations.tr(context)),
              leading: const Icon(
                Icons.notifications,
                color: Colors.amber,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
               
              },
              title: Text(AppStrings.languages.tr(context)),
              leading: const Icon(
                Icons.language_outlined,
                color: Colors.blueGrey,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
  
              },
              title: Text(AppStrings.themes.tr(context)),
              leading: const Icon(
                Icons.dark_mode_rounded,
                color: Colors.yellow,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              
              },
              title: Text(AppStrings.chatWithAi.tr(context)),
              leading: Icon(
                Icons.chat,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              title: Text(AppStrings.chatWithUs.tr(context)),
              leading: const Icon(
                Icons.contact_support,
                color: Colors.blue,
              ),
            ),
            const Spacer(),
            ListTile(
                tileColor: Theme.of(context).colorScheme.secondary,
                onTap: () async {
                  context.loaderOverlay.show();
                  await sl<CacheConsumer>()
                      .clearValue(key: MySharedKeys.apiToken.name);
                  context.loaderOverlay.hide();

                  QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          autoCloseDuration: Durations.extralong4,
                          showConfirmBtn: false,
                          width: context.screenWidth / 4,
                          title: AppStrings.logout.tr(context))
                      .then((value) {
                    Navigator.of(context).pop();
                    context.read<AuthCheckCubit>().checkAuthentication();
                  });
                },
                title: Text(
                  AppStrings.logout.tr(context),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).cardColor),
                ),
                leading: Icon(
                  Icons.logout_outlined,
                  color: Theme.of(context).cardColor,
                )),
          ]),
        ));
  }
}
