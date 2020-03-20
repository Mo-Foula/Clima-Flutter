import 'package:clima/services/NetworkHelper.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.LocationWeather});

  final LocationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String city_name, description, weatherIcon, weatherState;
  double temper = 0;
  int temp = 0, id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    print(widget.LocationWeather);
    UpdateUI(widget.LocationWeather);
  }

  void UpdateUI(dynamic decodeddata) {
    setState(() {
      if (decodeddata == null) {
        temp = 0;
        weatherIcon = 'Error';
        weatherState = 'Unable to get weather data';
        city_name = '';
        return;
      }
      city_name = decodeddata['name'];
      description = decodeddata['weather'][0]['description'];
      temper = (decodeddata['main']['temp']);
      temp = temper.toInt();
      id = decodeddata['weather'][0]['id'];

      WeatherModel W = WeatherModel();
      weatherIcon = W.getWeatherIcon(id);
      weatherState = W.getMessage(temp);
    });
    print(temp);
    print(city_name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var Weather = await WeatherModel().getLocationWeather();
                      UpdateUI(Weather);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      String  city = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );

                      print('City is $city');
                      if(city!=null){
                      var A = await WeatherModel().getLocationByCity(city);
                      print(A);
                      UpdateUI(A);

                      }

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherState in $city_name",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
      setState(() {
        city_name = decodeddata['name'];
        description = decodeddata['weather'][0]['description'];
        temp = decodeddata['main']['temp'];
        id = decodeddata['weather'][0]['id'];


        print(city_name);
        print(id);
        print(description);
        print(temp);
      });
 */
