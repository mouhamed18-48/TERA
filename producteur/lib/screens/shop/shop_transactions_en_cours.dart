import 'package:flutter/material.dart';
import 'package:producteur/constant.dart';
import 'package:producteur/screens/home.dart';

class ShopTransactionsEnCours extends StatefulWidget {
  const ShopTransactionsEnCours({super.key});

  @override
  State<ShopTransactionsEnCours> createState() => _ShopTransactionsEnCoursState();
}

class _ShopTransactionsEnCoursState extends State<ShopTransactionsEnCours> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      color: teraGrey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
            Transaction(
              name: "Ibrahima",
              idTransaction: "C-103",
              price: 10000,
              weight: 30,
              productType: "carotte",
            ),
          ],
        ),
      ),
    );
  }
}