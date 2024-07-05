import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:space_whisper_app/gen/assets.gen.dart';

class AppContentBar extends StatelessWidget {
  const AppContentBar({
    super.key,
    this.backCallback,
    this.customBackActive = false,
    this.rightWidget,
    this.title = "",
    this.titleWidget,
  });

  final Function? backCallback;
  // 是否是自己触发返回逻辑
  final bool customBackActive;

  final Widget? rightWidget;

  final String title;

  final Widget? titleWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      alignment: Alignment.bottomCenter,
      child: rightWidget != null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        backCallback?.call();
                        if (!customBackActive) {
                          context.router.popForced();
                        }
                      },
                      child: SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: Assets.icons.back.image(width: 24.w),
                      ),
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    getTitleWidget()
                  ],
                ),
                rightWidget as Widget,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        backCallback?.call();
                        if (!customBackActive) {
                          context.router.popForced();
                        }
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.w,
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: Assets.icons.back.image(width: 24.w),
                        ),
                      ),
                    ),
                    getTitleWidget()
                  ],
                )
              ],
            ),
    );
  }

  Widget getTitleWidget() {
    if (titleWidget != null) {
      return titleWidget as Widget;
    }
    return Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
