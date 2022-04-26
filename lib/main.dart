import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class Sales {
  String year;
  int sales;
  Sales(this.year, this.sales);
}

class _State extends State<MyApp> {
  List<Sales> _data = [];
  List<charts.Series<Sales, String>> _chartdata = [];

  void _makeData() {
    _data = <Sales>[];
    _chartdata = <charts.Series<Sales, String>>[];

    final rnd = Random();
    for (int i = 2010; i < 2019; i++) {
      _data.add(Sales(i.toString(), rnd.nextInt(1000)));
    }

    _chartdata.add(charts.Series(
        id: 'Sales',
        //colorFn: (_,__) => charts.MaterialPalette.red.shadeDefault, //Old version
        colorFn: (Sales sales, __) => charts.MaterialPalette.red.shadeDefault,
        data: _data,
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        //fillPatternFn: (_,__) => charts.FillPatternType.forwardHatch, // Old version
        fillPatternFn: (Sales sales, __) => charts.FillPatternType.solid,
        displayName: 'sales'));
  }

  @override
  void initState() {
    _makeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Charts'),
      ),
      body: Container(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: <Widget>[
                const Text('Sales Data'),
                //new Expanded(child: new charts.BarChart<Sales>(_chartdata))
                Expanded(child: charts.BarChart(_chartdata)),
              ],
            ),
          )),
    );
  }
}
