import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:deliver/main.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../constants/color.dart';
import '../constants/text_style.dart';
import '../data/model.dart';
import '../widget/custom_paint.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const LatLng sourceLocation5 = LatLng(41.045842, 28.870261);
  static const LatLng sourceLocation6 = LatLng(41.043590, 28.869245);
  static const LatLng sourceLocation7 = LatLng(41.041171, 28.871755);
  static const LatLng sourceLocation8 = LatLng(41.038452, 28.872689);
  static const LatLng sourceLocation9 = LatLng(41.039091, 28.877155);
  static const LatLng sourceLocation10 = LatLng(41.038169, 28.880892);
  static const LatLng sourceLocation11 = LatLng(41.039439, 28.881858);

  static const LatLng sourceLocation = LatLng(41.045621, 28.871472);
  static const LatLng sourceLocation2 = LatLng(41.04474414958876, 28.874816894531254);
  static const LatLng sourceLocation3 = LatLng(41.045334837833025, 28.874849081039432);
  static const LatLng sourceLocation4 = LatLng(41.04377314369311, 28.879805803298954);

  static const LatLng targetLocation = LatLng(41.039665, 28.881858);

  static String speed = "0";
   var spd = "0";

  List<LatLng> polylineCoordinates = [];
  void getPolyPoints() async{
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyCGH9tByJwVZhsKcwDomJhwr-UnhYrREfo", PointLatLng(sourceLocation.latitude, sourceLocation.latitude), PointLatLng(targetLocation.latitude, targetLocation.longitude));
    if(result.points.isNotEmpty){
      result.points.forEach((element) {
        polylineCoordinates.add(LatLng(element.latitude, element.longitude));
      });
    }
  }

  int sp3 = 0;
   static void setSpeed(spd2){
    speed = spd2;
   }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if(!test) testSpeed();

  }
   bool test = false;
   void testSpeed(){
     LocationSettings options =
     LocationSettings(accuracy: LocationAccuracy.high, distanceFilter: 0);
     Geolocator.getPositionStream(locationSettings: options).listen((position) {


     });
     test = true;
     const oneSec = Duration(milliseconds:300);
     var a = false;
     Timer.periodic(oneSec, (Timer t) => setState(() {

       try{
         mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(Checker.pos.latitude, Checker.pos.longitude), 14));

         setState(() {
           _markers.add(Marker(
               markerId: MarkerId("Live"),
               position: LatLng(Checker.pos.latitude, Checker.pos.longitude),
               icon: Checker.markericon
           ));
         });
       }catch(fn){

       }


       if(Checker.vehicle_params.last_speed >= 60){
         AwesomeNotifications().createNotification(content: NotificationContent(id: 10, channelKey: "basic_channel", title: "!", body: "أنت تسير بسرعة كبيرة، يرجى التباطؤ"));

         if(!popup){
           openDialog();
         }
       }else{
         if(popup){
           Navigator.of(alertcont).pop();
           popup = false;
         }
       }


       spd = '${Checker.vehicle_params.last_speed}';
     }));


   }

  @override
  void initState() {
    super.initState();
  }

  Set<Marker> _markers = {};
   CameraPosition cameraPosition = CameraPosition(target: sourceLocation, zoom: 14.5);

  int selectBtn = 0;
   late GoogleMapController mapController;
  @override
  Widget build(BuildContext context) {

  if(selectBtn == 4){
    return getServicePage(context);
  }
  if(selectBtn == 3){
    return getWarningPage(context);
  }
  if(selectBtn == 2){
    return getProfilePage(context);
  }
  if(selectBtn == 1){
    return getDrivePoint(context);
  }
  if(selectBtn == 0){
    return getHomePage();
  }

    return MaterialApp();

  }
  Widget getProfilePage(context){
    return MaterialApp(
        home: Scaffold(
          body: Container(
            color: Colors.grey[200],
              child:
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: MediaQuery.of(context).size.width - 50,
                    child: Stack(

                      children: [
                       Padding(padding: EdgeInsets.only(top: 30, left: 30),
                       child: Text("Tarik Mohammed", style: TextStyle(fontSize: 16),),),
                        Padding(padding: EdgeInsets.only(top: 50, left: 32),
                          child: Text("Customer ID: 8495965", style: TextStyle(fontSize: 11, color: Colors.grey),),),
                        Padding(padding: EdgeInsets.only(top: 16, left: MediaQuery.of(context).size.width - 125),
                          child:  Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: new BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage("https://webapps.knust.edu.gh/staff/assets/img/img_server.php?id=6189563")
                                  )
                              )),)

                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                    height: 80,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width - 50,

                    child: Stack(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 15, left: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width / 1.3)),
                          child: Text("Personal Information", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 50, left: 32),
                          child: Text("National ID: ", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 50, left: 115),
                          child: Text("894959846", style: TextStyle(fontSize: 14, color: Colors.black),),),
                        Padding(padding: EdgeInsets.only(top: 75, left: 32),
                          child: Text("Birthday: ", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 75, left: 100),
                          child: Text("2.10.1993", style: TextStyle(fontSize: 14, color: Colors.black),),),
                        Padding(padding: EdgeInsets.only(top: 100, left: 32),
                          child: Text("Contact Number: ", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 100, left: 150),
                          child: Text("+971508652367", style: TextStyle(fontSize: 14, color: Colors.black),),),

                      ],

                    ),
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 200),
                    height: 150,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width - 50,

                    child: Stack(
                      children: [
                                 Padding(padding: EdgeInsets.only(top: 15, left: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width / 1.4)),
                          child: Text("Car Information", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 50, left: 32),
                          child: Text("Model: ", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 50, left: 90),
                          child: Text("Ford", style: TextStyle(fontSize: 14, color: Colors.black),),),
                        Padding(padding: EdgeInsets.only(top: 75, left: 32),
                          child: Text("Plate: ", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 75, left: 90),
                          child: Text("687645", style: TextStyle(fontSize: 14, color: Colors.black),),),
                        Padding(padding: EdgeInsets.only(top: 100, left: 32),
                          child: Text("Production Year: ", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 100, left: 150),
                          child: Text("2024", style: TextStyle(fontSize: 14, color: Colors.black),),),

                      ],

                    ),
                    margin: EdgeInsets.only(top: 400, left: 30, right: 30),
                    height: 150,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: navigationBar(),
                  )
                ],
              )
          )

          ,
        )

    );
  }
  Widget getServicePage(context){
    return MaterialApp(
        home: Scaffold(
          body: Container(
              color: Colors.grey[200],
              child:
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: MediaQuery.of(context).size.width - 50,
                    child: Stack(

                      children: [
                        Padding(padding: EdgeInsets.only(top: 30, left: 30),
                          child: Text("Tarik Mohammed", style: TextStyle(fontSize: 16),),),
                        Padding(padding: EdgeInsets.only(top: 50, left: 32),
                          child: Text("Customer ID: 8495965", style: TextStyle(fontSize: 11, color: Colors.grey),),),
                        Padding(padding: EdgeInsets.only(top: 16, left: MediaQuery.of(context).size.width - 125),
                          child:  Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: new BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage("https://webapps.knust.edu.gh/staff/assets/img/img_server.php?id=6189563")
                                  )
                              )),)

                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                    height: 80,
                  ),
                  Padding(padding: EdgeInsets.only(top: 180, left: 130),
                    child: Text("Vehicle Maintence ", style: TextStyle(fontSize: 18, color: Colors.black),),),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width - 50,

                    child: Stack(
                      children: [
                         Padding(padding: EdgeInsets.only(top: 15, left: 32),
                          child: Text("Date: ", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 15, left: 70),
                          child: Text("15.01.2024", style: TextStyle(fontSize: 14, color: Colors.black),),),
                        Padding(padding: EdgeInsets.only(top: 40, left: 32),
                          child: Text("Vehicle Kilometer: ", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 40, left: 160),
                          child: Text("178.257km", style: TextStyle(fontSize: 14, color: Colors.black),),),
                        Padding(padding: EdgeInsets.only(top: 65, left: 32),
                          child: Text("Maintence Cost: ", style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),),
                        Padding(padding: EdgeInsets.only(top: 65, left: 150),
                          child: Text("1857 AED", style: TextStyle(fontSize: 14, color: Colors.black),),),
                        Container(
                          margin: EdgeInsets.only(top: 95, left: 260),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(23)),
                            color: Color.fromRGBO(108, 202, 222, 1),
                          ),
                          child: Text("Inovice", style: TextStyle(fontSize: 12, color: Colors.white), textAlign: TextAlign.center,),
                          width: 60,
                          height: 20,




                        )
                      ],

                    ),
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 220),
                    height: 125,
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: navigationBar(),
                  )
                ],
              )
          )

          ,
        )

    );
  }

  Widget getWarningPage(context){
    return MaterialApp(
        home: Scaffold(
          body: Container(
              color: Colors.grey[200],
              child:
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: MediaQuery.of(context).size.width - 50,
                    child: Stack(

                      children: [
                        Padding(padding: EdgeInsets.only(top: 30, left: 30),
                          child: Text("Tarik Mohammed", style: TextStyle(fontSize: 16),),),
                        Padding(padding: EdgeInsets.only(top: 50, left: 32),
                          child: Text("Customer ID: 8495965", style: TextStyle(fontSize: 11, color: Colors.grey),),),
                        Padding(padding: EdgeInsets.only(top: 16, left: MediaQuery.of(context).size.width - 125),
                          child:  Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: new BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage("https://webapps.knust.edu.gh/staff/assets/img/img_server.php?id=6189563")
                                  )
                              )),)

                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                    height: 80,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: MediaQuery.of(context).size.width - 50,
                    child: Stack(

                      children: [
                        Padding(padding: EdgeInsets.only(top: 6, left: 10),
                          child:  Image.asset("assets/assets/warning.png", color: Colors.white, height: 48, width: 48,)),
                        Padding(padding: EdgeInsets.only(top: 12, left: 60),
                          child: Text("You exceeded the speed limit.", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),),
                        Padding(padding: EdgeInsets.only(top: 45, left: 170),
                          child: Text("00:21 27.01.2024", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),),),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 60, vertical: 210),
                    height: 70,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: MediaQuery.of(context).size.width - 50,
                    child: Stack(

                      children: [
                        Padding(padding: EdgeInsets.only(top: 6, left: 10),
                            child:  Image.asset("assets/assets/warning.png", color: Colors.white, height: 48, width: 48,)),
                        Padding(padding: EdgeInsets.only(top: 12, left: 60),
                          child: Text("You made a sudden brake.", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),),
                        Padding(padding: EdgeInsets.only(top: 45, left: 170),
                          child: Text("23:56 26.01.2024", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),),),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 60, vertical: 300),
                    height: 70,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: MediaQuery.of(context).size.width - 50,
                    child: Stack(

                      children: [
                        Padding(padding: EdgeInsets.only(top: 6, left: 10),
                            child:  Image.asset("assets/assets/warning.png", color: Colors.white, height: 48, width: 48,)),
                        Padding(padding: EdgeInsets.only(top: 12, left: 60),
                          child: Text("You exceeded the speed limit.", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),),
                        Padding(padding: EdgeInsets.only(top: 45, left: 170),
                          child: Text("23:38 26.01.2024", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),),),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 60, right: 60, top: 390),
                    height: 70,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: MediaQuery.of(context).size.width - 50,
                    child: Stack(

                      children: [
                        Padding(padding: EdgeInsets.only(top: 6, left: 10),
                            child:  Image.asset("assets/assets/warning.png", color: Colors.white, height: 48, width: 48,)),
                        Padding(padding: EdgeInsets.only(top: 12, left: 60),
                          child: Text("You used the phone while in motion.", style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500),),),
                        Padding(padding: EdgeInsets.only(top: 45, left: 170),
                          child: Text("22:57 26.01.2024", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),),),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 60, right: 60, top: 480),
                    height: 70,
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: navigationBar(),
                  )
                ],
              )
          )

          ,
        )

    );
  }

  Widget getDrivePoint(context){
    return MaterialApp(
        home: Scaffold(
          body: Container(
              color: Colors.grey[200],
              child:
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: MediaQuery.of(context).size.width - 50,
                    child: Stack(

                      children: [
                        Padding(padding: EdgeInsets.only(top: 30, left: 30),
                          child: Text("Tarik Mohammed", style: TextStyle(fontSize: 16),),),
                        Padding(padding: EdgeInsets.only(top: 50, left: 32),
                          child: Text("Customer ID: 8495965", style: TextStyle(fontSize: 11, color: Colors.grey),),),
                        Padding(padding: EdgeInsets.only(top: 16, left: MediaQuery.of(context).size.width - 125),
                          child:  Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: new BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage("https://webapps.knust.edu.gh/staff/assets/img/img_server.php?id=6189563")
                                  )
                              )),)

                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                    height: 80,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 180),
                    child: Image.network("https://freesvg.org/img/Arnoud999_Right_or_wrong_2.png", height: 64, width: 64,),
                    alignment: Alignment.topCenter,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 250),
                    child: Text("Drive Performance", style: TextStyle(fontSize: 18),),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 275),
                    child: Text("%74", style: TextStyle(fontSize: 18),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: MediaQuery.of(context).size.width - 50,
                    child: Stack(

                      children: [

                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 320),
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: ((MediaQuery.of(context).size.width - 50) / 100) * 74 ,
                    child: Stack(

                      children: [

                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 320),
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: (MediaQuery.of(context).size.width - 50),
                    child: Stack(

                      children: [

                      ],
                    ),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 400),
                    height: 1,
                  ),
                  Container(
                    child: Image.asset("assets/assets/1581914.png", height: 48, width: 48,),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 408.5),
                  ),
                  Container(
                    child: Text("Brake Acceleration", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    margin: EdgeInsets.only(left: 90, right: 30, top: 404.5),
                  ),
                  Container(
                    child: Text("4", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                    margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width - 50), right: 30, top: 435),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: (MediaQuery.of(context).size.width - 50),
                    child: Stack(

                      children: [

                      ],
                    ),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 465),
                    height: 1,
                  ),
                  Container(
                    child: Image.asset("assets/assets/4879579.png", height: 48, width: 48,),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 473.5),
                  ),
                  Container(
                    child: Text("Speed Acceleration", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    margin: EdgeInsets.only(left: 90, right: 30, top: 469.5),
                  ),
                  Container(
                    child: Text("2", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                    margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width - 50), right: 30, top: 500),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: (MediaQuery.of(context).size.width - 50),
                    child: Stack(

                      children: [

                      ],
                    ),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 530),
                    height: 1,
                  ),
                  Container(
                    child: Image.asset("assets/assets/8515742.png", height: 48, width: 48,),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 538.5),
                  ),
                  Container(
                    child: Text("Phone Usage", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    margin: EdgeInsets.only(left: 90, right: 30, top: 534.5),
                  ),
                  Container(
                    child: Text("20", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                    margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width - 60), right: 30, top: 565),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: (MediaQuery.of(context).size.width - 50),
                    child: Stack(

                      children: [

                      ],
                    ),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 595),
                    height: 1,
                  ),
                  Container(
                    child: Image.asset("assets/assets/762725.png", height: 48, width: 48,),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 603.5),
                  ),
                  Container(
                    child: Text("Working Time", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    margin: EdgeInsets.only(left: 90, right: 30, top: 599.5),
                  ),
                  Container(
                    child: Text("22d 10h", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                    margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width - 110), right: 30, top: 630),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: (MediaQuery.of(context).size.width - 50),
                    child: Stack(

                      children: [

                      ],
                    ),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 660),
                    height: 1,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),

                    width: (MediaQuery.of(context).size.width - 50),
                    child: Stack(

                      children: [

                      ],
                    ),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 725),
                    height: 1,
                  ),
                  Container(
                    child: Image.asset("assets/assets/1196775.png", height: 48, width: 48,),
                    margin: EdgeInsets.only(left: 30, right: 30, top: 668.5),
                  ),
                  Container(
                    child: Text("Distance", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                    margin: EdgeInsets.only(left: 90, right: 30, top: 664.5),
                  ),
                  Container(
                    child: Text("223.5km", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                    margin: EdgeInsets.only(left: (MediaQuery.of(context).size.width - 120), right: 30, top: 695),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: navigationBar(),
                  )
                ],
              )
          )

          ,
        )

    );
  }

  Widget getHomePage(){
    return MaterialApp(
        home: Scaffold(
          body: Container(
              child:
              Stack(
                children: [
                  GoogleMap(initialCameraPosition:  cameraPosition,  mapType: MapType.normal,
                    onMapCreated: onMapCreated,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    zoomControlsEnabled: false,
                    polylines: {
                      Polyline(
                          polylineId: PolylineId("route"),
                          points: Checker.positions.toList(),
                          color: Colors.lightBlue,
                          width: 4
                      )
                    },
                    markers: _markers,
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 80),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(23)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      )
                      ,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Column(
                        children: [
                          Text("سرعة", style: TextStyle(fontFamily: "Inter", fontSize: 19)),

                          Text('$spd', style: TextStyle(fontFamily: "Inter", color: Colors.green, fontWeight: FontWeight.w800, fontSize: 20))

                        ],


                      ),

                    ),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 50, 0, 0),
                      height: 110,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(23)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      )
                      ,
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        children: [
                          Text("وقت العمل", style: TextStyle(fontFamily: "Inter", fontSize: 17)),

                          Text('١:١٥:٢٣', style: TextStyle(fontFamily: "Inter", color: Colors.grey, fontSize: 18))

                        ],


                      ),

                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 50, 20, 0),
                      height: 110,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(23)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 3),//ges position of shadow
                          ),
                        ],
                      )
                      ,
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Column(
                        children: [
                          Text("مسافة القيادة", style: TextStyle(fontFamily: "Inter", fontSize: 17, fontWeight: FontWeight.w300), textAlign: TextAlign.center,),

                          Text("٢١.٣ كيلومتر", style: TextStyle(fontFamily: "Inter", color: Colors.grey, fontSize: 15))

                        ],


                      ),

                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: navigationBar(),
                  )
                ],
              )
          )

          ,
        )

    );
  }


  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 65.0,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              onTap: () => setState(() => selectBtn = i),
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 35.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return SizedBox(
      width: 75.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                painter: ButtonNotch(),
              )
                  : const SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              navBtn[i].imagePath,
              color: isActive ? selectColor : black,
              scale: 2,
              width: 32,
              height: 32,
            ),
          ),

        ],
      ),
    );

  }
  bool popup = false;
  var alertcont;
 void openDialog(){
   showDialog(
       context: context,
       builder:(BuildContext context) {
         alertcont = context;
         popup = true;
         return Dialog(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23.0)),
             child: Container(
               height: 160.0,
               width: 80.0,
               decoration: BoxDecoration(
                   color: Colors.red,
                 borderRadius: BorderRadius.circular(23)

               ),
                 padding: EdgeInsets.fromLTRB(10, 10, 5, 10),
                 alignment: Alignment.center,
                 child: Column(
                   children: [
                     Text("!", style: TextStyle(fontFamily: "Inter", fontSize: 40, color: Colors.white, fontWeight: FontWeight.w800)),

                     Text('أنت تسير بسرعة كبيرة، يرجى التباطؤ', style: TextStyle(fontFamily: "Inter", color: Colors.white, fontWeight: FontWeight.w300, fontSize: 25), textAlign: TextAlign.center,)

                   ],


                 )
             )
         );
       }).then((value) => popup = false);
 }
}