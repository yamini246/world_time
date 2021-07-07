import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

     data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
     print(data);


     //set background
     late String bgImage;

     if (data['isDayTime']) {
       bgImage = 'daytime.png';
     }

     else if (data['isEveningTime']) {
       bgImage = 'eveningtime.png';
     }

     else if (data['isNightTime']) {
       bgImage = 'nighttime.png';
     }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                onPressed: () async{
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time' : result['time'],
                      'location' : result['location'],
                      'flag' : result['flag'],
                      'isDayTime' : result['isDayTime'],
                      'isEveningTime' : result['isEveningTime'],
                      'isNightTime' : result['isNightTime'],
                    };
                  });
                },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                      fontSize: 28.0,
                      letterSpacing: 2.0
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 66.0
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
