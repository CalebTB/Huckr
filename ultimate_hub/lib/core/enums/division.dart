/// Division types for ultimate frisbee
enum Division {
  open('Open'),
  womens('Women\'s'),
  mixed('Mixed');

  final String displayName;
  const Division(this.displayName);
}
