import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wallpaper_application/screen/home_page.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();
    Timer(Duration(seconds:2), (){
Navigator.push(context, MaterialPageRoute(builder:(context)=>HomePage() ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      color: Colors.blue,
      child: Center(
        child: Text("Welcome ",style: TextStyle(color: Colors.white,fontSize:  25,fontWeight: FontWeight.bold),),
        
      ),
    ),

    );
  }
}