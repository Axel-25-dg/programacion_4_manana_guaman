void main() {
  final precios = [29.99, 49.50, 15.00, 99.99];

  // map devuelve un Iterable con cada elemento transformado
  final preciosConIva = precios.map((p) => p * 1.15);
  print(preciosConIva.toList());
  // [34.4885, 56.925, 17.25, 114.9885]

  // map sobre Strings
  final endpoints = ['/usuarios', '/productos', '/pedidos'];
  final urls = endpoints.map((e) => 'https://api.ejemplo.com$e');
  print(urls.toList());
  // [https://api.ejemplo.com/usuarios, ...]
}