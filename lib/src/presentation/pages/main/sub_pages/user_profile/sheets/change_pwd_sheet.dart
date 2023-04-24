import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/extensions/context_extension.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_global_decoration.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/user_profile/userProfileController.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/buttons/button_widget.dart';
import 'package:receipt_app/src/presentation/widgets/decoration/textfield_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/others/icon_widget.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';
import 'package:receipt_app/src/presentation/widgets/textfields/form_widget.dart';

class ChangePwdSheet extends StatelessWidget {
  const ChangePwdSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      id: 'hide',
      builder: (ctrl) => Container(
        padding: EdgeInsets.symmetric(horizontal: 80.w, vertical: 50.h),
        decoration: BoxDecoration(
          color: AppColor.whiteSnow,
          boxShadow: AppGlobalDecoration.globalShadow,
          borderRadius: AppGlobalDecoration.globalRadiusOnlyTop,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// drag indidicator
              Center(
                child: Container(
                  width: 200.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                      borderRadius: AppGlobalDecoration.globalRadius,
                      color: AppColor.blackHardness25),
                ),
              ),
              50.verticalSpace,

              /// title
              TextWidget(
                'Nueva contraseña',
                font: AppFont.h1,
                color: AppColor.blackHardness,
              ),
              30.verticalSpace,

              TextFieldDecoration(
                child: FormWidget(
                  isOutline: false,
                  hint: 'Contraseña',
                  controller: ctrl.pswCtrl,
                  obscureText: ctrl.hidePassword,
                  bordeColor: Colors.transparent,
                  inputAction: TextInputAction.done,
                  inputFormatters: AppUtils.withoutSpaces,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: AnimatedOnTapWidget(
                    onTap: ctrl.onTapShowPassword,
                    child: IconWidget(
                      ctrl.hidePassword ? AppIcon.show : AppIcon.hide,
                      color: AppColor.blackHardness,
                    ),
                  ),
                  onChanged: (_) => ctrl.validateFields(),
                  validator: (str) => ctrl.validateForm(
                    str: str,
                    isPassword: true,
                  ),
                ),
              ),
              40.verticalSpace,
              ButtonWidget(
                text: 'Actualizar',
                enable: !ctrl.loading,
                width: context.maxWidth,
                onTap: ctrl.updatePassword,
                background: AppColor.energy,
                textColor: AppColor.whiteSnow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
