import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http_parser/http_parser.dart';
import '../../app/service_locator.dart';
import '../../config/database/cache/cache_consumer.dart';
import '../../config/database/error/exceptions.dart';
import 'app_enums.dart';

//open url
Future<void> openUrl(String urlLink) async {
  final Uri url = Uri.parse(urlLink);
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}

// compare date with another date.
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

//close keyboard when finished user typing.
extension CloseKeyboard on BuildContext {
  void closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(this);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

// convert image to be uploaded to API.
Future multipartConvertImage({
  required XFile image,
}) async {
  return MultipartFile.fromFileSync(image.path,
      contentType: MediaType('image', 'jpeg'),
      filename: image.path.split('/').last);
}

//* Image Picker
//pick image from user either from camera or from gallery.
Future<XFile?> pickImage(ImageSource source) async {
  XFile? image = await ImagePicker().pickImage(
      source: source, maxHeight: 1024, maxWidth: 1024, imageQuality: 50);
  if (image != null) {
    return image;
  } else {
    return null;
  }
}

Future<XFile?> pickvideo(ImageSource source) async {
  XFile? image = await ImagePicker()
      .pickVideo(source: source, maxDuration: const Duration(minutes: 2));
  if (image != null) {
    return image;
  } else {
    return null;
  }
}

extension NavigateAndFinish on BuildContext {
  void navigateToFirstRoute() {
    Navigator.of(this, rootNavigator: true).popUntil((route) => route.isFirst);
  }

  void navigateTo({
    required String screenRoute,
    dynamic arg,
  }) {
    Navigator.of(this, rootNavigator: true)
        .pushNamed(screenRoute, arguments: arg);
  }

  void navigateAndFinish({
    required String screenRoute,
    dynamic arg,
  }) {
    Navigator.of(this, rootNavigator: true)
        .pushReplacementNamed(screenRoute, arguments: arg);
  }

  void navigateAndFinishAll({
    required String screenRoute,
    dynamic arg,
  }) {
    Navigator.of(this, rootNavigator: true)
        .pushNamedAndRemoveUntil(screenRoute, (value) => false, arguments: arg);
  }
}

Future<XFile> downloadAndSaveImage(String imageUrl) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$imageUrl.jpg';
  await sl<Dio>().download(imageUrl, filePath);
  return XFile(filePath);
}

Future<Either<CacheException, String>> saveToken(
    String token, String refreshToken) async {
  try {
    await sl<CacheConsumer>()
        .saveData(key: MySharedKeys.apiToken.name, value: token);
    await sl<CacheConsumer>()
        .saveData(key: MySharedKeys.refreshToken.name, value: refreshToken);
    return const Right('Done');
  } catch (e) {
    return Left(CacheException(message: e.toString()));
  }
}
