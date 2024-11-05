import "package:flutter/material.dart";

class TeraTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  final String prefixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;

  const TeraTextField({
    super.key,
    required this.controller,
    required this.name,
    required this.prefixIcon,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    required this.inputType
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(217, 217, 217, 217),
        borderRadius: BorderRadius.circular(9),
        border: Border.all(
          width: 1
        )
      ),      
      margin: const EdgeInsets.fromLTRB(30, 0, 30, 15),
      child: TextField(
        enabled: true,
        controller: controller,
        textCapitalization: textCapitalization,
        maxLength: 32,
        maxLines: 1,
        obscureText: obscureText,
        keyboardType: inputType,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          focusColor: Color.fromARGB(217, 217, 217, 217),
          prefixIcon: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: BoxDecoration(
              border: BorderDirectional(
                end: BorderSide(
                  width: 1
                )
              )
            ),
            child: Image.asset(
              prefixIcon,
              scale: 3,
            ),
          ),
          isDense: true,
          hintText: name,
          counterText: "",
          labelStyle: const TextStyle(color: Color.fromARGB(255, 100, 99, 99)),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none
          ),  
        ),
        ),
      );
  }
}

