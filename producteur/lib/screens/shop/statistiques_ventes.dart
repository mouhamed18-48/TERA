import 'package:flutter/material.dart';
import 'package:producteur/constant.dart';

class StatistiquesVentes extends StatelessWidget {
  const StatistiquesVentes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        color: teraGrey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(width: 20,),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 100,
              color: teraOrange,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 120,
              color: teraOrange,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 40,
              color: teraOrange,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 30,
              color: teraOrange,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 70,
              color: teraOrange,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 80,
              color: teraOrange,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 100,
              color: teraOrange,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 100,
              color: teraOrange,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 110,
              color: teraOrange,
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 20,
              height: 100,
              color: teraOrange,
            ),

          ],
        ),
      ),
    );
  }
}
