/// Line type for a point (offense or defense)
enum LineType {
  offense('O-Line'),
  defense('D-Line');

  final String displayName;
  const LineType(this.displayName);
}
