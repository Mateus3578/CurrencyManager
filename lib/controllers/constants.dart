class Constants {
  /// Lista de meses em texto, em Português.
  ///
  /// Uso:
  ///```
  ///var now = new DateTime.now();
  ///String month = months[now.month];
  ///```
  ///
  ///Também é possível usar o format do DateTime (/intl.dart), que formata usando o locale, porém precisa de um novo import e uma função no initState:
  ///
  ///```
  ///import 'package:intl/intl.dart';
  ///import 'package:intl/date_symbol_data_local.dart';
  ///```
  ///
  ///```
  /// @override
  /// void initState() {
  ///   super.initState();
  ///   initializeDateFormatting("pt_BR", null);
  /// }
  ///```
  ///
  ///```
  ///String month = DateFormat.MMMM("pt_BR").format(date);
  ///```
  static final List months = [
    "",
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
  ];
}
