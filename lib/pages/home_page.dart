import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:deliver/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
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
   bool test = false;
   void testSpeed(){
     test = true;
     const oneSec = Duration(milliseconds:300);
     var a = false;
     Timer.periodic(oneSec, (Timer t) => setState(() {
       if(sp3 >= 60){
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

       if(a){
         sp3 = sp3 - 1;
       }else{
         sp3 = sp3 + 1;
       }
        if(sp3 >= 75){
         a = true;
        }
       if(sp3 <= 50){
         a = false;
       }
       spd = '$sp3';
     }));


   }

  @override
  void initState() {
    super.initState();
  }


  int selectBtn = 0;
  @override
  Widget build(BuildContext context) {
    if(!test) testSpeed();
    return MaterialApp(
      home: Scaffold(
          body: Container(
            child:
                Stack(
                  children: [
                    GoogleMap(initialCameraPosition: const CameraPosition(target: sourceLocation, zoom: 14.5),  mapType: MapType.normal,
                      myLocationButtonEnabled: false,
                      mapToolbarEnabled: false,
                      zoomControlsEnabled: false,
                      polylines: {
                      Polyline(
                          polylineId: PolylineId("route"),
                          points: [targetLocation,sourceLocation11,sourceLocation10,sourceLocation9,sourceLocation8,sourceLocation7,sourceLocation6,sourceLocation5,sourceLocation, sourceLocation2,sourceLocation3, sourceLocation4,  targetLocation],
                          color: Colors.lightBlue,
                          width: 6
                      )
                      },
                      markers: {
                       Marker(
                          markerId: MarkerId("source"),
                          position: sourceLocation,
                         icon: Checker.markericon

                      ),


                    },),

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
        borderRadius: BorderRadius.all( Radius.circular(23)),
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