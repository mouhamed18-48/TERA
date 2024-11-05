import "package:flutter/material.dart";
import "package:producteur/constant.dart";

class TeraTextField extends StatelessWidget {
  final TextEditingController controller;
  final String name;
  void Function(String)? onChanged;
  String? prefixIcon;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final TextInputType inputType;

   TeraTextField(
      {super.key,
      this.onChanged,
      required this.controller,
      required this.name,
      this.prefixIcon,
      this.obscureText = false,
      this.textCapitalization = TextCapitalization.none,
      required this.inputType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          color: const Color.fromARGB(217, 217, 217, 217),
          borderRadius: BorderRadius.circular(0),
          border: Border.all(width: 1)),
      child: TextField(
        expands: true,
        onChanged: onChanged,
        enabled: true,
        controller: controller,
        textCapitalization: textCapitalization,
        maxLines: null,
        obscureText: obscureText,
        keyboardType: inputType,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          focusColor: const Color.fromARGB(217, 217, 217, 217),
          prefixIcon: prefixIcon == null? null : Container(
            // margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            decoration: const BoxDecoration(
                border: BorderDirectional(end: BorderSide(width: 0, color: teraGrey))),
            child: Image.asset(
              prefixIcon!,
              scale: 3,
            ),
          ),
          isDense: true,
          hintText: name,
          counterText: "",
          labelStyle: const TextStyle(color: Color.fromARGB(255, 100, 99, 99)),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
