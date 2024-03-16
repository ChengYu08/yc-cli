import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FutureBtn extends StatefulWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Future Function() onTap;
  final Future Function()? onSuccess;
  final Future Function()? onFail;
  const FutureBtn({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.onSuccess,
    this.onFail,
    required this.onTap,
  });

  @override
  State<FutureBtn> createState() => _FutureBtnState();
}

class _FutureBtnState extends State<FutureBtn> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          child: IgnorePointer(child: widget.child),
          onTap: () async {
            try {
              setState(() {
                isLoading = true;
              });
              await widget.onTap();
              widget.onSuccess?.call();
              setState(() {
                isLoading = false;
              });
            } catch (e) {
              widget.onFail?.call();
              setState(() {
                isLoading = false;
              });
            }
          },
        ),
        if (isLoading)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: widget.width ?? 330.w,
              height: widget.height ?? 44.w,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 5.w),
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
