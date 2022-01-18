import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:traveller/notifications.dart';

import 'utils.dart';

class Dashboard extends StatefulWidget {
  final String data;
  const Dashboard(this.data);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<String?> getData() async {
    try {
      final Uri url = Uri.parse("https://haypex.com.ng/lp/genderRatio.php");
      final response = await get(url).timeout(const Duration(minutes: 2));
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = jsonDecode(widget.data.toString())["Result"];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: purple,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Notifications(),
                      ));
                },
                icon: Image.asset("assets/icons/notifications.png")),
            SizedBox(
              width: context.width(.05),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width(.04)),
          child: Column(
            children: [
              const Logotext(),
              Hspace(context.height(.03)),
              SizedBox(height: context.height(.4), child: PiChart(data)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ScrollPoints(Color(0xffff5733)),
                  Wspace(context.width(.01)),
                  Text("Male",
                      style: TextStyle(
                          color: const Color(0xffff5733),
                          fontWeight: FontWeight.w700,
                          fontSize: context.width(.04))),
                  Wspace(context.width(.05)),
                  const ScrollPoints(
                    Color(0xff581845),
                  ),
                  Wspace(context.width(.01)),
                  Text(
                    "Female",
                    style: TextStyle(
                        color: const Color(0xff581845),
                        fontWeight: FontWeight.w700,
                        fontSize: context.width(.04)),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class Kpi {
  String text;
  int value;
  int color;

  Kpi({required this.text, required this.value, required this.color});
}

class PiChart extends StatefulWidget {
  final List data;
  const PiChart(this.data);

  @override
  _PiChartState createState() => _PiChartState();
}

class _PiChartState extends State<PiChart> {
  int touchedIndex = 0;
  final List<int> colors = [
    0XFF581845,
    0XFFFF5733,
  ];
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
              pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              }),
              borderData: FlBorderData(
                show: false,
              ),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections(widget.data)),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(List data) {
    final List<PieChartSectionData> pies = [];

    for (var i = 0; i < data.length; i++) {
      pies.add(PieChartSectionData(
        color: Color(colors[i]),
        value: double.parse(data[i]["counter"].toString()),
        title: data[i]["counter"].toString(),
        radius: context.width(.3),
        titleStyle: TextStyle(
            fontSize: context.width(.03),
            fontWeight: FontWeight.w400,
            color: const Color(0xffffffff)),
      ));
    }
    return pies;
  }
}
