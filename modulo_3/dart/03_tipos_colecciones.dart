void main() {
  // List — lista ordenada (como List en Kotlin)
  List<String> frutas   = ['manzana', 'banana', 'cereza'];
  var          numeros  = [1, 2, 3, 4, 5];       // tipo inferido: List<int>

  print(frutas[0]);         // manzana
  print(frutas.length);     // 3
  frutas.add('dátil');
  frutas.remove('banana');

  // Map — clave → valor (como Map en Kotlin)
  Map<String, int> edades = {
    'Ana':   28,
    'Luis':  34,
    'María': 25,
  };

  print(edades['Ana']);     // 28
  print(edades['Pedro']);   // null — clave no existe
  edades['Carlos'] = 40;    // añadir

  // Set — sin duplicados (como Set en Kotlin)
  Set<String> tags = {'flutter', 'dart', 'mobile'};
  tags.add('flutter');      // ignorado — ya existe
  print(tags.length);       // 3

  // Spread operator — para combinar colecciones
  var lista1 = [1, 2, 3];
  var lista2 = [4, 5, 6];
  var combinada = [...lista1, ...lista2];  // [1, 2, 3, 4, 5, 6]
  print(combinada);

  // Collection if — elementos condicionales
  bool mostrarExtra = true;
  var items = [
    'elemento1',
    'elemento2',
    if (mostrarExtra) 'elemento3',  // solo si la condición es true
  ];

  // Collection for — generar elementos
  var cuadrados = [for (var i = 1; i <= 5; i++) i * i];
  print(cuadrados);  // [1, 4, 9, 16, 25]
}