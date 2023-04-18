import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';

class FormWidget extends StatelessWidget {
  const FormWidget(
      {Key? key,
      this.label,
      this.hint,
      this.formKey,
      this.style,
      this.hintStyle,
      this.errorStyle,
      this.bordeColor,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.controller,
      this.readOnly = false,
      this.enabled = true,
      this.suffixIcon,
      this.suffixText,
      this.obscureText = false,
      this.inputFormatters,
      this.autofillHints,
      this.isOutline = false,
      this.textAlign = TextAlign.start,
      this.contentPadding,
      this.maxLength,
      this.showCounter = true,
      this.textAlignVertical,
      this.suffixIconConstraints,
      this.onFieldSubmitted,
      this.onChanged,
      this.validator,
      this.onTap,
      this.inputAction = TextInputAction.done,
      this.maxLines = 1})
      : super(key: key);

  final String? label;
  final String? hint;
  final GlobalKey<FormState>? formKey;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final Color? bordeColor;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool readOnly;
  final bool enabled;
  final Widget? suffixIcon;
  final String? suffixText;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final Iterable<String>? autofillHints;
  final bool isOutline;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLength;
  final bool showCounter;
  final TextAlignVertical? textAlignVertical;
  final BoxConstraints? suffixIconConstraints;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final TextInputAction inputAction;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final defaultStyle = AppUtils.textStyle(
      context: context,
      font: enabled ? AppFont.formLabel : AppFont.bodyBold,
      color: enabled ? AppColor.blackHardness : AppColor.blackHardness50,
      size: enabled ? null : 14,
    );
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              focusNode: focusNode,
              readOnly: readOnly,
              enabled: enabled,
              style: style ?? defaultStyle,
              obscureText: obscureText,
              textAlign: textAlign,
              onChanged: onChanged,
              validator: validator,
              onTap: onTap,
              textInputAction: inputAction,
              onFieldSubmitted: onFieldSubmitted,
              inputFormatters: inputFormatters,
              autofillHints: autofillHints,
              maxLength: maxLength,
              minLines: 1,
              maxLines: maxLines,
              textAlignVertical: textAlignVertical,
              decoration: InputDecoration(
                counterText: showCounter ? null : '',
                contentPadding: contentPadding ?? EdgeInsets.all(10.w),
                labelText: label,
                isDense: false,
                labelStyle: AppUtils.textStyle(
                  context: context,
                  font: AppFont.formLabel,
                  color: AppColor.blackHardness,
                ),
                hintText: hint,
                hintStyle: hintStyle ??
                    AppUtils.textStyle(
                      context: context,
                      font: AppFont.formLabel,
                      color: AppColor.blackHardness50,
                    ),
                suffixText: suffixText,
                suffixIconConstraints: suffixIconConstraints,
                suffixStyle: AppUtils.textStyle(
                  context: context,
                  font: AppFont.formLabel,
                  color: AppColor.blackHardness,
                ),
                errorStyle: errorStyle ??
                    AppUtils.textStyle(
                      context: context,
                      font: AppFont.formLabel,
                      color: AppColor.redAlert,
                      size: 12,
                    ),
                errorMaxLines: 2,
                focusedBorder: isOutline
                    ? _outlineInputBorder(
                        color: AppColor.blackHardness,
                        width: 2,
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: bordeColor ?? AppColor.realBlack,
                          width: 2,
                        ),
                      ),
                focusedErrorBorder: isOutline
                    ? _outlineInputBorder(
                        color: bordeColor ?? AppColor.energy,
                        width: 2,
                      )
                    : null,
                errorBorder: isOutline
                    ? _outlineInputBorder(color: bordeColor ?? AppColor.energy)
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: bordeColor ?? AppColor.redAlert,
                          width: 1.3,
                        ),
                      ),
                enabledBorder: isOutline
                    ? _outlineInputBorder(
                        color: bordeColor ?? AppColor.blackHardness,
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: bordeColor ?? AppColor.blackHardness,
                          width: 1.3,
                        ),
                      ),
                disabledBorder: isOutline
                    ? _outlineInputBorder(
                        color: bordeColor ?? AppColor.blackHardness25,
                      )
                    : UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: bordeColor ?? AppColor.blackHardness25,
                          width: 1.3,
                        ),
                      ),
              ),
            ),
          ),
          if (suffixIcon != null) suffixIcon ?? const SizedBox(),
        ],
      ),
    );
  }
}

InputBorder _outlineInputBorder({
  Color color = const Color(0xFF000000),
  double width = 1.0,
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color, width: width),
  );
}
