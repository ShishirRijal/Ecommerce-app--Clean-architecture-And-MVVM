//! extension on String?
extension NonNullString on String? {
  String orEmpty() {
    return this ?? '';
  }
}

//! extension on Int?
extension NonNullInt on int? {
  int orZero() {
    return this ?? 0;
  }
}
