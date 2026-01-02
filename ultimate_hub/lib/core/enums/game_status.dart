/// Game status states
enum GameStatus {
  scheduled('Scheduled'),
  warmup('Warm Up'),
  inProgress('In Progress'),
  halftime('Halftime'),
  softCap('Soft Cap'),
  hardCap('Hard Cap'),
  delayed('Delayed'),
  completed('Completed'),
  cancelled('Cancelled');

  final String displayName;
  const GameStatus(this.displayName);
}
