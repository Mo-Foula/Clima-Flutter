import 'package:geolocator/geolocator.dart';

class Location{
  double _latitude,_longitude;

  double getLatitude(){
    return _latitude;
  }

  double getLongitude(){
    return _longitude;
  }

  void getLocation() async {
    try{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      this._latitude = position.latitude;
      this._longitude= position.longitude;
//      print(position.latitude);
//      print(position);
    }
    catch(e){
      print(e);
    }
//    Future<Position> position2 =  Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

  }
}