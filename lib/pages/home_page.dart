import 'dart:ui';

import 'package:flutter/material.dart';
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

  static const LatLng sourceLocation = LatLng(41.045621, 28.871472);
  static const LatLng sourceLocation2 = LatLng(41.04474414958876, 28.874816894531254);
  static const LatLng sourceLocation3 = LatLng(41.045334837833025, 28.874849081039432);
  static const LatLng sourceLocation4 = LatLng(41.04377314369311, 28.879805803298954);
  static const String speed = "72";

  static const LatLng targetLocation = LatLng(41.039665, 28.881858);

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


 
  int selectBtn = 0;
  @override
  Widget build(BuildContext context) {
    getPolyPoints();
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
                          points: [sourceLocation, sourceLocation2,sourceLocation3, sourceLocation4,  targetLocation],
                          color: Colors.cyanAccent,
                          width: 6
                      )
                      },
                      markers: {
                      const Marker(
                          markerId: MarkerId("source"),
                          position: sourceLocation,

                      ),
                      const Marker(
                          markerId: MarkerId("target"),
                          position: targetLocation
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
                        child: const Column(
                          children: [
                            Text("سرعة", style: TextStyle(fontFamily: "Inter", fontSize: 19)),

                            Text(speed, style: TextStyle(fontFamily: "Inter", color: Colors.green, fontWeight: FontWeight.w800, fontSize: 20))

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
}