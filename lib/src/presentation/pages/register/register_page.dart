import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/extensions/context_extension.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/core/global/global_assets.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/presentation/pages/register/register_controller.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/buttons/button_widget.dart';
import 'package:receipt_app/src/presentation/widgets/buttons/global_back_button.dart';
import 'package:receipt_app/src/presentation/widgets/decoration/textfield_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/inddicators/loading_indicator.dart';
import 'package:receipt_app/src/presentation/widgets/others/icon_widget.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';
import 'package:receipt_app/src/presentation/widgets/textfields/form_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      id: 'loading',
      builder: (ctrl) => Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80.w),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    50.verticalSpace,

                    /// title and fields
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: SizedBox(
                          width: context.maxWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// back button
                              GlobalBackButton(onClickButton: () => Get.back()),
                              50.verticalSpace,

                              /// logo
                              Hero(
                                tag: 'initial_logo',
                                transitionOnUserGestures: true,
                                child: Center(
                                  child: SizedBox(
                                    width: 350.w,
                                    height: 350.w,
                                    child: Image.asset(GlobalAssets.appLogo),
                                  ),
                                ),
                              ),
                              80.verticalSpace,

                              /// title
                              TextWidget(
                                '¡Soy nuevo!',
                                font: AppFont.h1,
                                textAlign: TextAlign.start,
                              ),
                              50.verticalSpace,

                              /// name field
                              TextFieldDecoration(
                                child: FormWidget(
                                  focusNode: ctrl.nameNode,
                                  controller: ctrl.nameCtrl,
                                  bordeColor: Colors.transparent,
                                  hint: 'Nombres',
                                  errorStyle:
                                      const TextStyle(fontSize: 0, height: 0),
                                  validator: (str) =>
                                      ctrl.validateForm(str: str),
                                  onChanged: (_) => ctrl.validateFields(),
                                  onFieldSubmitted: (str) => ctrl.nextForm(
                                    current: ctrl.nameNode,
                                    next: ctrl.lastnameNode,
                                  ),
                                ),
                              ),
                              30.verticalSpace,

                              /// lastname field
                              TextFieldDecoration(
                                child: FormWidget(
                                  focusNode: ctrl.lastnameNode,
                                  controller: ctrl.lastnameCtrl,
                                  bordeColor: Colors.transparent,
                                  hint: 'Apellidos',
                                  errorStyle:
                                      const TextStyle(fontSize: 0, height: 0),
                                  validator: (str) =>
                                      ctrl.validateForm(str: str),
                                  onChanged: (_) => ctrl.validateFields(),
                                  onFieldSubmitted: (str) => ctrl.nextForm(
                                    current: ctrl.lastnameNode,
                                    next: ctrl.emailNode,
                                  ),
                                ),
                              ),
                              30.verticalSpace,

                              /// email field
                              TextFieldDecoration(
                                child: FormWidget(
                                  isOutline: false,
                                  focusNode: ctrl.emailNode,
                                  controller: ctrl.emailCtrl,
                                  hint: 'Correo electrónico',
                                  bordeColor: Colors.transparent,
                                  inputFormatters: AppUtils.withoutSpaces,
                                  keyboardType: TextInputType.emailAddress,
                                  autofillHints: const [AutofillHints.email],
                                  onFieldSubmitted: (_) => ctrl.nextForm(
                                    current: ctrl.emailNode,
                                    next: ctrl.passwordNode,
                                  ),
                                  inputAction: TextInputAction.next,
                                  onChanged: (_) => ctrl.validateFields(),
                                  validator: (str) =>
                                      ctrl.validateForm(str: str),
                                ),
                              ),
                              30.verticalSpace,

                              /// password field
                              GetBuilder<RegisterController>(
                                id: 'hide',
                                builder: (ctrl) => TextFieldDecoration(
                                  child: FormWidget(
                                    isOutline: false,
                                    hint: 'Contraseña',
                                    focusNode: ctrl.passwordNode,
                                    controller: ctrl.passwordCtrl,
                                    obscureText: ctrl.hidePassword,
                                    bordeColor: Colors.transparent,
                                    inputAction: TextInputAction.done,
                                    inputFormatters: AppUtils.withoutSpaces,
                                    keyboardType: TextInputType.visiblePassword,
                                    suffixIcon: AnimatedOnTapWidget(
                                      onTap: ctrl.onTapShowPassword,
                                      child: IconWidget(
                                        ctrl.hidePassword
                                            ? AppIcon.show
                                            : AppIcon.hide,
                                        color: AppColor.blackHardness,
                                      ),
                                    ),
                                    onChanged: (_) => ctrl.validateFields(),
                                    validator: (str) => ctrl.validateForm(
                                      str: str,
                                      isPassword: true,
                                    ),
                                    onFieldSubmitted: ctrl.enableButton
                                        ? (_) => ctrl.onTapSignUp()
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    40.verticalSpace,

                    /// sign in button
                    ButtonWidget(
                      width: context.maxWidth,
                      font: AppFont.bodyBold,
                      text: ctrl.loading ? 'CREANDO...' : 'Crear Cuenta',
                      onTap: ctrl.onTapSignUp,
                    ),
                    100.verticalSpace
                  ],
                ),
              ),
            ),
            if (ctrl.loading) const LoadingIndicator()
          ],
        ),
      ),
    );
  }
}
