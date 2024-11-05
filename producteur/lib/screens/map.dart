import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {

  final double latitude;
  final double longitude;

  const Map({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);


  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late LatLng position;

  @override
  void initState() {
    super.initState();
    position = LatLng(widget.latitude, widget.longitude);
    // Initialisation de la position avec les variables passées

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );
            },
          ),
        ),
      body: GoogleMap(initialCameraPosition: CameraPosition(target: position, zoom: 13),
        markers:{
          Marker(
              markerId: MarkerId("Entrpot"),
            icon: BitmapDescriptor.defaultMarker,
            position: position
          )
        },
      )
    );
  }
}
