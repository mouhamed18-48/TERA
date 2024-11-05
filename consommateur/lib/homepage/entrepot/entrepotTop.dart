import 'package:consommateur/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';



class EntrepotTop extends StatelessWidget {

  final String? name;
  const EntrepotTop({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Responsive().width(context, 1),
          height: Responsive().height(context, 2),
          decoration: BoxDecoration(
            color: teraDark,
          ),
        ),
        ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.asset("assets/keur-massar.jpg", fit: BoxFit.fill, width: Responsive().width(context, 1), height: Responsive().height(context, 2.5),)),
        InkWell(
          onTap: (){
            Navigator.pop(context,MaterialPageRoute(builder: (context) => Homepage()));
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Image.asset("assets/icons/icons8-fleche-gauche-90.png", scale: 3,),
          ),
        ),
        Positioned(
          bottom: Responsive().height(context, 40),
          left: Responsive().width(context, 6),
          right: Responsive().width(context, 6),
          child: Container(
            width: 250,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
                child: Text("${name}", style: TextStyle(fontFamily: "Poppins", color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)
            ),
          ),
        )
      ],
    );
  }
}



