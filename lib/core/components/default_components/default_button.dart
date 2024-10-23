import 'package:admin/config/locale/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../utils/app_sizes.dart';
import '/core/utils/app_colors.dart';

class DefaultButton extends StatelessWidget {
  final bool isUpperCase;
  final double width;
  final double? height;
  final double radius;
  final Color? background;
  final Color textColor;
  final Color? splashColor;
  final Color? disabledColor;
  final VoidCallback? onPressed; // voidCallback = void Function()
  final String? text;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final double? textScaleFactor;
  final double? elevation;
  final ButtonStyle? buttonStyle;
  final Color? borderColor;
  const DefaultButton({
    super.key,
    this.textColor = AppColors.white,
    required this.onPressed,
    this.text,
    this.width = double.infinity,
    this.isUpperCase = false,
    this.background,
    this.radius = 14,
    this.child,
    this.splashColor,
    this.padding,
    this.margin,
    this.borderColor,
    this.height,
    this.fontSize = 16,
    this.textScaleFactor,
    this.buttonStyle,
    this.elevation = 1,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      child: ElevatedButton(
          style: buttonStyle ??
              ButtonStyle(
                elevation: WidgetStateProperty.all(elevation),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        side: BorderSide(
                            color: borderColor ?? Colors.transparent),
                        borderRadius: BorderRadius.circular(radius))),
                backgroundColor: WidgetStateProperty.all<Color>(
                    background ?? Theme.of(context).primaryColor),
              ),
          onPressed: onPressed,
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(),
            child: (child != null && text != null)
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        isUpperCase ? text!.toUpperCase() : text!.tr(context),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            fontSize: context.font * fontSize!,
                            color: textColor),
                      ),
                      SizedBox(width: context.sizeWidth * 10),
                      child!
                    ],
                  )
                : child ??
                    Text(
                      isUpperCase ? text!.toUpperCase() : text!.tr(context),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: context.font * fontSize!,
                          color: textColor),
                    ),
          )),
    );
  }
}
