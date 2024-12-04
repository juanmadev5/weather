import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

Future<Position?> getCurrentLocation(BuildContext context) async {
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        showErrorDialog(
          context,
          'El servicio de ubicación está deshabilitado.',
          'Por favor, habilítalo en la configuración del dispositivo.',
        );
      }
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          showErrorDialog(
            context,
            'Permisos denegados',
            'No se puede acceder a la ubicación sin permisos. Otórgalos desde Configuración.',
          );
        }
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        showErrorDialog(
          context,
          'Permisos denegados permanentemente',
          'Los permisos de ubicación están deshabilitados permanentemente. '
          'Por favor, habilítalos desde la configuración de la aplicación.',
          actionLabel: 'Abrir configuración',
          onActionPressed: () {
            Geolocator.openAppSettings();
          },
        );
      }
      return null;
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  } catch (e) {
    if (context.mounted) {
      showErrorDialog(
        context,
        'Error',
        'Ocurrió un error al intentar obtener la ubicación: $e',
      );
    }
    return null;
  }
}

void showErrorDialog(
  BuildContext context,
  String title,
  String message, {
  String actionLabel = 'OK',
  VoidCallback? onActionPressed,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (onActionPressed != null) {
                onActionPressed();
              }
            },
            child: Text(actionLabel),
          ),
        ],
      );
    },
  );
}
