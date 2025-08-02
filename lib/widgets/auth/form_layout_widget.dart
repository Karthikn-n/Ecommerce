import 'package:flutter/material.dart';
import '../common/text_form_field_widget.dart';

class FormLayoutWidget extends StatelessWidget {
  final String title;
  final String? labelText;
  final String? hintText;
  final bool isObscure;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final int? maxLine;
  final FocusNode? focusNode;
  final bool? readOnly;
  final double? borderRadius;
  final VoidCallback? onEditingComplete;
  final Function(String value)? onChanged;
  final Function(String value)? onFieldSubmitted;
  final String? Function(String? value)? validator;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;
  final double? hintTextSize;
  final String? initialValue;
  final TextEditingController? controller;
  final VoidCallback? onSuffixIconPressed;
  final bool showLabel;
  final double labelSpacing;

  const FormLayoutWidget({
    super.key,
    required this.title,
    this.labelText,
    this.hintText,
    this.isObscure = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.maxLine = 1,
    this.focusNode,
    this.readOnly,
    this.borderRadius = 24.0,
    this.onEditingComplete,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.onTap,
    this.contentPadding,
    this.hintTextSize,
    this.initialValue,
    this.controller,
    this.onSuffixIconPressed,
    this.showLabel = true,
    this.labelSpacing = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText ?? title),
        SizedBox(height: labelSpacing,),
        TextFormFieldWidget(
          hintText: hintText,
          isObseure: isObscure,
          prefixIcon: prefixIcon,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          suffixIcon: suffixIcon,
          maxLine: maxLine,
          focusNode: focusNode,
          readOnly: readOnly,
          borderRadius: borderRadius,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          onTap: onTap,
          contentPadding: contentPadding,
          hintTextSize: hintTextSize,
          initalValue: initialValue,
          controller: controller,
        ),
      ],
    );
  }
}