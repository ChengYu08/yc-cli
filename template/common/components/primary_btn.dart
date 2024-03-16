import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/hex_color.dart';

class PrimaryBtn extends StatelessWidget {
  final String text;

  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;

  const PrimaryBtn(
      {super.key,
      required this.text,
      this.onTap,
      this.width,
      this.height,
      this.margin,
      this.backgroundColor,
      this.borderRadius,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width ?? 330.w,
        height: height ?? 44.w,
        margin: margin ?? EdgeInsets.only(top: 10.w, bottom: 19.5.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xffffd731),
          borderRadius: BorderRadius.circular(borderRadius ?? 5.w),
        ),
        child: Text(
          text.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize ?? 18.sp,
            fontWeight: fontWeight ?? FontWeight.bold,
          ),
        ),
      ),
      onTap: () async {
        onTap?.call();
      },
    );
  }
}

class GrayBtn extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  const GrayBtn({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: width ?? 355.w,
        height: height ?? 44.w,
        margin: margin ?? EdgeInsets.only(top: 10.w, bottom: 19.5.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffF2F3F5),
          borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
        ),
        child: Text(
          text.tr,
          style: TextStyle(
            fontSize: fontSize ?? 18.sp,
            fontWeight: fontWeight ?? FontWeight.bold,
            color: color ?? HexColor("#1A1A1A"),
          ),
        ),
      ),
      onTap: () async {
        onTap?.call();
      },
    );
  }
}

class SmallPrimaryBtn extends StatelessWidget {
  final String text;

  final VoidCallback onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const SmallPrimaryBtn({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width ?? 298.w,
        height: height ?? 38.w,
        margin: margin ?? EdgeInsets.only(top: 10.w, bottom: 19.5.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: HexColor("#FFD731"),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Text(
          text.tr,
          style: TextStyle(
            color: HexColor("#1A1A1A"),
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () async {
        onTap.call();
      },
    );
  }
}

class SmallSmsBtn extends StatelessWidget {
  final String text;

  final VoidCallback onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const SmallSmsBtn({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width ?? 298.w,
        height: height ?? 38.w,
        margin: margin ?? EdgeInsets.only(top: 10.w, bottom: 19.5.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffff6418)),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Text(
          text.tr,
          style: TextStyle(
            color: HexColor("#FF6418"),
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () async {
        onTap.call();
      },
    );
  }
}

class SmallHollowBtn extends StatelessWidget {
  final String text;

  final VoidCallback onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  const SmallHollowBtn({
    super.key,
    required this.text,
    required this.onTap,
    this.width,
    this.height,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: width ?? 298.w,
        height: height ?? 38.w,
        margin: margin ?? EdgeInsets.only(top: 10.w, bottom: 19.5.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: HexColor("#FFFFFF"),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: HexColor("#FF6519"),
          ),
        ),
        child: Text(
          text.tr,
          style: TextStyle(
            color: HexColor("#FF7C24"),
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onTap: () async {
        onTap.call();
      },
    );
  }
}
