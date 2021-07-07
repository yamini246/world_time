import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(location: 'Kolkata', flag: 'India.png', url: 'Asia/Kolkata'),
    WorldTime(location: 'London', flag: 'UK.png', url: 'Europe/London'),
    WorldTime(location: 'Athens', flag: 'Greece.png', url: 'Europe/Athens'),
    WorldTime(location: 'Cairo', flag: 'Egypt.png', url: 'Africa/Cairo'),
    WorldTime(location: 'Nairobi', flag: 'Kenya.png', url: 'Africa/Nairobi'),
    WorldTime(location: 'New York', flag: 'USA.png', url: 'America/New_York'),
    WorldTime(location: 'Seoul', flag: 'South-Korea.png', url: 'Asia/Seoul'),
    WorldTime(location: 'Jakarta', flag: 'Indonesia.png', url: 'Asia/Jakarta'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();

    //navigate to home screen
    Navigator.pop(context, {
      'location' : instance.location,
      'flag' : instance.flag,
      'time' : instance.time,
      'isDayTime' : instance.isDayTime,
      'isEveningTime' : instance.isEveningTime,
      'isNightTime' : instance.isNightTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
          itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/${locations[index].flag}'),
                ),
              ),
            ),
          );
          },
      ),

    );
  }
}
