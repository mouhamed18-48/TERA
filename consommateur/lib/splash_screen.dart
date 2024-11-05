import 'dart:async';

import 'package:consommateur/shared_preferences/consommateur_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'authentification/login.dart';
import 'homepage/homepage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogedin = false;
  Future<void> setDetails() async{
    isLogedin=await ConsommateurDataManager.hasStoreData();
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
            Get.to(()=>const Homepage());
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
      body: Center(
        child: Image.asset('assets/Tera2.png', width: 150, height: 150,),
      ),
    );
  }
}
