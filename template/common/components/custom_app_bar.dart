import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // 给定死高度
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
  final String title;
  final bool showBack;
  final Color backgroundColor;
  final Color titleColor;
  final Color backIconColor;
  final Function? onTapCustom;
  final String? pid;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget> actions;
  final Function? onTapBack;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.backgroundColor = Colors.transparent,
    this.titleColor = Colors.black,
    this.backIconColor = Colors.black,
    this.onTapCustom,
    this.pid,
    this.leading,
    this.leadingWidth,
    this.actions = const [],
    this.onTapBack,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> tapList = [];
    return AppBar(
      toolbarHeight: null,
      title: Text(
        title.tr,
        style: TextStyle(
          color: titleColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: backIconColor),
      leading: (showBack && leading == null)
          ? InkWell(
              child: Container(
                width: 30.w,
                height: 10.w,
                alignment: Alignment.center,
                // child: Assets.icon.pIconBack.image(width: 7.w),
              ),
              onTap: () {
                onTapBack?.call();
                Get.back();
              },
            )
          : leading ?? Container(),
      leadingWidth: leadingWidth ?? 30.w,
      actions: [...actions, ...tapList],
    );
  }
}
