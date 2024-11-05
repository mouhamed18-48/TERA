import 'package:geolocator/geolocator.dart';

Future<Position?> getUserLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Vérifier si le service de localisation est activé
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Demander à l'utilisateur d'activer la localisation
    await Geolocator.openLocationSettings();
    return null;
  }

  // Vérifier les permissions de localisation
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return null; // L'utilisateur a refusé la permission
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Les permissions sont refusées de manière permanente, nous ne pouvons pas demander les permissions
    return null;
  }

  // Récupérer la position actuelle de l'utilisateur
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  return position;
}
