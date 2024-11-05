import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:producteur/screens/navigationBar.dart';

import '../shared_preferences/producteur_data_manager.dart';
import 'home.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLogedin = false;
  Future<void> setDetails() async {
    isLogedin = await ProducteurDataManager.hasStoreData();
  }

  @override
  void initState() {
    super.initState();
    setDetails();
    final timer = Timer(const Duration(seconds: 3), () {
      if (isLogedin) {
        Get.snackbar('Check User', 'Your LOGED IN');
        Get.to(() => const NavBar());
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/Tera2.png', width: 500),
      ),
    );
  }
}
