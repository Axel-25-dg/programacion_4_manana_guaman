void main() {
  // Tipo no-nullable — NUNCA puede ser null
  String nombre = 'Ana';
  // nombre = null;       // ERROR de compilación

  // Tipo nullable — puede ser null (añadir ?)
  String? apellido = null;   // OK
  apellido = 'García';       // OK

  // Operadores de null safety
  String? ciudad='Quito';

  // ?. — safe call (igual que en Kotlin)
  print(ciudad?.length);      // null — no lanza excepción

  // ?? — operador Elvis (igual que ?: en Kotlin)
  String resultado = ciudad ?? 'Sin ciudad';
  print(resultado);           // Sin ciudad

  // ! — non-null assertion (igual que !! en Kotlin) — úsalo con precaución
  String ciudadSegura = ciudad!;  // lanza si ciudad es null

  // Null check con if
  if (apellido != null) {
    print(apellido.length);   // smart cast — ya es String aquí
  }

  // late — inicialización diferida (como lateinit en Kotlin)
  late String token;
  token = 'abc123';           // debe asignarse antes de usar
  print(token);
}