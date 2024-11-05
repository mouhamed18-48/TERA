import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../shared_preference/gerant_data_manager.dart';
import 'authentification/login.dart';
import 'homepage/homepage.dart';
import 'navigationBar.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogedin = false;
  Future<void> setDetails() async{
    isLogedin=await GerantDataManager.hasStoreData();
  }

  @override
  void initState() {
    super.initState();
    setDetails();
    final timer=Timer(
      const Duration(seconds: 3),
        (){
          if(isLogedin){
            Get.snackbar('Check User', 'Your LOGED IN');
            Get.to(()=>const NavBar());
          }else{
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false
            );
          }
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/Tera.png', width: 150, height: 150,),
      ),
    );
  }
}
