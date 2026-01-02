/// Play types that can occur during a game
enum PlayType {
  pull('Pull'),
  catch_('Catch'),
  throwDisc('Throw'),
  drop('Drop'),
  throwaway('Throwaway'),
  stall('Stall Out'),
  outOfBounds('Out of Bounds'),
  block('Block/D'),
  interception('Interception'),
  goal('Goal'),
  callahan('Callahan'),
  timeout('Timeout'),
  injury('Injury Stoppage'),
  substitution('Substitution');

  final String displayName;
  const PlayType(this.displayName);

  bool get isTurnover => [
    PlayType.drop,
    PlayType.throwaway,
    PlayType.stall,
    PlayType.outOfBounds,
  ].contains(this);

  bool get isDefensivePlay => [
    PlayType.block,
    PlayType.interception,
    PlayType.callahan,
  ].contains(this);

  bool get isScore => [
    PlayType.goal,
    PlayType.callahan,
  ].contains(this);
}
