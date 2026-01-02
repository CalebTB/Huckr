/// Tournament formats
enum TournamentFormat {
  roundRobin('Round Robin'),
  singleElimination('Single Elimination'),
  doubleElimination('Double Elimination'),
  swiss('Swiss'),
  poolsToBracket('Pools to Bracket');

  final String displayName;
  const TournamentFormat(this.displayName);
}
