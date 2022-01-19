String maskCurrencyBRL(double value) {
  return 'R\$ ${value.toDouble().toStringAsFixed(2).replaceFirst('.', ',')}';
}

String padLeft(int value, [int width = 2]) =>
    value.toString().padLeft(width, '0');
