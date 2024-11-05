import 'package:consommateur/homepage/achatEnCours/AchatEnCours.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';

class TopRow extends StatelessWidget {
  final String? name;
  const TopRow({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: teraOrange,
                          borderRadius: BorderRadius.circular(100)
                        ),
                        child: Center(
                          child: ClipOval(
                      
                            child: Image.asset("assets/Tera2.png"),
                            ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      const Text("Boutique", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 20),)
                    ],
                  ),
                  InkWell(
                    onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (builder) => AchatEnCours()))},
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: teraDark,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.asset("assets/icons/az.png", scale: 4,),
                    ),
                  )
                ],
              ),
              SizedBox(height: Responsive().height(context, 80),),
              Text("Bonjour $name,", style: TextStyle(fontFamily: "Lilly", fontSize: 30),),
              Text("Bienvenue dans la boutique Tera,", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 15),),
              SizedBox(height: Responsive().height(context, 20),),
              Center(
                child: Container(
                  width: 150,
                  height: 2,
                  color: teraDark,
                ),
              )
      ],
    );
  }
}