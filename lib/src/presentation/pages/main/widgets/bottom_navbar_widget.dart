import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart' hide ContextExtensionss;
import 'package:receipt_app/src/core/extensions/context_extension.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({
    Key? key,
    this.selectItem = 0,
    this.background,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.animationDuration = const Duration(milliseconds: 500),
    this.itemMinHeight = 55,
    required this.items,
  })  : assert(items.length <= 5 && selectItem >= 0),
        super(key: key);

  final int selectItem;
  final Color? background;
  final MainAxisAlignment mainAxisAlignment;
  final Duration animationDuration;
  final double itemMinHeight;
  final List<BottomNavBarWidgetItem> items;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: BottomAppBar(
        color: background,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        notchMargin: 8.0,
        surfaceTintColor: Colors.transparent,
        padding: EdgeInsets.zero,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.verticalSpace,
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.maxWidth,
                ),
                child: Row(
                  mainAxisAlignment: mainAxisAlignment,
                  children: List.generate(
                    items.length,
                    (i) => Expanded(
                      child: AnimatedOnTapWidget(
                        onTap: () => items[i].onTap(i),
                        child: _ItemWidget(
                          item: items[i],
                          isSelected: i == selectItem,
                          animationDuration: animationDuration,
                          itemMinHeight: itemMinHeight,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// animated tap indicator
              Container(
                width: context.maxWidth,
                constraints: BoxConstraints(
                  maxWidth: context.isMobile
                      ? context.maxWidth
                      : context.maxWidth * .8,
                ),
                child: AnimatedAlign(
                  alignment: FractionalOffset(
                    (1 / (items.length - 1)) * selectItem,
                    1,
                  ),
                  duration: 800.milliseconds,
                  curve: const ElasticInOutCurve(0.5),
                  child: FractionallySizedBox(
                    widthFactor: 1 / items.length,
                    child: AnimatedContainer(
                      duration: 800.milliseconds,
                      height: context.isMobile ? 7 : 10,
                      width: context.isMobile ? 7 : 10,
                      decoration: const BoxDecoration(
                        color: AppColor.energy,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8)
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.animationDuration,
    required this.itemMinHeight,
  }) : super(key: key);

  final BottomNavBarWidgetItem item;
  final bool isSelected;
  final Duration animationDuration;
  final double itemMinHeight;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: itemMinHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? item.icon : item.inactiveIcon ?? item.icon,
              size: context.isMobile ? item.iconSize : item.iconSize + 5,
              color: isSelected ? item.activeColor : item.inactiveColor,
            ),
            if (item.title != null) const SizedBox(height: 2),
            if (item.title != null)
              TextWidget(
                item.title!,
                color:
                    isSelected ? AppColor.energy75 : AppColor.blackHardness50,
                font: AppFont.captionBold,
              ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBarWidgetItem {
  BottomNavBarWidgetItem({
    required this.icon,
    this.inactiveIcon,
    this.iconSize = 32,
    this.activeColor = AppColor.energy,
    this.inactiveColor = AppColor.blackHardness,
    this.isQr = false,
    this.title,
    required this.onTap,
  });

  final IconData icon;
  final IconData? inactiveIcon;
  final double iconSize;
  final Color activeColor;
  final Color? inactiveColor;
  final bool isQr;
  final String? title;
  final ValueChanged<int> onTap;
}
