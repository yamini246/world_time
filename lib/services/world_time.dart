import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; //location name for the UI
  late String time;     //the time in that location
  late String flag;     //url to an asset flag icon
  late String url;      //location url for api endpoint
  late bool isDayTime;  //true or false if daytime or not
  late bool isEveningTime;//true or false if evening time or not
  bool isNightTime = false;  //true or false if nighttime or not


  WorldTime({ required this. location, required this.flag, required this.url});

  Future<void> getTime()  async{

    try {
      //make the request
      Response response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      String offset1 = data['utc_offset'].substring(4,6);


      //create DataTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset), minutes: int.parse(offset1)));

      //set the time property
      isDayTime = now.hour >= 6 && now.hour < 16 ;
      isEveningTime = now.hour >= 16 && now.hour < 21 ;
      isNightTime = now.hour >= 21 || now.hour < 6;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print ('caught error: $e');
      time = 'Could not get time data';
    }

  }

}

