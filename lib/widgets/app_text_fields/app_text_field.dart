import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indimobi/commons/app_colors.dart';
import 'package:indimobi/commons/app_style.dart';

class AppTextField extends StatelessWidget {
  final bool? isPass;
  final TextStyle? style;

  final TextInputType? inputType;
  final String? hintText;
  final Color? fillColor;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final Widget? suffixIcon;
  final Color? borderSideColor;
  final Function? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? textInputFormatter;
  final bool? enable;
  final bool? isDense;
  final int? maxLine;
  final int? minLine;
  final int? maxLength;
  final String? label;
  final TextInputAction? textInputAction;

  final Function(String)? onChange;

  final Color? borderColor;

  final double? widthBorderSide;
  final double? errBorderRadius;
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? paddingHo;
  final double? padSym;
  final bool? autoFocus;

  const AppTextField({
    Key? key,
    this.isPass = false,
    this.style,
    this.autoFocus,
    this.inputType,
    this.hintText,
    this.fillColor,
    this.hintStyle,
    this.prefixIcon,
    this.contentPadding,
    this.suffixIcon,
    this.borderSideColor,
    this.validator,
    required this.controller,
    this.textInputFormatter,
    this.borderRadius,
    this.width,
    this.height,
    this.maxLength,
    this.enable = true,
    this.isDense = false,
    this.errBorderRadius,
    this.maxLine = 1,
    this.minLine = 1,
    this.label,
    this.textInputAction,
    this.widthBorderSide,
    this.onChange,
    this.borderColor,
    this.paddingHo,
    this.padSym,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange ?? (text) {},
      enableInteractiveSelection: false,
      enabled: enable ?? true,
      controller: controller,
      autofocus: autoFocus ?? false,
      style: style ?? AppTextStyle.textSize_16,
      keyboardType: inputType,
      obscureText: isPass ?? false,
      cursorColor: AppColors.buttonDarkColor,
      maxLines: maxLine,
      minLines: minLine,
      textInputAction: textInputAction ?? TextInputAction.done,
      inputFormatters: textInputFormatter,
      keyboardAppearance: Brightness.light,
      maxLength: maxLength,
      decoration: InputDecoration(
        isDense: isDense ?? false,
        fillColor: fillColor ?? AppColors.subColor,
        alignLabelWithHint: false,
        filled: true,
        counterText: '',
        hintText: hintText,
        hintStyle: hintStyle ?? AppTextStyle.textSize_14,
        focusColor: AppColors.mainTextColor,
        enabledBorder: buildSetInputBorder(
          color: borderColor ?? Colors.transparent,
          borderRadius: borderRadius,
        ),
        disabledBorder: buildSetInputBorder(
          color: borderColor ?? AppColors.buttonColor,
          borderRadius: borderRadius,
        ),
        prefixIcon: prefixIcon,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              vertical: padSym ?? 0,
              horizontal: paddingHo ?? 15,
            ),
        suffixIcon: suffixIcon,
        focusedBorder: buildSetInputBorder(
          color: borderColor ?? AppColors.buttonColor,
          borderRadius: borderRadius,
        ),
        border: buildSetInputBorder(
          color: borderColor ?? AppColors.buttonColor,
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  buildSetInputBorder({Color? color, double? borderRadius}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: widthBorderSide ?? 1,
        color: color ?? AppColors.buttonColor,
        style: BorderStyle.solid,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(borderRadius ?? 0),
      ),
    );
  }
}
