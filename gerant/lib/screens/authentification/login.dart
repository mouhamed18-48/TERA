import 'package:flutter/material.dart';
import 'package:gerant/screens/authentification/teraTextfield.dart';

import '../../constant.dart';
import '../../repository/gerant_repository.dart';
import '../navigationBar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final identifiantController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String? _errorMessage;
  GerantRepository repository = GerantRepository();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height/1.05,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Connexion',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        fontFamily: "Jost"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    'assets/Tera.png',
                    width: 175,
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TeraTextField(
                    controller: identifiantController,
                    name: "Identifiant",
                    prefixIcon:
                        "assets/icons/icons8-utilisateur-sexe-neutre-90.png",
                    inputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TeraTextField(
                    controller: passwordController,
                    name: "Mot de Passe",
                    obscureText: true,
                    prefixIcon: "assets/icons/icons8-mot-de-passe-1-90.png",
                    inputType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Text(
                          "Mot de passe oublié?",
                          style: TextStyle(
                              fontFamily: "Jost",
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (_errorMessage !=
                      null) // Afficher le message d'erreur si non nul
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                      onTap: () => {
                            setState(() {
                              isLoading = true;
                              _errorMessage =
                                  null; // Réinitialiser le message d'erreur
                            }),
                            repository
                                .loginGerant(
                                    id: identifiantController.text,
                                    password: passwordController.text)
                                .then((value) {
                              if (value == null) {
                                setState(() {
                                  _errorMessage =
                                      "Identifiant ou mot de passe incorrect";
                                });
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const NavBar()),
                                    (Route<dynamic> route) => false);
                              }
                            })
                          },
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                            color: teraOrange,
                            borderRadius: BorderRadius.circular(6)),
                        child: const Center(
                          child: Text(
                            "Se connecter",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      )),
                  Spacer(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Identifiant oublié?",
                        style: TextStyle(
                            fontFamily: "Jost", fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Cliquez ici!",
                        style: TextStyle(
                          fontFamily: "Jost",
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          color: teraOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    color: teraOrange,
                    height: 22,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
