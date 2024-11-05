import 'package:consommateur/authentification/inscription.dart';
import 'package:consommateur/homepage/homepage.dart';
import 'package:consommateur/repository/consommateur_repository.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';
import 'package:consommateur/authentification/teraTextfield.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final numeroController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading=false;
  String? _errorMessage;
  bool _isObscure1 = true;
  ConsommateurRepository repository = ConsommateurRepository();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Responsive().height(context, 15),),
                const Text(
                  'Connexion',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:40,
                      fontFamily: "Jost"
                  ),
                ),
                SizedBox(height: Responsive().height(context, 18),),
                Image.asset(
                  'assets/Tera.png',
                  width: 175,
                ),
                SizedBox(height: Responsive().height(context, 10.5),),
                TeraTextField(
                  controller: numeroController,
                  name: "Numéro de téléphone",
                  prefixIcon: "assets/icons/icons8-telephone-90-black.png",
                  inputType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,

                ),
                SizedBox(height: Responsive().height(context, 75),),
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
                    controller: passwordController,
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
                      hintText: "Mot de Passe",
                      counterText: "",
                      labelStyle: const TextStyle(color: Color.fromARGB(255, 100, 99, 99)),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none
                      ),
                    ),
                  ),
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
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                if (_errorMessage != null) // Afficher le message d'erreur si non nul
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
                SizedBox(height: Responsive().height(context, 20),),
                InkWell(
                    onTap: () {
                      setState(() {
                        isLoading=true;
                        _errorMessage = null; // Réinitialiser le message d'erreur

                      });
                      repository.loginconsommateur(phone: numeroController.text, password: passwordController.text).then((value){
                        if(value==null){
                          setState(() {
                            _errorMessage = "Numéro de téléphone ou mot de passe incorrect";
                          });

                        }else{
                          setState(() {
                            isLoading=false;
                          });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const Homepage()),
                                  (Route<dynamic> route) => false
                          );
                        }
                      });
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
                          "Se connecter",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),),
                    )
                ),
                SizedBox(height: Responsive().height(context, 12),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Pas de compte?",
                      style: TextStyle(
                          fontFamily: "Jost",
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(width: 5,),
                    InkWell(
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Inscription())
                        )
                      },
                      child: const Text(
                        "Inscrivez vous!",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}




