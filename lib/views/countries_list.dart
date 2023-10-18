import 'package:covid_19/services/states_servies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shimmer/shimmer.dart';

import 'details_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //MediaQuery...
    final Size size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    //
    StateServices stateServices = StateServices();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 33, 33, 33),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 33, 33, 33),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Search with country name',
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: stateServices.fetchCountriesStatesApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: [
                          ListTile(
                            title: Container(
                              height: height * 0.01,
                              width: width * 0.8,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              height: height * 0.01,
                              width: width * 0.8,
                              color: Colors.white,
                            ),
                            leading: Container(
                              height: height * 0.5,
                              width: width * 0.2,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    String name = snapshot.data![index]['country'];
                    if (searchController.text.isEmpty) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]
                                          ['cases'],
                                      totalRecovered: snapshot.data![index]
                                          ['recovered'],
                                      totalDeaths: snapshot.data![index]
                                          ['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                    ),
                                  ));
                            },
                            child: ListTile(
                              title: Text(
                                snapshot.data![index]['country'],
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases'].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Image(
                                  height: height * 0.05,
                                  width: width * 0.2,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                            ),
                          )
                        ],
                      );
                    } else if (name
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase())) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      image: snapshot.data![index]
                                          ['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCases: snapshot.data![index]
                                          ['cases'],
                                      totalRecovered: snapshot.data![index]
                                          ['recovered'],
                                      totalDeaths: snapshot.data![index]
                                          ['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]
                                          ['todayRecovered'],
                                      critical: snapshot.data![index]
                                          ['critical'],
                                    ),
                                  ));
                            },
                            child: ListTile(
                              title: Text(
                                snapshot.data![index]['country'],
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                snapshot.data![index]['cases'].toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Image(
                                  height: height * 0.05,
                                  width: width * 0.2,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              }
            },
          ))
        ],
      )),
    );
  }
}
