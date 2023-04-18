class AppFont {
  AppFont({required this.family, required this.size});
  final String family;
  final double size;

  /// family OpenSans_Bold / size 26 / 19.5pt = 26px
  static AppFont superTitle = AppFont(family: 'OpenSans_Bold', size: 26);

  /// family OpenSans_SemiBold / size 24 / 18pt = 24px
  static AppFont h1 = AppFont(family: 'OpenSans_SemiBold', size: 24);
  static AppFont h1Italic =
      AppFont(family: 'OpenSans_SemiBoldItalic', size: 24);

  /// family OpenSans_SemiBold / size 18 / 13.5pt = 18px
  static AppFont h2 = AppFont(family: 'OpenSans_SemiBold', size: 18);

  /// family OpenSans_Medium / size 16 / 12pt = 16px
  static AppFont h3 = AppFont(family: 'OpenSans_Medium', size: 16);
  static AppFont h3Bold = AppFont(family: 'OpenSans_SemiBold', size: 16);

  /// family OpenSans_Medium / size 14 / 10.5pt = 14px
  static AppFont h4 = AppFont(family: 'OpenSans_Medium', size: 14);
  static AppFont h4Bold = AppFont(family: 'OpenSans_SemiBold', size: 14);

  /// family OpenSans_Medium / size 16 / 12pt = 16px
  static AppFont body = AppFont(family: 'OpenSans_Medium', size: 16);
  static AppFont bodyItalic =
      AppFont(family: 'OpenSans_MediumItalic', size: 16);

  /// family OpenSans_SemiBold / size 16 / 12pt = 16px
  static AppFont bodyBold = AppFont(family: 'OpenSans_SemiBold', size: 16);

  /// family OpenSans_SemiBold / size 14 / 10.5pt = 14px
  static AppFont subtleLinks = AppFont(family: 'OpenSans_SemiBold', size: 14);

  /// family OpenSans_Medium / size 14 / 10.5pt = 14px
  static AppFont formLabel = AppFont(family: 'OpenSans_Medium', size: 14);

  /// family OpenSans_SemiBold / size 10 / 7.5pt = 10px
  static AppFont supraLabelForm =
      AppFont(family: 'OpenSans_SemiBold', size: 10);

  /// family OpenSans_Medium / size 16 / 12pt = 16px
  static AppFont button = AppFont(family: 'OpenSans_Medium', size: 16);

  /// family OpenSans_Medium / size 12 / 9pt = 12px
  static AppFont caption = AppFont(family: 'OpenSans_Medium', size: 12);
  static AppFont captionBold = AppFont(family: 'OpenSans_SemiBold', size: 12);

  /// family OpenSans_Medium / size 12 / 9pt = 12px
  static AppFont complementaryTxt =
      AppFont(family: 'OpenSans_Medium', size: 12);

  /// family OpenSans_Medium / size 10 / 7.5pt = 10px
  static AppFont buttonLabelsm = AppFont(family: 'OpenSans_Medium', size: 10);
}
