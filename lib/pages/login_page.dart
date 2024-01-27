import 'dart:ui';

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
                onTap: (){
                  openDialog();
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
                  height: 200.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23)),
                  padding: EdgeInsets.fromLTRB(20, 10,20,  10),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        child: Column(
                          children: [
                            Text("أدخل الرمز المؤلف من 6 أرقام الذي تم إرساله إلى رقم هاتفك. (+50-971-XXXXX67)")
                          ],
                        ),
                      ),
                      Container(

                        child: Row(

                          children: [

                            Expanded(
                              
                                child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(left: 7, right: 7),
                                  width: 10,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),

                                    ),
                                      contentPadding: EdgeInsets.only(
                                    bottom: 40 / 2,  // HERE THE IMPORTANT PART
                                    )),),
                                )),
                            Expanded(

                                child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(left: 7, right: 7),
                                  width: 10,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),

                                    ),
                                        contentPadding: EdgeInsets.only(
                                          bottom: 40 / 2,  // HERE THE IMPORTANT PART
                                        )),),
                                )),
                            Expanded(

                                child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(left: 7, right: 7),
                                  width: 10,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),

                                    ),
                                        contentPadding: EdgeInsets.only(
                                          bottom: 40 / 2,  // HERE THE IMPORTANT PART
                                        )),),
                                )),
                            Expanded(

                                child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(left: 7, right: 7),
                                  width: 10,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),

                                    ),
                                        contentPadding: EdgeInsets.only(
                                          bottom: 40 / 2,  // HERE THE IMPORTANT PART
                                        )),),
                                )),
                            Expanded(

                                child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(left: 7, right: 7),
                                  width: 10,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),

                                    ),
                                        contentPadding: EdgeInsets.only(
                                          bottom: 40 / 2,  // HERE THE IMPORTANT PART
                                        )),),
                                )),
                            Expanded(

                                child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(left: 7, right: 7),
                                  width: 10,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black),

                                    ),
                                        contentPadding: EdgeInsets.only(
                                          bottom: 40 / 2,  // HERE THE IMPORTANT PART
                                        )),),
                                )),
                          ],
                        ),
                      )
                    ],
                  )));
        }).then((value) => popup = false);
  }
}
