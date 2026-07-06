String formatDate(String value) {
  try {
    final date = DateTime.parse(value).toLocal();
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  } catch (_) {
    return value;
  }
}

String formatDateTime(String value) {
  try {
    final date = DateTime.parse(value).toLocal();
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  } catch (_) {
    return value;
  }
}
