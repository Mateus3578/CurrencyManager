import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:currency_manager/controllers/money_provider.dart';
import 'package:currency_manager/controllers/theme_provider.dart';

class MonthBalanceGraphs extends StatelessWidget {
  final ThemeProvider theme;
  final MoneyProvider money;
  const MonthBalanceGraphs({
    required this.theme,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    TooltipBehavior _tooltipBehavior = TooltipBehavior(
      enable: true,
      color: theme.iconColor,
      duration: 5000,
      header: "",
      textStyle: TextStyle(
        color: theme.textColor,
        fontSize: 15,
      ),
    );
    // Não tirar o container de dentro do container pq buga
    return Container(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.primaryColor,
        ),
        child: SfCartesianChart(
          title: ChartTitle(
            text: "Balanço mensal",
            alignment: ChartAlignment.center,
            textStyle: TextStyle(
              color: theme.iconColor,
              fontSize: 20,
            ),
          ),
          enableAxisAnimation: true,
          tooltipBehavior: _tooltipBehavior,
          primaryXAxis: CategoryAxis(
            arrangeByIndex: true,
            majorGridLines: MajorGridLines(color: theme.primaryColor),
            minorGridLines: MinorGridLines(color: theme.primaryColor),
            majorTickLines: MajorTickLines(color: theme.primaryColor),
            minorTickLines: MinorTickLines(color: theme.primaryColor),
            axisLine: AxisLine(color: theme.iconColor, width: 2),
            labelStyle: TextStyle(color: theme.iconColor, fontSize: 20),
          ),
          primaryYAxis: NumericAxis(
            isVisible: false,
            labelFormat: "R\$ {value}",
          ),
          /* Config para mostrar dados no y
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.simpleCurrency(locale: "pt-br"),
            majorGridLines: MajorGridLines(color: theme.primaryColor),
            minorGridLines: MinorGridLines(color: theme.primaryColor),
            majorTickLines: MajorTickLines(color: theme.primaryColor),
            minorTickLines: MinorTickLines(color: theme.primaryColor),
            axisLine: AxisLine(color: theme.iconColor, width: 2),
            labelStyle: TextStyle(color: theme.iconColor, fontSize: 15),
          ),
          */
          plotAreaBorderColor: theme.primaryColor,
          palette: <Color>[Colors.green, Colors.red],
          series: <ChartSeries<ChartData, String>>[
            ColumnSeries<ChartData, String>(
              dataSource: <ChartData>[
                ChartData("Receitas", money.revenues, Colors.green),
                ChartData("Despesas", money.expenses, Colors.red),
              ],
              xValueMapper: (ChartData model, _) => model.name,
              yValueMapper: (ChartData model, _) => model.value,
              pointColorMapper: (ChartData model, _) => model.color,
              enableTooltip: true,
              borderRadius: BorderRadius.circular(10),
              borderColor: theme.iconColor,
              borderWidth: 1,
              animationDuration: 3000,
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.name, this.value, this.color);
  final String name;
  final double? value;
  final Color color;
}
