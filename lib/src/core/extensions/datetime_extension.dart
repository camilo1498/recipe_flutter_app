import 'package:intl/intl.dart';

extension AppDatetimeExt on DateTime {
  /// Retorna el mes eje: Enero, Febrero,...etc
  String get formatMonth => DateFormat.MMMM('es_CO').format(this);

  /// Formatea para Mostrar solo la dia de la fecha
  ///
  /// Eje: 1/10/2021 => **viernes**
  String get formatWeekDay => DateFormat.EEEE('es').format(this);

  /// Formatea para Mostrar solo el dia de la fecha
  ///
  /// Eje: 1/10/2021 => **1**
  String get formatDay => DateFormat.d('es').format(this);

  /// Formatea para Mostrar solo el año de la fecha
  ///
  /// Eje: 1/10/2021 => **2021**
  String get formatYear => DateFormat.y('es').format(this);

  /// Formatea para Mostrar solo el mes de la fecha
  ///
  /// Eje: 1/10/2021 => **oct**
  String get formatMonth2 => DateFormat.MMM('es').format(this);

  /// Formatea para Mostrar dia de la semana,dia,mes,año de la fecha
  ///
  /// Eje: 1/10/2021 => **vie., 1 oct 2021**
  String get formatFullDate => DateFormat.yMMMEd('es').format(this);

  /// Formatea para Mostrar dia de la semana,dia,mes,año,hora de la fecha
  ///
  /// Eje: 1/10/2021 => **vie., 1 oct 2021 06:30 p.m**
  String get formatFullDate2 {
    final date = DateFormat.yMMMEd('es').format(this);
    final hour = DateFormat.jm().format(this);
    return '$date $hour';
  }

  /// Formatea para Mostrar dia,mes,año de la fecha
  ///
  /// Eje: 1/10/2021 => **1 oct. 2021**
  String get formatDate => DateFormat.yMMMd('es').format(this);

  /// Formatea para Mostrar dia,mes,año de la fecha
  ///
  /// Eje: 1/10/2021 => **1/10/2021**
  String get formatDateOnlyNumber => DateFormat.yMd('es').format(this);

  /// Formatea para Mostrar año,mes,dia de la fecha
  ///
  /// Eje: 1/9/2021 => **2021-09-01**
  String get formatDateOnlyNumber2 {
    final year = '${this.year}'.padLeft(4, '0');
    final month = '${this.month}'.padLeft(2, '0');
    final day = '${this.day}'.padLeft(2, '0');
    return "$year-$month-$day";
  }

  /// Formatea para Mostrar dia,mes,año de la fecha
  ///
  /// Eje: 1/9/2021 => **01-09-2021**
  String get formatDateOnlyNumber3 {
    final year = '${this.year}'.padLeft(4, '0');
    final month = '${this.month}'.padLeft(2, '0');
    final day = '${this.day}'.padLeft(2, '0');
    return "$day-$month-$year";
  }

  /// Formato tipo 12h y muestra hora, minutos am/pm
  ///
  /// Eje: "9999-12-31 18:30:00 => **06:30 p.m**
  // String get formatHour => DateFormat("KK:mm a", 'es').format(this);
  String get formatHour => DateFormat.jm().format(this);

  /// Formato tipo 12h y muestra hora, minutos
  ///
  /// Eje: "9999-12-31 18:30:00 => **06:30**
  String get formatHour2 => DateFormat("KK:mm").format(this);

  /// Formato tipo 12h y muestra am/pm
  ///
  /// Eje: "9999-12-31 18:30:00 => **PM**
  String get formatHour3 => DateFormat("a").format(this);
}
