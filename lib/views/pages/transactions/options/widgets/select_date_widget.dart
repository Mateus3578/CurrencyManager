import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SelectDateWidget extends StatefulWidget {
  final Function setDate;
  final Color mainColor;
  SelectDateWidget({required this.setDate, required this.mainColor});

  @override
  _SelectDateWidgetState createState() => _SelectDateWidgetState();
}

class _SelectDateWidgetState extends State<SelectDateWidget> {
  DateTime _date = DateTime.now();

  /// Abre um pop-up para escolher uma data
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _date) {
      _date = picked;
      widget.setDate(_date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Text("Data")]),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Dia atual
              GestureDetector(
                onTap: () {
                  setState(() {
                    _date = DateTime.now();
                    widget.setDate(_date);
                  });
                },
                child: Container(
                  decoration: _date.isSameDate(DateTime.now())
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: widget.mainColor,
                          border: Border.all(
                            color: widget.mainColor,
                            width: 4,
                          ),
                        )
                      : BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      "Hoje",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              // Dia atual -1
              GestureDetector(
                onTap: () {
                  setState(() {
                    _date = DateTime.now().subtract(Duration(days: 1));
                    widget.setDate(_date);
                  });
                },
                child: Container(
                  decoration: _date.isSameDate(
                          DateTime.now().subtract(Duration(days: 1)))
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: widget.mainColor,
                          border: Border.all(
                            color: widget.mainColor,
                            width: 4,
                          ),
                        )
                      : BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      "Ontem",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              // Escolher
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  decoration: !_date.isSameDate(DateTime.now()) &&
                          !_date.isSameDate(
                              DateTime.now().subtract(Duration(days: 1)))
                      ? BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          color: widget.mainColor,
                          border: Border.all(
                            color: widget.mainColor,
                            width: 4,
                          ),
                        )
                      : BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Text(
                      _date.isSameDate(DateTime.now()) ||
                              _date.isSameDate(
                                  DateTime.now().subtract(Duration(days: 1)))
                          ? "Selecionar"
                          : "${DateFormat("dd/MM/yyyy").format(_date)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Compara se duas datas são idênticas.
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}
