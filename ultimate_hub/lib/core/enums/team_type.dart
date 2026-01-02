/// Team type (for mixed division gender ratio)
enum TeamType {
  university('University/College'),
  club('Club'),
  masters('Masters'),
  grandMasters('Grand Masters'),
  youth('Youth'),
  pickup('Pickup/Casual');

  final String displayName;
  const TeamType(this.displayName);
}
