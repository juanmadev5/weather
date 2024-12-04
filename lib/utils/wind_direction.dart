String windDirection(double degree) {
  final windDirections = [
    'Norte',       // 0
    'Noreste',     // 45
    'Este',        // 90
    'Sureste',     // 135
    'Sur',         // 180
    'Suroeste',    // 225
    'Oeste',       // 270
    'Noroeste'     // 315
  ];

  int index = ((degree + 22.5) % 360 ~/ 45) % 8;

  return 'Viento del ${windDirections[index]}';
}
