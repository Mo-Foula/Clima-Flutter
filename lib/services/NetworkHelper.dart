import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper{
  final String _url;
  NetworkHelper(this._url);


  Future getDate () async{


    http.Response res = await http.get(_url);
    if(res.statusCode == 200){
//      print(_url);
      return jsonDecode(res.body);
    }
    else{
      print("Respones is v : ");
      print(res.statusCode);
    }
  }
}