import 'package:flutter/material.dart';
import 'package:producteur/constant.dart';
import 'package:producteur/screens/entrepots.dart';
import 'package:producteur/screens/home.dart';
import 'package:producteur/screens/shop/shop.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 1;
  List<Widget> body = [
    const Entrepots(),
    const Home(),
    const Shop(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: body[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border: BorderDirectional(
                top: BorderSide(color: Colors.black, width: 2))),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (int newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset(
                "assets/icons/entrepot-icon.png",
                scale: 3,
              ),
              activeIcon: Image.asset("assets/icons/entrepot-icon.png",
                  color: teraOrange, scale: 3),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset("assets/icons/home-icon.png", scale: 3),
              activeIcon: Image.asset("assets/icons/home-icon.png",
                  color: teraOrange, scale: 3),
            ),
            BottomNavigationBarItem(
              label: "",
              icon: Image.asset(
                "assets/images/icons8-boutique-90.png",
                scale: 3,
                color: teraYellow,
              ),
              activeIcon: Image.asset(
                "assets/images/icons8-boutique-90.png",
                color: teraOrange,
                scale: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
