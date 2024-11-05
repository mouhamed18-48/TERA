import 'package:flutter/material.dart';

import '../../constant.dart';

class InfosEntrepot extends StatelessWidget {
  const InfosEntrepot({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InfoItem(imagePath: "assets/temperature.png", value: "33°C", title: "Température",),
           SizedBox(width: 20,),
          InfoItem(imagePath: "assets/humidite.png", value: "76%", title: "Humidité",),
        ],
      ),
    );
  }
}

class InfoItem extends StatefulWidget {
  final String imagePath;
  final String value;
  final String title;
  const InfoItem({
    super.key,
    required this.imagePath,
    required this.value,
    required this.title,
    });

  @override
  State<InfoItem> createState() => _InfoItemState();
}

class _InfoItemState extends State<InfoItem> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(8),
        width: 150,
        height: 80,
        decoration: BoxDecoration(
          color: teraYellow,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Container(
              width: 140,
              height: 30,
              color: teraDarkYellow,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(widget.imagePath, scale: 22,),
                  SizedBox(width: 5,),
                  Text(widget.title, style: TextStyle(fontFamily: "Poppins", fontSize: 14, fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            SizedBox(height: 5,),
            Text(widget.value, style: TextStyle(color: teraOrange, fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 18),)
          ],
        ),
      ),
    );
  }
}