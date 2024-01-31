import 'dart:convert';
import 'dart:ui';
import 'package:deliver/main.dart';
import 'package:deliver/pages/home_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }
  final TextEditingController id = TextEditingController();
  final TextEditingController password = TextEditingController();
  static String data = "";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12)
              ),

              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: id,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "رقم العميل"
                    ),
                  )
              ),
            ),),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)
                  ),

                  child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "كلمة المرور"
                        ),
                      )
                  ),
                ),),
              SizedBox(height: 20),

              Padding(padding: const EdgeInsets.symmetric(horizontal: 75),
              child: GestureDetector(
                onTap: () async {

                  Uri uri  = Uri.parse("http://192.168.1.81:4850/api/login");
                  print(uri.port);
                  var response = await http.post(uri,
                      headers: {"Content-Type": "application/json"},
                      body: jsonEncode({
                        "id": int.parse(id.value.text),
                        "password": password.value.text
                      }));

                  Checker.data = response.body;
                  if(jsonDecode(response.body)["company"] is String){
                    Uri uri  = Uri.parse("http://192.168.1.81:4850/api/get/dailyRoute");

                    var data = jsonDecode(Checker.data);

                    var response = await http.post(uri,
                        headers: {"Content-Type": "application/json"},
                        body: jsonEncode({
                          "id": data["_id"],

                        }));
                    var data2 = jsonDecode(response.body);
                    Checker.positions = {};
                    Set.from(data2["positionList"].reversed).forEach((a) => Checker.positions.add(LatLng(a["latitude"], a["longitude"])));

                        final path = await _localPath;
                    File('$path/data.json').writeAsString(response.body);
                    Navigator.push(context,   MaterialPageRoute(builder: (context) => HomePage()));
                    print(await File('$path/data.json').readAsString());
                  }else{
                    openDialog();
                  }
                },
                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text("تسجيل الدخول", style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                    ),
                  )
              ),

              ),
              SizedBox(height: 20),
              new GestureDetector(
                onTap: (){
                  print("Text Clicked");
                },
                child: Text("هل نسيت كلمة المرور الخاصة بك؟", style: TextStyle(color: Colors.black),),
              )



            ],
          ),
        ),
      ),
    ));
  }

  bool popup = false;
  var alertcont;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  void openDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          alertcont = context;
          popup = true;
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.0)),
              child: Container(
                  height: 75.0,
                  width: 10.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23)),
                  padding: EdgeInsets.fromLTRB(30, 10,30,  10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: Column(
                          children: [
                            Text("المعلومات المدخلة غير صحيحة!")
                          ],
                        ),
                      ),

                    ],
                  )));
        }).then((value) => popup = false);
  }
}
