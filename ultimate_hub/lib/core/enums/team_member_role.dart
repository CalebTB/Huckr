/// Roles a team member can have
enum TeamMemberRole {
  player('Player'),
  captain('Captain'),
  coach('Coach'),
  manager('Manager'),
  statKeeper('Stat Keeper');

  final String displayName;
  const TeamMemberRole(this.displayName);
}
