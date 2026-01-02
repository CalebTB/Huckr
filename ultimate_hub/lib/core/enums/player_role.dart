/// Player positions (informal, for stats grouping)
enum PlayerRole {
  handler('Handler'),
  cutter('Cutter'),
  hybrid('Hybrid');

  final String displayName;
  const PlayerRole(this.displayName);
}
