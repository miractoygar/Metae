import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';


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

  void updateSpeed(Position position) {
    double speed = (position.speed) * 3.6;
    _speedometer.currentSpeed = speed;

    if (speed >= SPEED_10 || speed <= SPEED_30) {
      checkSpeedAndMeasureTimeWhileInRange(speed);
    }
    if (speed < SPEED_10 || speed > SPEED_30) {
      checkSpeedAndMeasureTimeWhileOutOfRange(speed);
    }

    AwesomeNotifications().createNotification(content: NotificationContent(id: 10, channelKey: "basic_channel", title: "Hızınız:", body: speed.toString()));
    print("current speed is : " + speed.toString());
    print("time10_30 is : " + speedometer.time10_30.toString());
    print("time30_10 is : " + speedometer.time30_10.toString());

  }

  //Method to get the vehicle speed updates
  getSpeedUpdates() async {

    print("Lokasyon");
    LocationSettings options =
    LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 10);
    Geolocator.getPositionStream().listen((position) {
      updateSpeed(position);
    });

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