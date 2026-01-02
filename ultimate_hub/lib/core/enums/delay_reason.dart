/// Delay reasons for tournaments
enum DelayReason {
  lightning('Lightning'),
  rain('Rain'),
  wind('High Wind'),
  heat('Extreme Heat'),
  fieldConditions('Field Conditions'),
  injury('Medical Emergency'),
  other('Other');

  final String displayName;
  const DelayReason(this.displayName);
}
