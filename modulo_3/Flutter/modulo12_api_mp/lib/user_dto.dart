class EstudianteDto {
  final int id;
  final String nombre;
  final String nombreUsuario;
  final String email;
  final DireccionDto direccion;
  final String telefono;
  final String sitioWeb;
  final AcademiaDto academia;

  const EstudianteDto({
    required this.id,
    required this.nombre,
    required this.nombreUsuario,
    required this.email,
    required this.direccion,
    required this.telefono,
    required this.sitioWeb,
    required this.academia,
  });

  factory EstudianteDto.fromJson(Map<String, dynamic> json) => EstudianteDto(
        id:            json['id']       as int,
        nombre:        json['name']     as String,
        nombreUsuario: json['username'] as String,
        email:         json['email']    as String,
        direccion:     DireccionDto.fromJson(json['address'] as Map<String, dynamic>),
        telefono:      json['phone']    as String,
        sitioWeb:      json['website']  as String,
        academia:      AcademiaDto.fromJson(json['company'] as Map<String, dynamic>),
      );
}

class DireccionDto {
  final String calle;
  final String numero;
  final String ciudad;
  final String codigoPostal;
  final CoordenadasDto coordenadas;

  const DireccionDto({
    required this.calle,
    required this.numero,
    required this.ciudad,
    required this.codigoPostal,
    required this.coordenadas,
  });

  factory DireccionDto.fromJson(Map<String, dynamic> json) => DireccionDto(
        calle:        json['street']  as String,
        numero:       json['suite']   as String,
        ciudad:       json['city']    as String,
        codigoPostal: json['zipcode'] as String,
        coordenadas:  CoordenadasDto.fromJson(json['geo'] as Map<String, dynamic>),
      );
}

class CoordenadasDto {
  final String latitud;
  final String longitud;

  const CoordenadasDto({required this.latitud, required this.longitud});

  factory CoordenadasDto.fromJson(Map<String, dynamic> json) => CoordenadasDto(
        latitud:  json['lat'] as String,
        longitud: json['lng'] as String,
      );
}

class AcademiaDto {
  final String nombre;
  final String lema;
  final String sector;

  const AcademiaDto({
    required this.nombre,
    required this.lema,
    required this.sector,
  });

  factory AcademiaDto.fromJson(Map<String, dynamic> json) => AcademiaDto(
        nombre: json['name']        as String,
        lema:   json['catchPhrase'] as String,
        sector: json['bs']          as String,
      );
}
