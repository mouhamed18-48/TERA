import 'package:consommateur/authentification/login.dart';
import 'package:consommateur/homepage/nosEntrep%C3%B4ts.dart';
import 'package:consommateur/homepage/nosProduits.dart';
import 'package:consommateur/homepage/searchBar.dart';
import 'package:consommateur/homepage/topRow.dart';
import 'package:consommateur/models/consommateur.dart';
import 'package:consommateur/shared_preferences/consommateur_data_manager.dart';
import 'package:flutter/material.dart';
import 'package:consommateur/constant.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Future<Consommateur?>? futureConsommateur;
  Consommateur? consommateur;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureConsommateur = ConsommateurDataManager.loadStoreData();
    _initClass();
  }


  Future<void> _initClass() async{
    consommateur = await futureConsommateur;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: teraOrange,
            leading: Builder(
              builder: (context) {
                return IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: Icon(
                    Icons.menu,
                    size: 35,
                    color: Colors.white,
                  ),
                );
              },
            ),
            actions: [
              Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                    icon: Icon(
                      Icons.notifications,
                      size: 35,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: teraOrange,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Déconnexion'),
                  onTap: () async {
                    // Effacer les données stockées et rediriger vers la page de connexion
                    await ConsommateurDataManager.removeStoreData();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopRow(name: (consommateur?.consommateurfirstname),),
                  SizedBox(height: Responsive().height(context, 40),),
                  NosEntrepots(),
                  SizedBox(height: Responsive().height(context, 20),),
                  Text("Nos produits", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Center(child: SearchBarTera()),
                  SizedBox(height: Responsive().height(context, 30),),
                  Center(child: NosProduits()),
                ],
              ),
            ),
          ),
        )
    );
  }
}


