import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:deliver/main.dart';
import 'package:deliver/pages/home_page.dart';
import 'package:deliver/pages/login_page.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';


class Speedometer_Params {
  double currentSpeed;
  int time10_30;
  int time30_10;
  int range;

  Speedometer_Params(
      {required this.currentSpeed,
        required this.time10_30,
        required this.time30_10,
        this.range = LESS_10});
}

const FROM_10_TO_30 = 1;
const FROM_30_TO_10 = 2;
const LESS_10 = 0;
const OVER_30 = 3;
const SPEED_10 = 10;
const SPEED_30 = 30;

class Speedometer{
  Speedometer_Params _speedometer =
  new Speedometer_Params(currentSpeed: 0, time10_30: 0, time30_10: 0);

  Speedometer_Params get speedometer => _speedometer;
  Stopwatch _stopwatch = Stopwatch();
  final Geolocator _geolocator = Geolocator();

  Future<void> updateSpeed(Position position) async {

    Checker.pos = position;
    double speed = (position.speed) * 3.6;
    _speedometer.currentSpeed = speed;
    Uri uri  = Uri.parse("http://192.168.1.81:4850/api/location");

    var data = jsonDecode(Checker.data);

    var response = await http.post(uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": data["_id"],
          "longitude": position.longitude,
          "latitude": position.latitude,
          "speed": speed.round(),

        }));
    Checker.vehicle_params.updateSpeed(speed.round(), DateTime.now().millisecondsSinceEpoch ~/ 1000);

    var brake = Checker.brake_checker.checkBrake();
    Checker.vehicle_params.setBrake(brake);

    if (speed >= SPEED_10 || speed <= SPEED_30) {
      checkSpeedAndMeasureTimeWhileInRange(speed);
    }
    if (speed < SPEED_10 || speed > SPEED_30) {
      checkSpeedAndMeasureTimeWhileOutOfRange(speed);
    }

  }

  //Method to get the vehicle speed updates
  getSpeedUpdates() async {

    LocationSettings options =
    LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 100);
    Geolocator.getPositionStream(locationSettings: options).listen((position) async {
      updateSpeed(position);
      print("LAT: ${position.latitude}");
      print("LONG: ${position.longitude}");
      print("ALT: ${position.altitude}");
      final path = await _localPath;



      Uri uri  = Uri.parse("http://192.168.1.81:4850/api/get/dailyRoute");

      var data = jsonDecode(Checker.data);

      var response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "id": data["_id"],

          }));
      var data2 = jsonDecode(response.body);
      print(data2["positionList"]);

      Checker.positions = {};
      Set.from(data2["positionList"].reversed).forEach((a) => Checker.positions.add(LatLng(a["latitude"], a["longitude"])));

    });

  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  void checkSpeedAndMeasureTimeWhileInRange(double vehicleSpeed) {
    if (vehicleSpeed >= SPEED_10) {
      //check if the vehicle speed was less than 10 KMH
      if (speedometer.range == LESS_10) {
        speedometer.range = FROM_10_TO_30;
        _stopwatch.start();
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
      }
      //check if the vehicle speed was in the range from 10 to 30
      else if (speedometer.range == FROM_10_TO_30) {
        //update the time on the screen accordingly (time10_30)
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
      }
    }

    if (vehicleSpeed <= SPEED_30) {
      //check if the vehicle speed was more than 30 KMH
      if (speedometer.range == OVER_30) {
        speedometer.range = FROM_30_TO_10;
        _stopwatch.start();
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
        //check if the vehicle speed from 30 to 10
      } else if (speedometer.range == FROM_30_TO_10) {
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
      }
    }
  }

  void checkSpeedAndMeasureTimeWhileOutOfRange(double vehicleSpeed) {
    //check if the vehicle speed is less than 10 KMH
    if (vehicleSpeed < SPEED_10) {
      //check if the vehicle speed was in the range from 30_10 KMH
      if (speedometer.range == FROM_30_TO_10) {
        speedometer.range = LESS_10;
        _stopwatch.stop();
        //update the time on the screen accordingly (time10_30)
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
        _stopwatch.reset();
      }
      //check if the vehicle speed was in the range from 10 to 30
      else if (speedometer.range == FROM_10_TO_30) {
        speedometer.range = LESS_10;
        //reset the stopwatch since the vehicle speed is Less than 10 KMH (Out Of ange)
        _stopwatch.reset();
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
      }
    }

    //check if the vehicle speed is more than 30 KMH
    if (vehicleSpeed > SPEED_30) {
      //check if the vehicle speed was in the range from 10_30 KMH
      if (speedometer.range == FROM_10_TO_30) {
        speedometer.range = OVER_30;
        _stopwatch.stop();
        //update the time on the screen accordingly (time10_30)
        speedometer.time10_30 = _stopwatch.elapsed.inSeconds;
        //reset the stopwatch since the vehicle speed is more than 30 KMH (Out Of ange)
        _stopwatch.reset();
      }
      //check if the vehicle speed was in the range from 30_10 KMH
      else if (speedometer.range == FROM_30_TO_10) {
        speedometer.range = OVER_30;
        //reset the stopwatch since the vehicle speed is more than 30 KMH (Out Of ange)
        _stopwatch.reset();
        speedometer.time30_10 = _stopwatch.elapsed.inSeconds;
      }
    }
  }

  GeolocatorPlatform locator = GeolocatorPlatform.instance;
  late StreamController<double?> _velocityUpdatedStreamController;
  // double mpstokmph(double mps) => mps * 18 / 5;
  double? _velocity;
  double? finalVelocity;
  double sumCurrDistance = 0;

  Position? _currentPosition;
  Position? _previousPosition;
  StreamSubscription<Position>? _positionStream;
  double _totalDistance = 0;
  double tempDistance = 0;

  List<Position> locations = <Position>[];
  List<Position> locationsOnlyForDrive = <Position>[];
  final LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.bestForNavigation,
    distanceFilter: 100,
  );

  Future _calculateDistance(bool isDriving) async {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) async {
      if ((await Geolocator.isLocationServiceEnabled())) {
        Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
          forceAndroidLocationManager: true,
        ).then((Position position) {

        }).catchError((err) {
          // print(err);
        });
      } else {
        print("GPS is off.");
      }
    });
  }

  void _onAccelerate(double speed) {
    locator.getCurrentPosition().then(
          (Position updatedPosition) {
        _velocity = (speed + updatedPosition.speed) / 2;
        if (_velocity! <= 0.09) {
          _velocity = 0.0;
        }
        finalVelocity = _velocity;

        _velocityUpdatedStreamController.add(finalVelocity);
      },
    );
  }



  @override
  void initState() {

    _velocityUpdatedStreamController = StreamController<double?>();
    locator
        .getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 2,
      ),
    )
        .listen(
          (Position position) {
        _onAccelerate(position.speed);
      },
    );
    _calculateDistance(false);
  }



}