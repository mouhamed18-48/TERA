import 'package:consommateur/authentification/login.dart';
import 'package:consommateur/models/consommateur.dart';
import 'package:consommateur/repository/consommateur_repository.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/authentification/teraTextfield.dart';
import 'package:consommateur/constant.dart';


class Inscription extends StatefulWidget {
  const Inscription({super.key});

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  TextEditingController prenom = TextEditingController();
  TextEditingController nom = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController motDePasse = TextEditingController();
  TextEditingController motDePasseConfirmer = TextEditingController();
  bool isLoading=false;
  String? _errorMessage;
  ConsommateurRepository repository= ConsommateurRepository();
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: Responsive().height(context, 15),),
                  const Center(
                    child: Text(
                      'Inscription',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize:40,
                          fontFamily: "Jost"
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive().height(context, 18),),
                  TeraTextField(controller: prenom, name: "Prénom", prefixIcon: "assets/icons/icons8-utilisateur-sexe-neutre-90.png", inputType: TextInputType.text,),
                  SizedBox(height: Responsive().height(context, 80),),
                  TeraTextField(controller: nom, name: "Nom", prefixIcon: "assets/icons/icons8-utilisateur-sexe-neutre-90.png", inputType: TextInputType.text),
                  SizedBox(height: Responsive().height(context, 80),),
                  TeraTextField(controller: numero, name: "telephone", prefixIcon: "assets/icons/icons8-telephone-90-black.png", inputType: TextInputType.number),
                  SizedBox(height: Responsive().height(context, 80),),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(217, 217, 217, 217),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                            width: 1
                        )
                    ),
                    margin: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                    child: TextField(
                      controller: motDePasse,
                      maxLength: 32,
                      maxLines: 1,
                      obscureText: _isObscure1,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        focusColor: Color.fromARGB(217, 217, 217, 217),
                        prefixIcon: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          decoration: BoxDecoration(
                            border: BorderDirectional(
                              end: BorderSide(
                                  width: 1
                              ),
                            ),
                          ),
                          child: Image.asset(
                            "assets/icons/icons8-mot-de-passe-1-90.png",
                            scale: 3,
                          ),
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
                        isDense: true,
                        hintText: "Mot de passe",
                        counterText: "",
                        labelStyle: const TextStyle(color: Color.fromARGB(255, 100, 99, 99)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive().height(context, 80),),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(217, 217, 217, 217),
                        borderRadius: BorderRadius.circular(9),
                        border: Border.all(
                            width: 1
                        )
                    ),
                    margin: const EdgeInsets.fromLTRB(30, 0, 30, 15),
                    child: TextField(
                      controller: motDePasseConfirmer,
                      maxLength: 32,
                      maxLines: 1,
                      obscureText: _isObscure2,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        focusColor: Color.fromARGB(217, 217, 217, 217),
                        prefixIcon: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          decoration: BoxDecoration(
                            border: BorderDirectional(
                              end: BorderSide(
                                  width: 1
                              ),
                            ),
                          ),
                          child: Image.asset(
                            "assets/icons/icons8-mot-de-passe-1-90.png",
                            scale: 3,
                          ),
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
                        isDense: true,
                        hintText: "Confirmer mot de passe",
                        counterText: "",
                        labelStyle: const TextStyle(color: Color.fromARGB(255, 100, 99, 99)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                      ),
                    ),
                  ),
                  if (_errorMessage != null) // Afficher le message d'erreur s'il existe
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  SizedBox(height: Responsive().height(context, 18),),
                  InkWell(
                      onTap: ()  {
                        setState(() {
                          _errorMessage = null; // Réinitialiser le message d'erreur
                        });
                        if (motDePasse.text != motDePasseConfirmer.text) {
                          setState(() {
                            _errorMessage = "Les mots de passe ne correspondent pas";
                          });
                          return;
                        }

                        setState(() {
                          isLoading=true;
                        });
                        Consommateur consommateur = Consommateur(
                            consommateurfirstname: prenom.text,
                            consommateursecondname: nom.text,
                            consommateurphone:numero.text,
                            consommateurpassword:motDePasse.text
                        );

                        repository.registerConsommateur(consommateur: consommateur).then((value){
                          print("Valeur retournée : $value");
                          if(value==true){
                            setState(() {
                              isLoading=false;
                            });
                            changerPage(context, Login());
                          } else {
                            setState(() {
                              isLoading=false;
                              _errorMessage = "L'inscription a échoué, veuillez réessayer.";
                            });
                          }
                        }
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 60,
                        decoration: BoxDecoration(
                            color: teraOrange,
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: const Center(
                          child: Text(
                            "S'inscrire",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          ),),
                      )),
                  SizedBox(height: Responsive().height(context, 10),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Vous avez un compte?",
                        style: TextStyle(
                            fontFamily: "Jost",
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(width: 5,),
                      InkWell(
                        onTap: () => {
                          Navigator.pop(
                              context,
                              MaterialPageRoute(builder: (context) => Login())
                          )
                        },
                        child: const Text(
                          "Connectez vous!",
                          style: TextStyle(
                            fontFamily: "Jost",
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            color: teraOrange,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive().height(context, 35),),
                  Container(
                    color: teraOrange,
                    height: 22,
                  )
                ]
            )
        ),
      ),
    );
  }
}



