import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerant/screens/entrepot/gerer-les-stocks/livraisonEnCours.dart';
import 'package:gerant/screens/entrepot/gerer-les-stocks/producteurs.dart';
import 'package:gerant/screens/entrepot/gerer-les-stocks/produits.dart';

import '../../../constant.dart';
import '../../navigationBar.dart';
import 'historique/historique.dart';

class Stocks extends StatelessWidget {
  const Stocks({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height/1.12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () => {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NavBar())),
                            },
                        child: Image.asset(
                          'assets/icons/icons8-fleche-gauche-90.png',
                          scale: 3,
                        )),
                    const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Produits(),
                const SizedBox(
                  height: 30,
                ),
                const Producteurs(),
                const Spacer(),
                const LivraisonsEnCours(),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: InkWell(
                    onTap: () => {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const Historique())),
                    },
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                          color: teraOrange,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                        child: Text(
                          "Historique",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
