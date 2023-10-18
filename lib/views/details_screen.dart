import 'package:covid_19/views/world_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  dynamic totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;

  DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalCases,
    required this.totalDeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.totalRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    //MediaQuery...
    final Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 38, 38),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 40, 40, 40),
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, left: 10, right: 7),
                child: Card(
                  color: Color.fromARGB(255, 30, 28, 28),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * .06,
                      ),
                      ReuseableRow(
                          title: 'cases', value: widget.totalCases.toString()),
                      ReuseableRow(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString()),
                      ReuseableRow(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString()),
                      ReuseableRow(
                          title: 'Deaths',
                          value: widget.totalDeaths.toString()),
                      ReuseableRow(
                          title: 'Critical', value: widget.critical.toString()),
                      ReuseableRow(
                          title: 'Today Recovered',
                          value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              ClipOval(
                child: Image.network(
                  widget.image,
                  width: 100, // Avatar width
                  height: 100, // Avatar height
                  fit: BoxFit
                      .fill, // Scale and crop the image to cover the entire space
                ),
              )

              // CircleAvatar(
              //   radius: 50,
              //   backgroundImage: NetworkImage(widget.image),
              // )
            ],
          )
        ],
      ),
    );
  }
}
