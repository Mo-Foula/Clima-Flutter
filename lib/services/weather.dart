import 'package:clima/services/networkHelper.dart';
import 'package:clima/services/location.dart';

const apikey = 'ecc8d4504b60f85807f88f30aff1b021';
const WEATHERURL = "https://api.openweathermap.org/data/2.5/weather";

class WeatherModel {
  Future<dynamic> getLocationByCity(String city) async {
    NetworkHelper resp = NetworkHelper(
      '$WEATHERURL?q=$city&appid=$apikey&units=metric',
    );
    var decodeddata = await resp.getDate();
    return decodeddata;
  }

  Future<dynamic> getLocationWeather() async {
    Location L = Location();
    await L.getLocation();

//    http.Response response = await http.get(
//        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apikey');
//    print("HERE IT IS :   https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apikey");
//    Duration delay = Duration (seconds: 5);
//    sleep(delay);

    NetworkHelper resp = NetworkHelper(
        '$WEATHERURL?lat=${L.getLatitude()}&lon=${L.getLongitude()}&appid=$apikey&units=metric');
    var decodeddata = await resp.getDate();
    return decodeddata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
