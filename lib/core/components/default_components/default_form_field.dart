import 'package:admin/core/utils/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/locale/app_localizations.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_sizes.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType type;
  final void Function(String?)? onSave;
  final Function(String)? onChange;
  final Function()? onTap;
  final bool isPassword;
  final String? Function(String?)? validate;
  final String? label;
  final String? hint;
  final IconData? prefix;
  final IconData? suffix;
  final Function()? suffixPressed;
  final bool isClickable = true;
  final bool readOnly;
  final int maxLines;
  final double? radius;
  final Color? color;
  final Color? textColor;
  final Color? hintColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final List<TextInputFormatter>? inputFormatters;
  const DefaultTextFormField(
      {super.key,
      required this.controller,
      required this.type,
      this.onSave,
      this.onChange,
      this.onTap,
      this.validate,
      this.hint,
      this.label,
      this.prefix,
      this.suffix,
      this.readOnly = false,
      this.suffixPressed,
      this.isPassword = false,
      this.maxLines = 1,
      this.contentPadding,
      this.textColor,
      this.hintColor = AppColors.hintColor,
      this.color,
      this.backgroundColor,
      this.radius = 16,
      this.margin,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
  
    return TextFormField(
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      cursorColor: AppColors.primary,
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      onTapOutside: (event) => context.closeKeyboard(),
      enabled: isClickable,
      onSaved: onSave,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      readOnly: readOnly,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
          fontSize: context.font * 16,
          fontWeight: FontWeight.w400,
          color: textColor ?? AppColors.black),
      decoration: InputDecoration(
        fillColor: backgroundColor ?? AppColors.white,
        filled: backgroundColor != null,
        prefixIconColor: AppColors.black,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(radius!),
          borderSide:
              BorderSide(color: color != null ? color! : AppColors.lightGrey),
        ),
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(vertical: context.paddingHeight * 6),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(radius!),
          borderSide:
              BorderSide(color: color != null ? color! : AppColors.primary),
        ),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(radius!),
          borderSide:
              BorderSide(color: color != null ? color! : AppColors.lightGrey),
        ),
        labelText: label?.tr(context),
        labelStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: textColor ?? Theme.of(context).hintColor),
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: textColor ?? Theme.of(context).hintColor),
        hintText: hint?.translateWithNullSafetyString(context)??hint,
        floatingLabelStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).primaryColor),
        prefixIcon: prefix != null
            ? Icon(
                prefix,
                color: textColor ?? Theme.of(context).hintColor,
              )
            : null,
        suffixIcon: suffix != null
            ? GestureDetector(
                onTap: suffixPressed,
                child: Icon(
                  suffix,
                  color: textColor ?? Theme.of(context).hintColor,
          
                ),
              )
            : null,
      ),
    );
  }
}
