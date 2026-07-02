class UserDto {
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressDto address;
  final String phone;
  final String website;
  final CompanyDto company;

  const UserDto({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
        id: json['id'] as int,
        name: json['name'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        address: AddressDto.fromJson(json['address'] as Map<String, dynamic>),
        phone: json['phone'] as String,
        website: json['website'] as String,
        company:
            CompanyDto.fromJson(json['company'] as Map<String, dynamic>),
      );
}

class AddressDto {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoDto geo;

  const AddressDto({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) => AddressDto(
        street: json['street'] as String,
        suite: json['suite'] as String,
        city: json['city'] as String,
        zipcode: json['zipcode'] as String,
        geo: GeoDto.fromJson(json['geo'] as Map<String, dynamic>),
      );
}

class GeoDto {
  final String lat;
  final String lng;

  const GeoDto({required this.lat, required this.lng});

  factory GeoDto.fromJson(Map<String, dynamic> json) => GeoDto(
        lat: json['lat'] as String,
        lng: json['lng'] as String,
      );
}

class CompanyDto {
  final String name;
  final String catchPhrase;
  final String bs;

  const CompanyDto({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory CompanyDto.fromJson(Map<String, dynamic> json) => CompanyDto(
        name: json['name'] as String,
        catchPhrase: json['catchPhrase'] as String,
        bs: json['bs'] as String,
      );
}
