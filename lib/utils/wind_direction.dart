String windDirection(double degree) {
  if (degree < 0 || degree >= 360) {
    return 'Ángulo inválido';
  }

  final windDirections = [
    'Norte',
    'Noreste',
    'Este',
    'Sureste',
    'Sur',
    'Suroeste',
    'Oeste',
    'Noroeste'
  ];

  int index = ((degree + 22.5) % 360 ~/ 45) % 8;

  return 'Viento del ${windDirections[index]}';
}
