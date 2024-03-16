import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import '../components/primary_btn.dart';
import 'hex_color.dart';

class AppToast {
  static show(String msg) {
    return BotToast.showText(
      text: msg.tr,
      textStyle: TextStyle(fontSize: 14.sp, color: Colors.white),
      align: const Alignment(0, 0),
    );
  }

  static showLoading() {
    return BotToast.showLoading();
  }

  // 关闭所有loading
  static closeAllLoading() {
    BotToast.closeAllLoading();
  }

  static showPermissionDialog(Widget child) {
    SmartDialog.show(
      builder: (_) {
        return Container(
          width: 0.7.sw,
          child: Column(
            children: [
              const Spacer(),
              child,
              Expanded(child: Container()),
            ],
          ),
        );
      },
      keepSingle: true,
      clickMaskDismiss: false,
    );
  }

  // 打开自定义弹窗
  static showLuckyBox(Widget child, Widget maskWidget,
      {bool? clickMaskDismiss = true}) {
    SmartDialog.show(
      builder: (_) {
        return child;
      },
      keepSingle: true,
      clickMaskDismiss: clickMaskDismiss,
      usePenetrate: false,
      maskWidget: maskWidget,
    );
  }

  /**
   *
   * 使用实例
      AppToast.dialog(
      Container(
      width: 100.w,
      height: 150.w,
      color: Colors.red,
      ),
      onClose：() {

      },
      onEnter: () {

      }
      );
   *
   */
  // 弹窗
  static dialog(
    Widget child, {
    Function? onClose,
    Function? onEnter,
    String title = "",
    bool showBtn = true,
    bool clickMaskDismiss = true,
    double? width,
  }) {
    showLuckyBox(
      clickMaskDismiss: clickMaskDismiss,
      Container(
        width: width ?? 0.8.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title.isNotEmpty)
              Text(
                title.tr,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(
              height: 5.h,
            ),
            child,
            SizedBox(
              height: 20.h,
            ),
            Visibility(
              visible: showBtn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GrayBtn(
                    width: 100.w,
                    height: 38.h,
                    text: "取消",
                    margin: EdgeInsets.zero,
                    onTap: () {
                      onClose?.call();
                      SmartDialog.dismiss();
                    },
                  ),
                  PrimaryBtn(
                    width: 100.w,
                    height: 38.h,
                    text: "确认",
                    margin: EdgeInsets.zero,
                    onTap: () {
                      onEnter?.call();
                      SmartDialog.dismiss();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.6),
      ),
    );
  }

  // 下方弹出窗口
  static void showBottomSheet(Widget child,
      {bool? isDismissible,
      double? height,
      Color? backgroundColor = Colors.white,
      bool? showHeaderBanner = false,
      String? title = '',
      Function()? dismissListen}) {
    Get.bottomSheet(
        Container(
          height: height ?? 0.6.sh,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.w),
                  topRight: Radius.circular(12.w))),
          child: Column(
            children: [
              Visibility(
                  visible: showHeaderBanner ?? false,
                  child: SizedBox(
                    height: 40.w,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(left: 40.w),
                          child: Text(
                            (title ?? '').tr,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp),
                          ),
                        )),
                        GestureDetector(
                          child: SizedBox(
                            width: 40.w,
                            height: 40.w,
                            child: Icon(
                              Icons.close,
                              size: 20.w,
                            ),
                          ),
                          onTap: () {
                            dismissListen?.call();
                            Get.back();
                          },
                        )
                      ],
                    ),
                  )),
              Expanded(child: child)
            ],
          ),
        ),
        isDismissible: isDismissible ?? true,
        clipBehavior: Clip.hardEdge,
        isScrollControlled: true);
  }

  ///操作提示弹窗 bottomSheet
  static void bottomSheetTips({
    required String title,
    required String content,
    required String cancleStr,
    required String submitStr,
    required Function()? cancleFun,
    required Function()? submitFun,
  }) {
    Get.bottomSheet(
      bottomSheetContainer(
          height: 0.25.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title.tr,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  )),
              Text(
                content.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  // leftBtn
                  Expanded(
                    child: GestureDetector(
                      onTap: cancleFun,
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFF25272B),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          cancleStr.tr,
                          style: TextStyle(
                            color: const Color(0xFF696972),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  // rightBtn
                  Expanded(
                    child: GestureDetector(
                      onTap: submitFun,
                      child: Container(
                        width: double.infinity,
                        height: 56.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF4B92),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Text(
                          submitStr.tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  static Widget bottomSheetContainer({
    double? height,
    Widget? child,
    EdgeInsetsGeometry? padding,
    Color? bgColor,
    bool isNeedBar = false,
    bool isPage = false,
    BorderRadius? border,
  }) {
    if (isNeedBar) {
      return Container(
        width: double.infinity,
        height: height ?? 0.5.sh,
        padding: padding ?? EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: Stack(
          children: [
            SizedBox(height: 4.w),
            child ?? Container(),
            Positioned(
              top: 5.w,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 36.w,
                  height: 4.w,
                  decoration: BoxDecoration(
                      color: const Color(0xff3B3D40),
                      borderRadius: BorderRadius.circular(3.r)),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      width: double.infinity,
      height: isPage ? double.infinity : (height ?? 0.5.sh),
      padding:
          padding ?? EdgeInsets.symmetric(vertical: 20.5.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: bgColor ?? Colors.white,
        borderRadius: border ??
            BorderRadius.only(
              topLeft: Radius.circular(15.r),
              topRight: Radius.circular(15.r),
            ),
      ),
      child: child ?? Container(),
    );
  }

  // 底部谈起的提升弹窗
  static showBottomTip({
    double? height,
    String? title,
    TextStyle? titleStyle,
    String? cancelTitle,
    Function? cancelTap,
    String? confirmTitle,
    Function? confirmTap,
    required Widget child,
  }) {
    return Get.bottomSheet(
      isScrollControlled: true,
      AppToast.bottomSheetContainer(
        height: height ?? 156.h,
        padding: EdgeInsets.fromLTRB(25.w, 5.h, 25.w, 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF3B3D40),
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (cancelTap != null) {
                        cancelTap.call();
                      } else {
                        Get.back();
                      }
                    },
                    child: Text(
                      (cancelTitle ?? "取消").tr,
                      style: TextStyle(
                        color: HexColor("#1A1A1A"),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    (title ?? "昵称").tr,
                    style: titleStyle ??
                        TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                    textAlign: TextAlign.center,
                    softWrap: false,
                  ),
                ),
                // 完成
                Expanded(
                  child: InkWell(
                      onTap: () async {
                        if (confirmTap != null) {
                          confirmTap.call();
                        } else {
                          Get.back();
                        }
                      },
                      child: Text(
                        (confirmTitle ?? "完成").tr,
                        style: TextStyle(
                          color: HexColor("#FF6418"),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.right,
                      )),
                ),
              ],
            ),
            child,
          ],
        ),
      ),
    );
  }
}
