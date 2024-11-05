import 'package:geolocator/geolocator.dart';

import 'getUserLocation.dart';

Future<Position?> getLocation() async {
  Position? position = await getUserLocation();
  if (position != null) {
    return position;
  } else {
    // Demander à l'utilisateur d'activer la localisation
    // Vous pouvez afficher un message ici
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Si le service de localisation n'est pas activé, demandez à l'utilisateur de l'activer.
      return Future.error('Service de localisation désactivé');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Les permissions sont refusées.
        return Future.error('Permissions de localisation refusées');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Les permissions sont refusées de façon permanente.
      return Future.error('Permissions de localisation refusées pour toujours');
    }
    Position? position =await Geolocator.getCurrentPosition();

    return position;

  }
}