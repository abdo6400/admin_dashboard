import 'package:admin/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quickalert/quickalert.dart';
import 'app_enums.dart';
import 'app_sizes.dart';


extension ToastExtension on BuildContext {
  void showToast(String message, {ToastType type = ToastType.shortToast, ToastStates state = ToastStates.success}) {
    Color backgroundColor = _chooseToastColor(state);

    Fluttertoast.showToast(
      msg: message.tr(this),  // Assuming you're using localization here
      toastLength: type == ToastType.shortToast ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: font * 10,
    );
  }

  // Private helper method to map ToastStates to corresponding colors
  Color _chooseToastColor(ToastStates state) {
    switch (state) {
      case ToastStates.success:
        return Colors.green;
      case ToastStates.error:
        return Colors.red;
      case ToastStates.warning:
        return Colors.orange;
      default:
        return Colors.grey;  // Fallback color
    }
  }
}


extension SnackBarExtension on BuildContext {
  void showCustomSnackBar(String message,
      {SnackBarType type = SnackBarType.info}) {
    final backgroundColor = type == SnackBarType.success
        ? Colors.green
        : type == SnackBarType.error
            ? Colors.red
            : Colors.blue;
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message.tr(this),),
        duration: const Duration(seconds: 2),
        backgroundColor: backgroundColor,
      ),
    );
  }
}

extension QuickAlertExtension on BuildContext {
  void showQuickAlert(String message,
      {QuickAlertTypeEnum type = QuickAlertTypeEnum.success}) {
    QuickAlert.show(
      context: this,
      type: type == QuickAlertTypeEnum.success
          ? QuickAlertType.success
          : QuickAlertType.error,
      autoCloseDuration: Durations.extralong4,
      title: message.tr(this),
      showConfirmBtn: false,
      width: screenWidth / 4,
    );
  }

  void showSuccessQuickAlert(String message, Function callback) {
    QuickAlert.show(
      context: this,
      type: QuickAlertType.success,
      autoCloseDuration: Durations.extralong4,
      showConfirmBtn: false,
      width: screenWidth / 4,
      title: message.tr(this),
    ).then((value) => callback());
  }
}
