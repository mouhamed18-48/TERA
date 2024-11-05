import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';

class SearchBarTera extends StatelessWidget {
  const SearchBarTera({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController sb = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
          width: Responsive().width(context, 1.2),
          height: Responsive().height(context, 25),
          decoration: BoxDecoration(
            color: teraGrey,
            borderRadius: BorderRadius.circular(100)
          ),
          child: TextField(
            maxLines: 1,
            controller: sb,
            obscureText: false,
            textCapitalization: TextCapitalization.none,
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              enabled: true,
              counterText: "",
              isDense: true,
              prefixIcon: Image.asset("assets/icons/icons8-chercher-90.png", scale: 5,),
              border: OutlineInputBorder(
                borderSide: BorderSide.none
              ),  
              hintText: "Chercher un produit",
            ),
          )
        ),
      ],
    );
  }
}