import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';

class CircularIndicator extends StatelessWidget {
  final int itemsLength;
  final int? indexSelected;
  const CircularIndicator({
    required this.itemsLength,
    this.indexSelected = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: double.infinity,
      child: Center(
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: itemsLength,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) => Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColor.whiteSnow),
            child: Container(
              height: 20.w,
              width: 20.w,
              decoration: BoxDecoration(
                  color: index == indexSelected
                      ? AppColor.energy
                      : AppColor.blackHardness.withOpacity(0.2),
                  shape: BoxShape.circle,
                  boxShadow: AppGlobalDecoration.globalShadow),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) =>
              15.horizontalSpace,
        ),
      ),
    );
  }
}
