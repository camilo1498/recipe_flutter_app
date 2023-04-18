import 'package:flutter/material.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';

import '../../../core/global/app_colors_global.dart';
import '../animations/animated_loading.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.background,
    this.backgroundIndicatorColor,
    this.indicatorColor,
    this.indicatorContainerSize = 75,
    this.indicatorSize,
    this.padding = 20,
  }) : super(key: key);
  final Color? background;
  final Color? backgroundIndicatorColor;
  final Color? indicatorColor;
  final double indicatorContainerSize;
  final double? indicatorSize;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background ?? Colors.black.withOpacity(0.3),
      alignment: Alignment.center,
      child: Container(
        height: indicatorContainerSize,
        decoration: BoxDecoration(
          color: backgroundIndicatorColor ?? Colors.black,
          borderRadius: AppGlobalDecoration.globalRadius,
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: AnimatedLoadingWidget(
            size: indicatorSize ?? 30,
            color: indicatorColor ?? AppColor.energy,
          ),
        ),
      ),
    );
  }
}
