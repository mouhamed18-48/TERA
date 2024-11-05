import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../functions/function.dart';
import '../models/Producteur.dart';
import '../repositories/producteur_repository.dart';
import 'login.dart';

class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final prenom = TextEditingController();
  final nom = TextEditingController();
  final numero = TextEditingController();
  final motdepasse = TextEditingController();
  final confirmation = TextEditingController();
  ProducteurRepository repository = ProducteurRepository();
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  bool isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            height: MediaQuery.of(context).size.height / 1.08,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Inscription",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: "Jost",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: SizedBox(
                    height: 58,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: prenom,
                      decoration: InputDecoration(
                        labelText: 'Prénom',
                        filled: true,
                        fillColor: const Color.fromRGBO(224, 224, 224, 1),
                        prefixIcon: const Icon(
                          Icons.person,
                          size: 23,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    height: 58.0,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: nom,
                      decoration: InputDecoration(
                        filled: true,
                        labelText: "Nom",
                        fillColor: const Color.fromRGBO(224, 224, 224, 1),
                        prefixIcon: const Icon(
                          Icons.person,
                          size: 23,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    height: 58.0,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      controller: numero,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: 'Numéro de téléphone',
                        filled: true,
                        fillColor: const Color.fromRGBO(224, 224, 224, 1),
                        prefixIcon: const Icon(
                          Icons.phone,
                          size: 23,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 58.0,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: motdepasse,
                    obscureText: _isObscure1,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      filled: true,
                      fillColor: const Color.fromRGBO(224, 224, 224, 1),
                      prefixIcon: const Icon(
                        Icons.key,
                        size: 23,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure1 ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure1 = !_isObscure1;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 58.0,
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    controller: confirmation,
                    obscureText: _isObscure2,
                    decoration: InputDecoration(
                      labelText: 'Confirmer mot de passe',
                      filled: true,
                      fillColor: const Color.fromRGBO(224, 224, 224, 1),
                      prefixIcon: const Icon(
                        Icons.key,
                        size: 23,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure2 ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure2 = !_isObscure2;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                if (_errorMessage !=
                    null) // Afficher le message d'erreur s'il existe
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 80,),
                InkWell(
                  onTap: () {
                    setState(() {
                      _errorMessage = null; // Réinitialiser le message d'erreur
                    });
                    if (motdepasse.text != confirmation.text) {
                      setState(() {
                        _errorMessage =
                            "Les mots de passe ne correspondent pas";
                      });
                      return;
                    }

                    setState(() {
                      isLoading = true;
                    });
                    Producteur producteur = Producteur(
                        producterfirstname: prenom.text,
                        productersecondname: nom.text,
                        producterphone: numero.text,
                        producterpassword: motdepasse.text);

                    repository
                        .registerProducteur(producteur: producteur)
                        .then((value) {
                      print("Valeur retournée : $value");
                      if (value == true) {
                        setState(() {
                          isLoading = false;
                        });
                        changerPage(context, const LoginScreen());
                      } else {
                        setState(() {
                          isLoading = false;
                          _errorMessage =
                              "L'inscription a échoué, veuillez réessayer.";
                        });
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(247, 72, 29, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "S'inscrire",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                RichText(
                  text: TextSpan(
                    text: "Vous avez un compte ? ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: "Connectez vous!",
                        style: TextStyle(
                          decoration: TextDecoration.combine([
                            TextDecoration.underline,
                          ]),
                          color: const Color.fromRGBO(247, 72, 29, 1),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            changerPage(context, const LoginScreen());
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.orange[900],
          height: 20,
          width: double.infinity,
        ),
      ),
    );
  }
}
