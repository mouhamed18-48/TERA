import 'package:consommateur/homepage/entrepot/entrepotTop.dart';
import 'package:consommateur/homepage/entrepot/nosProduitsEntrepot.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';

class Entrepot extends StatelessWidget {
  final String name;
  final String id;
  const Entrepot({super.key, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EntrepotTop(name: name,),
              SizedBox(height: Responsive().height(context, 30),),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Nos produits", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),),
                        SizedBox(),
                      ],
                    ),
                    SizedBox(height: Responsive().height(context, 30),),
                    NosProduitsEntrepot(id :id),
                  ],
                )),
            ],
          ),
        ),
      ),
    );
  }
}