import 'package:flutter/material.dart';
import 'package:producteur/screens/shop/shop.dart';

import '../Color/constants.dart';
import '../functions/function.dart';
import 'entrepots.dart';
import 'home.dart';

// class navbar extends StatefulWidget {
//   const navbar({super.key, required this.pageIndex});
//   final int pageIndex;
//   @override
//   State<navbar> createState() => _navbarState();
// }

// class _navbarState extends State<navbar> {
//   List pageList = [Entrepots(), const Home(), const Shop()];

//   void _onSelected(newIndex) {
//     if (Navigator.of(context).canPop()) {
//       Navigator.pop(context);
//     }
//     changerPage(context, pageList[newIndex]);
//   }

//   NavigationDestination _destination(
//       String imagePath, String label, double width) {
//     return NavigationDestination(
//       icon: Image.asset(imagePath, width: width, color: jauneClair),
//       selectedIcon: Image.asset(
//         imagePath,
//         width: width,
//         color: orange,
//       ),
//       label: label,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return NavigationBar(
//       // indicatorColor: Colors.white,
//       selectedIndex: widget.pageIndex,
//       onDestinationSelected: _onSelected,
//       destinations: [
//         _destination('assets/icons/entrepot-icon.png', '', 30),
//         _destination("assets/icons/home-icon.png", '', 30),
//         _destination('assets/icons/shop-icon.png', '', 30),
//       ],
//     );
//   }
// }
