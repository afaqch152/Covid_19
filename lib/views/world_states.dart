import 'package:covid_19/services/states_servies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'countries_list.dart';

class WorldStates extends StatefulWidget {
  const WorldStates({super.key});

  @override
  State<WorldStates> createState() => _WorldStatesState();
}

class _WorldStatesState extends State<WorldStates>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    //MediaQuery...
    final Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 38, 38),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            FutureBuilder(
              future: stateServices.fetchWorldStatesApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 100, top: 10),
                        child: Expanded(
                          flex: 2,
                          child: PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recorved": double.parse(
                                  snapshot.data!.recovered!.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths!.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            ringStrokeWidth: 15,
                            chartRadius: width * 3.2,
                            animationDuration: Duration(microseconds: 1200),
                            chartType: ChartType.ring,
                            legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left),
                            colorList: const [
                              Color(0xff4285F4),
                              Color(0xff1aa260),
                              Color(0xffde5246),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 1,
                        ),
                        child: Expanded(
                          flex: 1,
                          child: Card(
                            color: Color.fromARGB(255, 67, 65, 65),
                            child: Column(
                              children: [
                                ReuseableRow(
                                  value: snapshot.data!.cases.toString(),
                                  title: 'Total',
                                ),
                                ReuseableRow(
                                  value: snapshot.data!.deaths.toString(),
                                  title: 'Deaths',
                                ),
                                ReuseableRow(
                                  value: snapshot.data!.recovered.toString(),
                                  title: 'Recorved',
                                ),
                                ReuseableRow(
                                  value: snapshot.data!.active.toString(),
                                  title: 'Active',
                                ),
                                ReuseableRow(
                                  value: snapshot.data!.critical.toString(),
                                  title: 'Critical',
                                ),
                                ReuseableRow(
                                  value: snapshot.data!.todayDeaths.toString(),
                                  title: 'Today Deaths',
                                ),
                                ReuseableRow(
                                  value:
                                      snapshot.data!.todayRecovered.toString(),
                                  title: 'Today Recorved ',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesListScreen(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Expanded(
                            flex: 2,
                            child: Container(
                              height: height * 0.08,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text('Track Countries '),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: Color.fromARGB(255, 110, 107, 107),
          ),
        ],
      ),
    );
  }
}
