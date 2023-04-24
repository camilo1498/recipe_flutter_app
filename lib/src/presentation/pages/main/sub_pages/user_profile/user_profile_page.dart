import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:receipt_app/src/core/extensions/context_extension.dart';
import 'package:receipt_app/src/core/global/app_colors_global.dart';
import 'package:receipt_app/src/core/global/global_app_font.dart';
import 'package:receipt_app/src/core/utils/app_utils.dart';
import 'package:receipt_app/src/presentation/pages/main/sub_pages/user_profile/userProfileController.dart';
import 'package:receipt_app/src/presentation/widgets/animations/animated_onTap_widget.dart';
import 'package:receipt_app/src/presentation/widgets/buttons/button_widget.dart';
import 'package:receipt_app/src/presentation/widgets/decoration/textfield_decoration.dart';
import 'package:receipt_app/src/presentation/widgets/text/text_widget.dart';
import 'package:receipt_app/src/presentation/widgets/textfields/form_widget.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
        id: 'profile_page',
        builder: (ctrl) => Scaffold(
              backgroundColor: AppColor.background,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            50.verticalSpace,

                            /// title
                            TextWidget(
                              'Perfil',
                              font: AppFont.h1,
                            ),
                            50.verticalSpace,

                            /// title
                            TextWidget(
                              'Nombres',
                              font: AppFont.captionBold,
                            ),
                            10.verticalSpace,

                            /// name field
                            TextFieldDecoration(
                              child: FormWidget(
                                enabled: ctrl.updateData,
                                focusNode: ctrl.nameNode,
                                controller: ctrl.nameCtrl,
                                bordeColor: Colors.transparent,
                                hint: 'Nombres',
                                errorStyle:
                                    const TextStyle(fontSize: 0, height: 0),
                                validator: (str) => ctrl.validateForm(str: str),
                                onChanged: (_) => ctrl.validateFields(),
                                onFieldSubmitted: (str) => ctrl.nextForm(
                                  current: ctrl.nameNode,
                                  next: ctrl.lastnameNode,
                                ),
                              ),
                            ),
                            30.verticalSpace,

                            /// title
                            TextWidget(
                              'Apellidos',
                              font: AppFont.captionBold,
                            ),
                            10.verticalSpace,

                            /// lastname field
                            TextFieldDecoration(
                              child: FormWidget(
                                enabled: ctrl.updateData,
                                focusNode: ctrl.lastnameNode,
                                controller: ctrl.lastnameCtrl,
                                bordeColor: Colors.transparent,
                                hint: 'Apellidos',
                                errorStyle:
                                    const TextStyle(fontSize: 0, height: 0),
                                validator: (str) => ctrl.validateForm(str: str),
                                onChanged: (_) => ctrl.validateFields(),
                                onFieldSubmitted: (str) => ctrl.nextForm(
                                  current: ctrl.lastnameNode,
                                  next: ctrl.emailNode,
                                ),
                              ),
                            ),
                            30.verticalSpace,

                            /// title
                            TextWidget(
                              'Correo',
                              font: AppFont.captionBold,
                            ),
                            10.verticalSpace,

                            /// email field
                            TextFieldDecoration(
                              child: FormWidget(
                                isOutline: false,
                                enabled: ctrl.updateData,
                                focusNode: ctrl.emailNode,
                                controller: ctrl.emailCtrl,
                                hint: 'Correo electrónico',
                                bordeColor: Colors.transparent,
                                inputFormatters: AppUtils.withoutSpaces,
                                keyboardType: TextInputType.emailAddress,
                                autofillHints: const [AutofillHints.email],
                                onFieldSubmitted: (_) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                inputAction: TextInputAction.next,
                                onChanged: (_) => ctrl.validateFields(),
                                validator: (str) => ctrl.validateForm(str: str),
                              ),
                            ),
                            30.verticalSpace,

                            /// title
                            TextWidget(
                              'Contraseña',
                              font: AppFont.captionBold,
                            ),
                            10.verticalSpace,

                            /// password field
                            AnimatedOnTapWidget(
                              onTap: ctrl.openPswSheet,
                              child: TextFieldDecoration(
                                  child: Container(
                                height: 100.h,
                                width: context.maxWidth,
                                alignment: Alignment.centerLeft,
                                child: TextWidget(
                                  'Cambiar contraseña',
                                  font: AppFont.body,
                                  color: AppColor.blackHardness50,
                                ),
                              )),
                            ),

                            30.verticalSpace,
                          ],
                        ),
                      ),
                      40.verticalSpace,

                      /// edit user info
                      if (!ctrl.loading)
                        ButtonWidget(
                          width: context.maxWidth,
                          font: AppFont.bodyBold,
                          text: ctrl.updateData ? 'Cancelar' : 'Editar datos',
                          background: AppColor.background,
                          borderColor: AppColor.energy,
                          textColor: AppColor.energy,
                          onTap: ctrl.onTapUpdateData,
                        ),
                      30.verticalSpace,

                      /// update data
                      if (!ctrl.loading && ctrl.updateData)
                        ButtonWidget(
                          width: context.maxWidth,
                          font: AppFont.bodyBold,
                          text: 'Actualizar datos',
                          onTap: ctrl.sendDataToBackend,
                        ),

                      /// logout
                      if (!ctrl.loading && !ctrl.updateData)
                        ButtonWidget(
                          width: context.maxWidth,
                          font: AppFont.bodyBold,
                          text: 'Cerrar sesión',
                          onTap: ctrl.logout,
                        ),
                      40.verticalSpace,
                    ],
                  ),
                ),
              ),
            ));
  }
}
