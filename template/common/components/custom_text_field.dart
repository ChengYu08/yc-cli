import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final Function(String) onChange;
  final bool obscureText;
  final String hintText;
  final String value;
  final bool readOnly;
  final bool isNum;
  final bool isInteger;
  final TextInputFormatter? textInputFormatter;
  final TextInputType keyboardType;
  final int? maxLength;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextEditingController? textEditingController;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final TextAlign textAlign;
  final EdgeInsets? padding;

  const CustomTextField({
    super.key,
    required this.onChange,
    this.obscureText = false,
    this.hintText = '请输入',
    this.value = '',
    this.readOnly = false,
    this.isNum = false,
    this.isInteger = false,
    this.textInputFormatter,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.maxLines = 1,
    this.focusNode,
    this.textEditingController,
    this.textStyle,
    this.hintTextStyle,
    this.textAlign = TextAlign.start,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final ctr = TextEditingController(text: value);
    ctr.selection =
        TextSelection.fromPosition(TextPosition(offset: ctr.text.length));
    List<TextInputFormatter>? inputFormatters;
    if (textInputFormatter != null) {
      inputFormatters = <TextInputFormatter>[
        textInputFormatter!,
      ];
    } else {
      if (isNum) {
        inputFormatters = <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        ];
      } else if (isInteger) {
        inputFormatters = <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ];
      }
    }

    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 5.w),
      alignment: Alignment.center,
      color: Colors.transparent,
      child: TextField(
        maxLength: maxLength,
        keyboardType: keyboardType,
        readOnly: readOnly,
        controller: textEditingController ?? ctr,
        maxLines: maxLines,
        textAlign: textAlign,
        decoration: InputDecoration(
          counterText: '',
          hintText: hintText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          isDense: true,
          isCollapsed: false,
          hintStyle: hintTextStyle ??
              TextStyle(
                color: const Color(0xffadadad),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
        ),
        obscureText: obscureText,
        style: textStyle ??
            TextStyle(
              color: Colors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
        inputFormatters: inputFormatters,
        onChanged: (v) {
          onChange.call(v);
        },
      ),
    );
  }
}
