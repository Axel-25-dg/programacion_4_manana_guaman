// lib/core/utils/validators.dart

String? validateUsername(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Campo obligatorio';
  }
  if (value.trim().length < 3) {
    return 'Mínimo 3 caracteres';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Campo obligatorio';
  }
  final email = value.trim();
  final regex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+");
  if (!regex.hasMatch(email)) {
    return 'Ingrese un email válido';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Campo obligatorio';
  }
  if (value.length < 8) {
    return 'Mínimo 8 caracteres';
  }
  return null;
}
