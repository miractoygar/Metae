import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:deliver/vehicle_tracking/brake_checker.dart';
import 'package:deliver/vehicle_tracking/speed.dart';
import 'package:deliver/vehicle_tracking/vehicle_params.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:notification_permissions/notification_permissions.dart';


Future<void> main() async {


  //runApp(const NoPermissionApp(hasCheckedPermissions: false));
  WidgetsFlutterBinding.ensureInitialized();
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  print("PERM");
  print(isAllowed);
  Future<PermissionStatus> permissionStatus = NotificationPermissions.requestNotificationPermissions();
  await permissionStatus;
  AwesomeNotifications().initialize(null, [NotificationChannel(channelKey: "basic_channel", channelName: "basic_channel", channelDescription: "Basic channel")]);

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.unableToDetermine) {
    permission = await GeolocatorPlatform.instance.requestPermission();
  }

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



class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static BrakeChecker brake_checker = BrakeChecker();
  static VehicleParams vehicle_params = VehicleParams();

  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  static const LatLng sourceLocation = LatLng(41.045621, 28.871472);
  static const LatLng targetLocation = LatLng(41.039665, 28.881858);




  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: GoogleMap(initialCameraPosition: const CameraPosition(target: sourceLocation, zoom: 14.5), markers: {
        const Marker(
          markerId: MarkerId("source"),
          position: sourceLocation
        ),
        const Marker(
            markerId: MarkerId("target"),
            position: targetLocation
        )
      },),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );

  }

}
