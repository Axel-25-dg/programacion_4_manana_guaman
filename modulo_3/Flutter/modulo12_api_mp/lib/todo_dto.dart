class EjercicioDto {
  final int id;
  final String enunciado;
  final bool completado;

  const EjercicioDto({
    required this.id,
    required this.enunciado,
    required this.completado,
  });

  factory EjercicioDto.fromJson(Map<String, dynamic> json) => EjercicioDto(
        id:         json['id']        as int,
        enunciado:  json['title']     as String,
        completado: json['completed'] as bool,
      );

  bool get sinResolver => !completado;
}
