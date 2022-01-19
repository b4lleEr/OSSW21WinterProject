import 'package:flutter/material.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/screens/weather_screen.dart';

const apikey = '676e01d45ac327688a46dd00bd633ad8';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double latitude3;
  double longitude3;

  @override
  void initState() {
    super.initState();
    getLocation();
    // fetchData();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longitude3 = myLocation.longitude2;

    print(latitude3);
    print(longitude3);

    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather'
            '?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric',
        'https://api.openweathermap.org/data/2.5/air_pollution'
            '?lat=$latitude3&lon=$longitude3&appid=$apikey&units=metric');

    var weatherData = await network.getJsonData();
    //print(weatherData);

    var airData = await network.getAirData();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return weatherScreen(
        parseWeatherData: weatherData,
        parseAirPollution: airData,
      );
    }));
  }

/*   void fetchData() async {
    
          
          var weatherJson = parsingData['weather'][0]['description'];
          var windJson = parsingData['wind']['speed'];
          var idJson = parsingData['id'];
         
          print(weatherJson);
          print(windJson);
          print(idJson);
        } else print(response.statusCode);
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getLocation();
          },
          style: ElevatedButton.styleFrom(primary: Colors.orangeAccent),
          child: Text(
            'Get my location',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
