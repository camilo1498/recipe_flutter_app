import 'package:flutter/material.dart';

extension AppContextExt on BuildContext {
  // static final _md = 520;
  // static final _lg = 992;

  /// Retorna true si el ancho del dispositivo es inferior a 520
  bool get isMobile => MediaQuery.of(this).size.width < 520;
  // bool get isDesktop => MediaQuery.of(this).size.width >= _lg;
  // bool get isTablet {
  //   final size = MediaQuery.of(this).size;
  //   return size.width >= _md && size.width < _lg;
  // }

  /// Ancho total del dispositivo, pixeles logicos
  double get maxWidth => MediaQuery.of(this).size.width;

  /// Alto total del dispositivo, pixeles logicos
  double get maxHeight => MediaQuery.of(this).size.height;

  /// Usado en un sizebox que esta debajo de un SingleChildScrollView, para controlar la altura
  ///
  /// ej:
  /// ```dart
  /// SingleChildScrollView(
  ///   child: SizedBox(
  ///     width: context.maxWidth,
  ///     height: context.heightOnSingleChildSV,
  ///   ),
  /// ),
  /// ```
  double get heightOnSingleChildSV {
    final md = MediaQuery.of(this);
    return md.size.height - (md.padding.bottom + md.padding.top);
  }
}
