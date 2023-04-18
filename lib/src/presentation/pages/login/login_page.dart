import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/extensions/context_extension.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/app_icons_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/core/global/global_assets.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/presentation/pages/login/login_controller.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/buttons/button_widget.dart';
import 'package:receipt_app/src/presentation/widgets/decoration/textfield_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/inddicators/loading_indicator.dart';
import 'package:receipt_app/src/presentation/widgets/others/icon_widget.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';
import 'package:receipt_app/src/presentation/widgets/textfields/form_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      id: 'loading',
      builder: (ctrl) => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.w),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      150.verticalSpace,

                      /// title and fields
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: SizedBox(
                            width: context.maxWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// logo
                                Hero(
                                  tag: 'initial_logo',
                                  transitionOnUserGestures: true,
                                  child: Center(
                                    child: SizedBox(
                                      width: 450.w,
                                      height: 450.w,
                                      child: Image.asset(GlobalAssets.appLogo),
                                    ),
                                  ),
                                ),
                                150.verticalSpace,

                                /// title
                                TextWidget(
                                  'Inicio de sesión',
                                  font: AppFont.h1,
                                  textAlign: TextAlign.start,
                                ),
                                50.verticalSpace,

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
                                GetBuilder<LoginController>(
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
                                      keyboardType:
                                          TextInputType.visiblePassword,
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
                                          ? (_) => ctrl.onTapSignUpButton()
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      /// create account
                      Align(
                        alignment: Alignment.center,
                        child: AnimatedOnTapWidget(
                          onTap: ctrl.onTapSignUpButton,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: RichText(
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: '¿No tienes una cuenta?\n',
                                style: AppUtils.textStyle(
                                  font: AppFont.body,
                                  context: context,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Crear cuenta',
                                    style: AppUtils.textStyle(
                                      font: AppFont.bodyBold,
                                      context: context,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      40.verticalSpace,

                      /// sign in button
                      ButtonWidget(
                        width: context.maxWidth,
                        font: AppFont.bodyBold,
                        text: ctrl.loading ? 'INGRESANDO...' : 'Ingresar',
                        onTap: ctrl.onTapLoginButton,
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
      ),
    );
  }
}
