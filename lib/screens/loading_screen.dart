import 'dart:io';

import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }
  Widget A = SpinKitFadingCircle(
    color: Colors.white,
    size: 100,
  );

  String city_name = "", description = "";
  double temp = 0;
  int id = 0;
  void getData() async {

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }

    var WeatherData = await WeatherModel().getLocationWeather();

    print(WeatherData);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        LocationWeather: WeatherData,
      );
    }));

    A = FloatingActionButton(
      onPressed: (){
        getData();
      },
      child: Text(
        'Try Again'
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: A,
      ),
    );
  }
}
/*
 body: Container(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  setState(() {
                    getData();
                  });
                  //Get the current location
                },
                child: Text('Get Location'),
              ),
              Text(
                city_name,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              Text(
                id.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                temp.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
 */
