import 'package:deliver/pages/home_page.dart';
import 'package:deliver/pages/login_page.dart';
import 'package:deliver/vehicle_tracking/brake_checker.dart';
import 'package:deliver/vehicle_tracking/speed_position.dart';
import 'package:deliver/vehicle_tracking/vehicle_params.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:geolocator/geolocator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

  Checker.addCustomIcon();
  Future<PermissionStatus> permissionStatus = NotificationPermissions.requestNotificationPermissions();
  await permissionStatus;
  AwesomeNotifications().initialize(null, [NotificationChannel(channelKey: "basic_channel", channelName: "basic_channel", channelDescription: "Basic channel")]);

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.unableToDetermine) {
    permission = await GeolocatorPlatform.instance.requestPermission();
  }


// make sure to initialize before map loading
  BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
      'assets/assets/marker.png')
      .then((d) {
    Checker.markericon = d;
  });


  Speedometer().initState();
  Speedometer().getSpeedUpdates();


  switch (permission) {
    case LocationPermission.deniedForever:
      runApp(const NoPermissionApp(hasCheckedPermissions: true));
      break;

    case LocationPermission.always:
    case LocationPermission.whileInUse:
      runApp(const MyApp());
      break;

    case LocationPermission.denied:
    case LocationPermission.unableToDetermine:
      runApp(const NoPermissionApp(hasCheckedPermissions: false));
  }
  runApp(const MyApp());
}
class Checker {
  static BrakeChecker brake_checker = BrakeChecker();
  static VehicleParams vehicle_params = VehicleParams();
  static BitmapDescriptor markericon = BitmapDescriptor.defaultMarker;
  static late Position pos;
  static Set<LatLng> positions = {};

  static void addCustomIcon() {
    if(markericon != null) return;
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/assets/marker.png")
        .then(
          (icon) {
        markericon = icon;

      },
    );
  }
}


class MyApp extends StatelessWidget {




  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
class NoPermissionApp extends StatelessWidget {
  const NoPermissionApp({
    Key? key,
    required bool hasCheckedPermissions,
  })  : _hasCheckedPermissions = hasCheckedPermissions,
        super(key: key);

  final bool _hasCheckedPermissions;

  @override
  Widget build(BuildContext context) {
    Widget outWidget;
    // Splash screen mode
    if (!_hasCheckedPermissions) {
      outWidget = Container(
        height: 20,

        width: 100,
        color: Colors.amber,
      );
    } else {
      outWidget = const Text(
        'Location permissions permanently denied!\n'
            'Please reinstall app and provide permissions!',
        style: TextStyle(
          color: Colors.red,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      );
    }
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: outWidget),
      ),
    );
  }
}
