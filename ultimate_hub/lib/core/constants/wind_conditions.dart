/// Wind condition constants for game tracking
class WindConditions {
  static const List<String> directions = [
    'N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'
  ];

  static const Map<String, String> speedDescriptions = {
    'calm': '0-5 mph',
    'light': '5-10 mph',
    'moderate': '10-15 mph',
    'strong': '15-20 mph',
    'veryStrong': '20+ mph',
  };
}
