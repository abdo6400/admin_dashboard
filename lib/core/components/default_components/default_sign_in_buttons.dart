import 'package:admin/config/locale/app_localizations.dart';
import 'package:admin/core/utils/app_strings.dart';
import 'package:admin/core/utils/app_sizes.dart';
import 'package:flutter/material.dart';
import '../../utils/app_enums.dart';

// ignore: must_be_immutable
class SignInButton extends StatelessWidget {
  // required
  /// [buttonType] sets the style and icons of the button.
  ButtonType buttonType;

  // required
  /// [onPressed] Send a function to trigger the button.
  VoidCallback? onPressed;

  // not required, default left
  /// [imagePosition] set the position of the icon.(left or right)
  ImagePosition? imagePosition;

  // not required, default 5.0
  /// [elevation] set the button's elevation value.
  double elevation;

  // not required, default small
  /// [buttonSize] set the size of the button. (small medium large)
  ButtonSize buttonSize;

  // not required, Gets value according to buttonType.
  /// [btnColor] Set the background color of the button.
  Color? btnColor;

  // not required, Gets value according to buttonType.
  /// [btnDisabledColor] Set the background color of the disabled button.
  Color? btnDisabledColor;

  // not required, Gets value according to buttonType.
  /// [btnTextColor] set the button's text color.
  Color? btnTextColor;

  // not required, Gets value according to buttonType.
  /// [btnDisabledTextColor] set the disabled button's text color.
  Color? btnDisabledTextColor;

  // not required, Gets value according to buttonType.
  /// [btnText] set the button's text.
  String? btnText;

  // not required, Gets value according to buttonSize.
  /// You can change the value of [width] when the text size becomes too small.
  double? width;

  // not required, Gets value according to buttonSize.
  /// [padding] set the button's padding value.
  double? padding;

  /// [_image] value cannot be assigned.Gets value according to [buttonType].
  Widget? _image;

  /// [image] use to assign an image, otherwise [_image] is used
  // not required
  String? image;

  /// [_imageSize] value cannot be assigned.Gets value according to [buttonSize].
  double? _imageSize;

  // not required, button shape.
  /// [shape] set the button's shape.
  ShapeBorder? shape;

  // not required, button model.
  /// [mini] It automatically takes value according to the selected constructor.
  bool mini;

  SignInButton({
    super.key,
    required this.buttonType,
    required this.onPressed,
    this.imagePosition = ImagePosition.left,
    this.buttonSize = ButtonSize.small,
    this.btnColor,
    this.btnDisabledColor,
    this.btnTextColor,
    this.btnDisabledTextColor,
    this.btnText,
    this.elevation = 1,
    this.width,
    this.padding,
    this.shape,
    this.image,
  }) : mini = false;

  SignInButton.mini({
    super.key,
    required this.buttonType,
    required this.onPressed,
    this.buttonSize = ButtonSize.small,
    this.btnColor,
    this.btnDisabledColor,
    this.elevation = 1,
    this.padding,
    this.image,
  }) : mini = true;

  bool get _enabled => onPressed != null;

  bool get _disabled => !_enabled;

  @override
  Widget build(BuildContext context) {
    _createStyle(context);
    return !mini
        ? MaterialButton(
            color: Theme.of(context).scaffoldBackgroundColor,
            disabledColor: btnDisabledColor,
            shape: shape ??
                StadiumBorder(
                    side: BorderSide(
                        color: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .color!
                            .withOpacity(0.1))),
            onPressed: onPressed,
            elevation: elevation,
            child: Container(
              width: width,
              padding: EdgeInsets.symmetric(
                  vertical: context.paddingHeight * 5,
                  horizontal: context.paddingWidth * 2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: imagePosition == ImagePosition.left
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: [
                  _image!,
                  SizedBox(width: context.sizeWidth * 5),
                  Text(btnText!, style: Theme.of(context).textTheme.titleMedium)
                ],
              ),
            ),
          )
        : MaterialButton(
            onPressed: onPressed,
            color: btnColor,
            disabledColor: btnDisabledColor,
            elevation: elevation,
            padding: EdgeInsets.all(padding!),
            shape: const CircleBorder(),
            child: _image,
          );
  }

  void _createStyle(BuildContext context) {
    btnDisabledColor ??= Theme.of(context).disabledColor.withOpacity(0.12);
    btnDisabledTextColor ??= Theme.of(context).disabledColor.withOpacity(0.38);

    _image = Image.asset(
      image ?? 'assets/sign_icons/${buttonType.name}.png',
      width: _imageSize ?? context.sizeWidth * 20,
      height: _imageSize ?? context.sizeHeight * 20,
    );

    if (_disabled) {
      _image = ColorFiltered(
        colorFilter: const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0, // R1
          0.2126, 0.7152, 0.0722, 0, 0, // R2
          0.2126, 0.7152, 0.0722, 0, 0, // R3
          0, 0, 0, 1, 0, // R4
        ]),
        child: _image,
      );
    }

    switch (buttonType) {
      case ButtonType.facebook:
        btnText ??= 'Sign in with Facebook';
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF1877F2);
        break;

      case ButtonType.facebookDark:
        btnText ??= 'Sign in with Facebook';
        btnTextColor ??= Colors.white;
        btnColor ??= Colors.black;
        break;

      case ButtonType.github:
        btnText ??= 'Sign in with Github';
        btnTextColor ??= Colors.black87;
        btnColor ??= Colors.white;
        break;

      case ButtonType.githubDark:
        btnText ??= "Sign in with Github";
        btnTextColor ??= Colors.white70;
        btnColor ??= const Color(0xff212121);
        break;

      case ButtonType.pinterest:
        btnText ??= 'Sign in with Pinterest';
        btnTextColor ??= Colors.white;
        btnColor ??= Colors.redAccent;
        break;

      case ButtonType.apple:
        btnText ??= 'Sign in with Apple';
        btnTextColor ??= Colors.black;
        btnColor ??= const Color(0xfff7f7f7);
        break;

      case ButtonType.appleDark:
        btnText ??= 'Sign in with Apple';
        btnTextColor ??= Colors.white;
        btnColor ??= Colors.black;
        break;

      case ButtonType.twitter:
        btnText ??= 'Sign in with Twitter';
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF1DA1F2);
        break;

      case ButtonType.twitterX:
        btnText ??= 'Sign in with Twitter';
        btnTextColor ??= Colors.white;
        btnColor ??= Colors.black;
        break;

      case ButtonType.linkedin:
        btnText ??= 'Sign in with LinkedIn';
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF3282B8);
        break;

      case ButtonType.google:
        btnText ??= AppStrings.signInWithGoogle.tr(context);
        btnTextColor ??= Colors.black;
        btnColor ??= const Color(0xfff7f7f7);
        break;

      case ButtonType.googleDark:
        btnText ??= AppStrings.signInWithGoogle.tr(context);
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF4285F4);
        break;

      case ButtonType.youtube:
        btnText ??= 'Sign in with Youtube';
        btnTextColor ??= Colors.black;
        btnColor ??= Colors.white;
        break;

      case ButtonType.microsoft:
        btnText ??= 'Sign in with Microsoft';
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF2F2F2F);
        break;

      case ButtonType.tumblr:
        btnText ??= 'Sign in with Tumblr';
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF0F4C75);
        break;

      case ButtonType.mail:
        btnText ??= 'Sign in with Mail';
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF20639B);
        break;

      case ButtonType.reddit:
        btnText ??= 'Sign in with Reddit';
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFFC85417);
        break;

      case ButtonType.yahoo:
        btnText ??= 'Sign in with Yahoo';
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF7C5295);
        break;

      case ButtonType.adminzon:
        btnText ??= 'Sign in with adminzon';
        btnTextColor ??= Colors.black87;
        btnColor ??= Colors.white;
        break;

      case ButtonType.quora:
        btnText ??= 'Sign in with Quora';
        btnTextColor ??= Colors.black87;
        btnColor ??= Colors.white;
        break;

      case ButtonType.instagram:
        btnText ??= 'Sign in with Instagram';
        btnTextColor ??= Colors.black87;
        btnColor ??= Colors.white;
        break;

      case ButtonType.discord:
        btnText ??= "Sign in with Discord";
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF5865F2);
        break;

      case ButtonType.discordCircle:
        btnText ??= "Sign in with Discord";
        btnTextColor ??= Colors.white;
        btnColor ??= const Color(0xFF5865F2);
        break;

      case ButtonType.guest:
        btnText ??= AppStrings.signInAsGuest.tr(context);
        btnTextColor ??= Colors.black87;
        btnColor ??= Colors.white;
        break;
      case ButtonType.custom:
        btnText ??= "Custom Button";
        btnTextColor ??= Colors.black87;
        btnColor ??= Colors.white;
        break;
    }
  }
}
