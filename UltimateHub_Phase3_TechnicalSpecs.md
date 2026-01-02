# Ultimate Hub: Phase 3 Preview & Advanced Specifications
## Tournament Management, Spectator Features, and Technical Deep Dive

*Document Version 1.0 | January 2026*

---

## Part 1: Phase 3 Preview — Tournament Management

Phase 3 transforms Ultimate Hub into a complete tournament ecosystem. Tournament Directors (TDs) create and manage events, teams register and check in, games sync automatically to brackets, and spectators follow along from anywhere. This is where Ultimate Hub captures the institutional partnerships (USA Ultimate, Ultiworld) that drive viral adoption.

### 1.1 Tournament Director Features

#### 1.1.1 Tournament Creation Wizard

**Step 1: Basic Info**
```
TOURNAMENT DETAILS

Name: [Carolina Kickoff 2025____________]
Dates: [Jan 25-26, 2025__________________]
Location: [Durham, NC___________________]
Venue: [WakeMed Soccer Park_____________]

Divisions:
[✓] Men's Club
[✓] Women's Club
[ ] Mixed Club
[ ] College Men's
[ ] College Women's

Logo: [Upload_________________________]

Division Settings: →
```

**Step 2: Division Configuration**
```
MEN'S CLUB DIVISION

Teams: [16] teams
Format: 
○ Round Robin → Single Elimination
● Pool Play → Bracket
○ Swiss Draw

Pool Play:
[4] pools of [4] teams each
Games to: [13]
Time cap: [75 min]

Bracket:
[✓] Include all teams
[ ] Top 2 per pool advance
[ ] Top 3 per pool advance

Crossover: [Standard (1v2, 2v1)___▼]

→ Preview Bracket
```

**Step 3: Schedule Builder**
```
SCHEDULE BUILDER

Saturday, Jan 25
┌─────────────────────────────────────┐
│ 8:00 AM - Round 1                   │
│ ┌────┐ ┌────┐ ┌────┐ ┌────┐       │
│ │F1  │ │F2  │ │F3  │ │F4  │       │
│ │A1vA2│A3vA4│B1vB2│B3vB4│       │
│ └────┘ └────┘ └────┘ └────┘       │
├─────────────────────────────────────┤
│ 9:30 AM - Round 2                   │
│ ...                                 │
├─────────────────────────────────────┤
│ 11:00 AM - Round 3                  │
│ ...                                 │
├─────────────────────────────────────┤
│ 1:00 PM - Crossovers                │
│ ...                                 │
└─────────────────────────────────────┘

[+ Add Break] [Auto-Schedule] [Manual Edit]
```

**Step 4: Field Assignment**
```
FIELD MAP

┌─────────────────────────────────────┐
│  [F1]  [F2]  [F3]  [F4]            │
│                                     │
│  [F5]  [F6]  [F7]  [F8]            │
│                                     │
│       PARKING / HQ                  │
└─────────────────────────────────────┘

Field 1: Men's Pool A
Field 2: Men's Pool A  
Field 3: Men's Pool B
Field 4: Men's Pool B
Field 5: Women's Pool A
...

[Upload Field Image] [Assign Games]
```

**Step 5: Team Registration**
```
REGISTRATION SETTINGS

Registration: [Open ▼]
Deadline: [Jan 15, 2025]
Entry Fee: [$350 per team]

Payment:
[✓] Stripe Integration
[ ] Manual (mark paid in dashboard)

Roster Requirements:
Min players: [14]
Max players: [28]
USAU membership required: [✓]

Waitlist: [✓] Enable (max [8] teams)

[Generate Registration Link]
```

#### 1.1.2 Live Tournament Dashboard

**TD Command Center:**
```
┌─────────────────────────────────────────────────────────┐
│  🏆 Carolina Kickoff 2025                    [Settings] │
│  Saturday, Jan 25 • 10:42 AM                            │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ACTIVE GAMES (8)                                       │
│  ┌─────────┬─────────┬─────────┬─────────┐            │
│  │ F1      │ F2      │ F3      │ F4      │            │
│  │ ROF 8   │ TSP 6   │ PON 11  │ CHN 9   │            │
│  │ TSP 7   │ CHN 5   │ MAD 8   │ RLH 8   │            │
│  │ 52:30   │ 48:15   │ FINAL   │ 61:20   │            │
│  └─────────┴─────────┴─────────┴─────────┘            │
│  ┌─────────┬─────────┬─────────┬─────────┐            │
│  │ F5      │ F6      │ F7      │ F8      │            │
│  │ ...     │ ...     │ ...     │ ...     │            │
│  └─────────┴─────────┴─────────┴─────────┘            │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  ALERTS (2)                                             │
│  ⚠️ Field 3 game finished - awaiting spirit scores      │
│  ⚠️ Field 7 - Injury timeout reported                   │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  QUICK ACTIONS                                          │
│  [📢 Announcement] [🕐 Delay Round] [📋 Print Scores]  │
│  [🔄 Swap Fields] [➕ Add Game] [📊 Export Data]       │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

**Bracket Auto-Advancement:**
When a game ends, the bracket updates automatically:

```
QUARTERFINALS           SEMIFINALS              FINALS

Pool A #1 ─┐
           ├─── Winner ─┐
Pool B #2 ─┘            │
                        ├─── Winner ─┐
Pool C #1 ─┐            │            │
           ├─── Winner ─┘            │
Pool D #2 ─┘                         │
                                     ├─── CHAMPION
Pool B #1 ─┐                         │
           ├─── Winner ─┐            │
Pool A #2 ─┘            │            │
                        ├─── Winner ─┘
Pool D #1 ─┐            │
           ├─── Winner ─┘
Pool C #2 ─┘

[Auto-advance enabled] [Manual override]
```

#### 1.1.3 Tiebreaker Calculator

USA Ultimate tiebreaker rules are complex. Ultimate Hub automates them completely:

```
POOL A STANDINGS (Tiebreaker Applied)

Rank  Team          W-L   Head2Head  PtDiff  PtsAgainst
─────────────────────────────────────────────────────────
1     Ring of Fire  3-0   —          +12     28
2     Truck Stop    2-1   vs PON: W   +3     35
3     PoNY          2-1   vs TSP: L   +5     33  
4     Chain         0-3   —          -20     48

Tiebreaker Log:
• Truck Stop and PoNY tied at 2-1
• Head-to-head: Truck Stop beat PoNY 13-11
• Truck Stop ranked #2, PoNY ranked #3

[View Full Rules] [Override Ranking]
```

**Tiebreaker Logic Implementation:**
```dart
class TiebreakerCalculator {
  List<TeamStanding> breakTie(List<TeamStanding> tiedTeams) {
    // Step 1: Head-to-head (if 2 teams)
    if (tiedTeams.length == 2) {
      final h2h = getHeadToHead(tiedTeams[0], tiedTeams[1]);
      if (h2h != null) return sortByH2H(tiedTeams, h2h);
    }
    
    // Step 2: Head-to-head among tied teams (if 3+)
    if (tiedTeams.length > 2) {
      final h2hRecord = getH2HRecord(tiedTeams);
      if (hasUniqueRankings(h2hRecord)) return sortByH2HRecord(h2hRecord);
    }
    
    // Step 3: Point differential (capped at +/- 5 per game)
    final byPtDiff = sortByCappedPointDiff(tiedTeams, cap: 5);
    if (hasUniqueRankings(byPtDiff)) return byPtDiff;
    
    // Step 4: Points allowed
    final byPtsAllowed = sortByPointsAllowed(tiedTeams);
    if (hasUniqueRankings(byPtsAllowed)) return byPtsAllowed;
    
    // Step 5: Points scored
    final byPtsScored = sortByPointsScored(tiedTeams);
    if (hasUniqueRankings(byPtsScored)) return byPtsScored;
    
    // Step 6: Disc flip
    return requestDiscFlip(tiedTeams);
  }
}
```

### 1.2 Spectator Experience

#### 1.2.1 Live Game View (ESPN-Style)

Remote fans see real-time game state:

```
┌─────────────────────────────────────────────────────────┐
│  ● LIVE                              Carolina Kickoff   │
├─────────────────────────────────────────────────────────┤
│                                                         │
│         RING OF FIRE    vs    TRUCK STOP               │
│              8                    7                     │
│                                                         │
│  ┌───────────────────────────────────────────────┐     │
│  │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│     │
│  │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│     │
│  ├───────────────────────────────────────────────┤     │
│  │                                               │     │
│  │                   ◉                           │     │
│  │              #7 Smith                         │     │
│  │                                               │     │
│  │                                               │     │
│  ├───────────────────────────────────────────────┤     │
│  │                                               │     │
│  │                                               │     │
│  ├───────────────────────────────────────────────┤     │
│  │▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓│     │
│  └───────────────────────────────────────────────┘     │
│                                                         │
│  ROF OFFENSE  •  42:18  •  Field 1                     │
│                                                         │
├─────────────────────────────────────────────────────────┤
│  PLAY-BY-PLAY                                          │
│                                                         │
│  42:18  #7 → #23  Swing to open side                   │
│  42:05  #23 → #11  Upline strike                       │
│  41:52  #11 → #5   Dump reset                          │
│  41:38  ⭐ GOAL #5 Davis  (ROF 8-7)                    │
│  ...                                                    │
│                                                         │
│  [📊 Box Score] [🔔 Notify Me] [📤 Share]              │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

#### 1.2.2 Tournament Hub for Fans

```
┌─────────────────────────────────────────────────────────┐
│  🏆 Carolina Kickoff 2025                               │
│  Jan 25-26 • Durham, NC                                 │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  [Live Games] [Standings] [Schedule] [Teams]           │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  🔴 LIVE NOW (4 games)                                  │
│                                                         │
│  ┌─────────────────────────────────────────────┐       │
│  │  Ring of Fire 8 - 7 Truck Stop              │       │
│  │  Field 1 • 42:18 • Men's QF                 │       │
│  │  [Watch →]                                   │       │
│  └─────────────────────────────────────────────┘       │
│                                                         │
│  ┌─────────────────────────────────────────────┐       │
│  │  Fury 10 - 6 Brute Squad                    │       │
│  │  Field 2 • 55:30 • Women's QF               │       │
│  │  [Watch →]                                   │       │
│  └─────────────────────────────────────────────┘       │
│                                                         │
│  ─────────────────────────────────────────────────────  │
│                                                         │
│  📊 MEN'S STANDINGS                                    │
│                                                         │
│  Pool A         Pool B         Pool C         Pool D   │
│  1. ROF (3-0)   1. TSP (3-0)   1. PON (2-1)  1. CHN   │
│  2. MAD (2-1)   2. RLH (2-1)   2. SUB (2-1)  2. DIG   │
│  ...            ...            ...            ...      │
│                                                         │
│  [View Full Standings]                                  │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

#### 1.2.3 Push Notifications for Fans

**Notification Types:**
```
🔔 GAME ALERTS
• Game starting soon: "ROF vs TSP starts in 15 min on Field 1"
• Score update: "ROF scores! 8-7 vs TSP"
• Game point: "GAME POINT: ROF leads 14-12 vs TSP"
• Upset alert: "UPSET! #8 seed Chain beats #1 seed Ring of Fire 15-13"

🏆 TOURNAMENT ALERTS
• Round starting: "Quarterfinals beginning on all fields"
• Bracket update: "Semifinals matchups are set"
• Spirit winner: "Spirit award: Truck Stop (avg 11.2)"
• Champion crowned: "Ring of Fire wins Carolina Kickoff!"

⚠️ SCHEDULE ALERTS
• Delay: "Round 3 delayed 30 minutes due to weather"
• Field change: "ROF vs TSP moved to Field 5"
• Cap warning: "Soft cap in effect for all active games"
```

### 1.3 USA Ultimate Integration

**Score Reporter Sync:**
```dart
class USAUIntegration {
  // Export game result to Score Reporter format
  Future<void> syncGameToScoreReporter(Game game) async {
    final result = GameResult(
      eventId: tournament.usauEventId,
      homeTeam: game.homeTeam.usauTeamId,
      awayTeam: game.awayTeam.usauTeamId,
      homeScore: game.homeScore,
      awayScore: game.awayScore,
      division: game.division,
      round: game.round,
      timestamp: game.completedAt,
    );
    
    // POST to Score Reporter API
    await usauApi.submitResult(result);
    
    // Also submit spirit scores
    await usauApi.submitSpirit(
      game.homeTeam.usauTeamId,
      game.spiritScoreForHome,
    );
    await usauApi.submitSpirit(
      game.awayTeam.usauTeamId,
      game.spiritScoreForAway,
    );
  }
}
```

**Rankings Algorithm Feed:**
- Export all sanctioned game results automatically
- Feed directly into USA Ultimate algorithm
- Reduce TD manual entry workload by 90%+

---

## Part 2: Advanced Technical Specifications

### 2.1 Complete Data Model Reference

```dart
// ============ CORE ENTITIES ============

@freezed
class Game with _$Game {
  const factory Game({
    required String id,
    required String homeTeamId,
    required String awayTeamId,
    required String homeTeamName,
    required String awayTeamName,
    required int homeScore,
    required int awayScore,
    required GameFormat format,
    required GameStatus status,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    String? tournamentId,
    String? fieldNumber,
    String? division,
    String? round,
    required List<Play> plays,
    required List<String> homeLineup,
    required List<String> awayLineup,
    SpiritScore? homeSpirit,
    SpiritScore? awaySpirit,
    required bool isSynced,
    DateTime? lastSyncedAt,
  }) = _Game;
}

@freezed
class Play with _$Play {
  const factory Play({
    required String id,
    required String gameId,
    required PlayType type,
    required DateTime timestamp,
    required Duration gameTime,
    required int pointNumber,
    required bool isOffense,
    String? primaryPlayerId,
    String? secondaryPlayerId,
    FieldZone? zone,
    Map<String, dynamic>? metadata,
  }) = _Play;
}

enum PlayType {
  // Offense
  pickup,
  pass,
  goal,
  drop,
  throwaway,
  stall,
  
  // Defense
  pullStart,
  pullLand,
  block,
  intercept,
  
  // Neutral
  foul,
  timeout,
  substitution,
  pointEnd,
  
  // Special
  callahan,
  injury,
}

@freezed
class SpiritScore with _$SpiritScore {
  const factory SpiritScore({
    required int rulesKnowledge,      // 0-4
    required int foulsAndContact,     // 0-4
    required int fairMindedness,      // 0-4
    required int attitudeSelfControl, // 0-4
    required int communication,       // 0-4
    String? comments,
    required String scoringTeamId,
    required String scoredTeamId,
  }) = _SpiritScore;
  
  int get total => rulesKnowledge + foulsAndContact + 
                   fairMindedness + attitudeSelfControl + communication;
}

@freezed
class Tournament with _$Tournament {
  const factory Tournament({
    required String id,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
    required String location,
    required String venue,
    String? logoUrl,
    required String organizerId,
    required List<TournamentDivision> divisions,
    required TournamentStatus status,
    String? usauEventId,
    TournamentSettings? settings,
  }) = _Tournament;
}

@freezed
class TournamentDivision with _$TournamentDivision {
  const factory TournamentDivision({
    required String id,
    required String tournamentId,
    required String name,
    required DivisionType type,
    required TournamentFormat format,
    required List<Pool> pools,
    required Bracket? bracket,
    required List<TournamentTeam> teams,
    required List<TournamentGame> games,
  }) = _TournamentDivision;
}

@freezed
class Pool with _$Pool {
  const factory Pool({
    required String id,
    required String name,
    required List<String> teamIds,
    required List<PoolGame> games,
  }) = _Pool;
}

@freezed
class Bracket with _$Bracket {
  const factory Bracket({
    required String id,
    required BracketType type,
    required List<BracketRound> rounds,
  }) = _Bracket;
}

// ============ USER & AUTH ============

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String displayName,
    String? photoUrl,
    String? jerseyNumber,
    PlayerPosition? position,
    required DateTime createdAt,
    required DateTime lastActiveAt,
    required UserSettings settings,
    required List<TeamMembership> teams,
    CareerStats? careerStats,
  }) = _User;
}

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    required bool profilePublic,
    required bool statsPublic,
    required bool showInSearch,
    required bool pushNotifications,
    required bool emailNotifications,
    required ThemeMode themeMode,
  }) = _UserSettings;
}

// ============ TEAM ============

@freezed  
class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    required String abbreviation,
    required String colorHex,
    String? logoUrl,
    required TeamDivision division,
    required TeamLevel level,
    required String city,
    required String state,
    required String currentSeason,
    required DateTime createdAt,
    required String ownerId,
    required List<TeamMember> members,
    String? usauTeamId,
  }) = _Team;
}

@freezed
class TeamMember with _$TeamMember {
  const factory TeamMember({
    required String id,
    required String teamId,
    required String userId,
    required TeamRole role,
    String? jerseyNumber,
    PlayerPosition? position,
    required DateTime joinedAt,
    required bool isActive,
  }) = _TeamMember;
}

enum TeamRole { owner, captain, player }
enum TeamDivision { mens, womens, mixed }
enum TeamLevel { club, collegeD1, collegeD3, youth, rec, masters }
enum PlayerPosition { handler, cutter, hybrid }
```

### 2.2 State Management Architecture

**Riverpod Provider Structure:**

```dart
// ============ AUTH PROVIDERS ============

@riverpod
class Auth extends _$Auth {
  @override
  Future<User?> build() async {
    return _getCurrentUser();
  }
  
  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _authService.signIn(email, password));
  }
  
  Future<void> signOut() async {
    await _authService.signOut();
    state = const AsyncData(null);
  }
}

// ============ GAME PROVIDERS ============

@riverpod
class ActiveGame extends _$ActiveGame {
  @override
  GameState build() => GameState.initial();
  
  void startGame(GameSetup setup) {
    state = GameState.fromSetup(setup);
    _persistLocally();
  }
  
  void logPlay(Play play) {
    state = state.copyWith(
      plays: [...state.plays, play],
      undoStack: [...state.undoStack.takeLast(9), state],
    );
    _updateScore(play);
    _persistLocally();
    _attemptSync();
  }
  
  void undo() {
    if (state.undoStack.isEmpty) return;
    final previous = state.undoStack.last;
    state = previous.copyWith(
      redoStack: [...state.redoStack, state],
      undoStack: state.undoStack.sublist(0, state.undoStack.length - 1),
    );
    _persistLocally();
  }
  
  void redo() {
    if (state.redoStack.isEmpty) return;
    final next = state.redoStack.last;
    state = next.copyWith(
      undoStack: [...state.undoStack, state],
      redoStack: state.redoStack.sublist(0, state.redoStack.length - 1),
    );
    _persistLocally();
  }
  
  Future<void> _persistLocally() async {
    await _localDb.saveGame(state.toGame());
  }
  
  Future<void> _attemptSync() async {
    if (await _connectivity.hasConnection) {
      await _syncService.syncGame(state.toGame());
    }
  }
}

// ============ TEAM PROVIDERS ============

@riverpod
Future<List<Team>> myTeams(MyTeamsRef ref) async {
  final user = await ref.watch(authProvider.future);
  if (user == null) return [];
  return _teamRepository.getTeamsForUser(user.id);
}

@riverpod
class TeamDetail extends _$TeamDetail {
  @override
  Future<Team> build(String teamId) async {
    return _teamRepository.getTeam(teamId);
  }
  
  Future<void> addMember(String email) async {
    await _teamRepository.inviteMember(state.value!.id, email);
  }
  
  Future<void> removeMember(String memberId) async {
    await _teamRepository.removeMember(state.value!.id, memberId);
    ref.invalidateSelf();
  }
}

// ============ TOURNAMENT PROVIDERS ============

@riverpod
Stream<Tournament> tournamentStream(TournamentStreamRef ref, String tournamentId) {
  return _tournamentRepository.watchTournament(tournamentId);
}

@riverpod
Stream<List<Game>> tournamentGames(TournamentGamesRef ref, String tournamentId) {
  return _gameRepository.watchGamesForTournament(tournamentId);
}
```

### 2.3 Offline Sync Architecture

**Sync Engine Design:**

```dart
class SyncEngine {
  final LocalDatabase _localDb;
  final RemoteDatabase _remoteDb;
  final ConnectivityService _connectivity;
  
  // Queued operations waiting for sync
  final Queue<SyncOperation> _pendingOperations = Queue();
  
  // Sync status stream
  final _statusController = StreamController<SyncStatus>.broadcast();
  Stream<SyncStatus> get statusStream => _statusController.stream;
  
  Future<void> initialize() async {
    // Load pending operations from disk
    _pendingOperations.addAll(await _localDb.getPendingOperations());
    
    // Listen for connectivity changes
    _connectivity.onConnectivityChanged.listen((connected) {
      if (connected) {
        _processPendingOperations();
      }
    });
    
    // Attempt initial sync
    if (await _connectivity.hasConnection) {
      _processPendingOperations();
    }
  }
  
  Future<void> queueOperation(SyncOperation operation) async {
    // Save locally first (always)
    await _localDb.saveOperation(operation);
    _pendingOperations.add(operation);
    
    // Attempt immediate sync if connected
    if (await _connectivity.hasConnection) {
      _processPendingOperations();
    }
  }
  
  Future<void> _processPendingOperations() async {
    _statusController.add(SyncStatus.syncing);
    
    while (_pendingOperations.isNotEmpty) {
      final operation = _pendingOperations.first;
      
      try {
        await _executeOperation(operation);
        _pendingOperations.removeFirst();
        await _localDb.markOperationComplete(operation.id);
      } catch (e) {
        if (_isRetryableError(e)) {
          // Will retry on next connectivity event
          break;
        } else {
          // Permanent failure - log and skip
          _logError(e, operation);
          _pendingOperations.removeFirst();
          await _localDb.markOperationFailed(operation.id, e.toString());
        }
      }
    }
    
    _statusController.add(
      _pendingOperations.isEmpty ? SyncStatus.synced : SyncStatus.pending
    );
  }
  
  Future<void> _executeOperation(SyncOperation operation) async {
    switch (operation.type) {
      case SyncOperationType.createGame:
        await _remoteDb.createGame(operation.data as Game);
        break;
      case SyncOperationType.updateGame:
        await _remoteDb.updateGame(operation.data as Game);
        break;
      case SyncOperationType.addPlay:
        await _remoteDb.addPlay(operation.gameId!, operation.data as Play);
        break;
      case SyncOperationType.createTeam:
        await _remoteDb.createTeam(operation.data as Team);
        break;
      // ... more operation types
    }
  }
}

enum SyncStatus { synced, syncing, pending, error }

class SyncOperation {
  final String id;
  final SyncOperationType type;
  final dynamic data;
  final String? gameId;
  final DateTime createdAt;
}
```

### 2.4 Real-Time Updates (Firestore)

**Live Game Subscription:**

```dart
class GameRepository {
  final FirebaseFirestore _firestore;
  
  // Watch single game (for spectators)
  Stream<Game> watchGame(String gameId) {
    return _firestore
        .collection('games')
        .doc(gameId)
        .snapshots()
        .map((doc) => Game.fromFirestore(doc));
  }
  
  // Watch game plays (for live play-by-play)
  Stream<List<Play>> watchPlays(String gameId) {
    return _firestore
        .collection('games')
        .doc(gameId)
        .collection('plays')
        .orderBy('timestamp', descending: true)
        .limit(50)  // Only recent plays
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Play.fromFirestore(doc))
            .toList());
  }
  
  // Watch tournament games (for TD dashboard)
  Stream<List<Game>> watchTournamentGames(String tournamentId) {
    return _firestore
        .collection('games')
        .where('tournamentId', isEqualTo: tournamentId)
        .where('status', isEqualTo: 'active')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Game.fromFirestore(doc))
            .toList());
  }
  
  // Batch write for efficiency
  Future<void> addPlay(String gameId, Play play) async {
    final batch = _firestore.batch();
    
    // Add play document
    final playRef = _firestore
        .collection('games')
        .doc(gameId)
        .collection('plays')
        .doc(play.id);
    batch.set(playRef, play.toFirestore());
    
    // Update game document (score, etc.)
    final gameRef = _firestore.collection('games').doc(gameId);
    batch.update(gameRef, {
      'homeScore': FieldValue.increment(play.isHomeGoal ? 1 : 0),
      'awayScore': FieldValue.increment(play.isAwayGoal ? 1 : 0),
      'lastPlayAt': FieldValue.serverTimestamp(),
    });
    
    await batch.commit();
  }
}
```

### 2.5 Push Notification System

**Firebase Cloud Messaging Setup:**

```dart
class NotificationService {
  final FirebaseMessaging _messaging;
  final LocalNotifications _localNotifications;
  
  Future<void> initialize() async {
    // Request permissions
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    
    // Get FCM token
    final token = await _messaging.getToken();
    await _saveTokenToBackend(token);
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Handle background/terminated messages
    FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
  }
  
  Future<void> subscribeToGame(String gameId) async {
    await _messaging.subscribeToTopic('game_$gameId');
  }
  
  Future<void> subscribeToTournament(String tournamentId) async {
    await _messaging.subscribeToTopic('tournament_$tournamentId');
  }
  
  Future<void> subscribeToTeam(String teamId) async {
    await _messaging.subscribeToTopic('team_$teamId');
  }
  
  void _handleForegroundMessage(RemoteMessage message) {
    // Show local notification
    _localNotifications.show(
      id: message.hashCode,
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      payload: message.data['gameId'],
    );
  }
}

// Cloud Function to send notifications
// (Deployed to Firebase Functions)
exports.onGoalScored = functions.firestore
  .document('games/{gameId}/plays/{playId}')
  .onCreate(async (snap, context) => {
    const play = snap.data();
    if (play.type !== 'goal') return;
    
    const gameId = context.params.gameId;
    const game = await admin.firestore()
      .collection('games')
      .doc(gameId)
      .get();
    
    const gameData = game.data();
    
    await admin.messaging().sendToTopic(`game_${gameId}`, {
      notification: {
        title: `${gameData.homeTeamName} ${gameData.homeScore} - ${gameData.awayScore} ${gameData.awayTeamName}`,
        body: `⭐ Goal by #${play.primaryPlayerId}!`,
      },
      data: {
        gameId: gameId,
        type: 'goal',
      },
    });
  });
```

---

## Part 3: Testing & Quality Assurance

### 3.1 Testing Strategy by Phase

**Phase 1 Testing Matrix:**

| Feature | Unit Tests | Widget Tests | Integration | Manual QA |
|---------|------------|--------------|-------------|-----------|
| Game state machine | ✅ | — | ✅ | ✅ |
| Play logging | ✅ | ✅ | ✅ | ✅ |
| Undo/redo | ✅ | ✅ | — | ✅ |
| Score calculation | ✅ | — | — | ✅ |
| Game clock | ✅ | ✅ | — | ✅ |
| Offline storage | ✅ | — | ✅ | ✅ |
| UI responsiveness | — | ✅ | — | ✅ |
| Field conditions | — | — | — | ✅ |

**Critical Manual QA Scenarios:**
1. Track complete game (15+ points) without errors
2. Rapid action sequences (3+ taps/second)
3. Airplane mode → full game → reconnect → verify sync
4. Low battery mode behavior
5. Direct sunlight readability
6. Wet finger touch accuracy
7. Glove operation (winter conditions)

### 3.2 Performance Benchmarks

**Target Metrics:**

| Metric | Target | Measurement Method |
|--------|--------|-------------------|
| App launch time | < 2s | Firebase Performance |
| Play log response | < 100ms | Custom trace |
| UI frame rate | 60fps | Flutter DevTools |
| Memory usage | < 150MB | Profiler |
| Battery drain | < 10%/hour | Field testing |
| Offline storage | < 50MB/game | Storage analysis |
| Sync time (game) | < 5s | Network trace |

### 3.3 Accessibility Checklist

**WCAG 2.1 Compliance:**

- [ ] All touch targets ≥ 44×44pt
- [ ] Color contrast ≥ 4.5:1 (text), ≥ 3:1 (UI)
- [ ] No information conveyed by color alone
- [ ] Screen reader labels for all interactive elements
- [ ] Focus indicators visible
- [ ] Text scalable to 200%
- [ ] No horizontal scrolling at 400% zoom
- [ ] Captions for any audio/video content
- [ ] Reduced motion option

---

## Conclusion

This document extends the Phase 1 & 2 Development Guide with:

1. **Phase 3 Preview**: Tournament Director features, spectator experience, and USA Ultimate integration
2. **Complete Data Models**: Every entity with Freezed/Dart definitions
3. **State Management**: Riverpod provider architecture
4. **Offline Sync**: Queue-based sync engine with conflict resolution
5. **Real-Time Updates**: Firestore streaming subscriptions
6. **Push Notifications**: FCM setup with Cloud Functions
7. **Testing Strategy**: Comprehensive QA matrix and benchmarks

The technical foundation is designed to scale from solo game tracking to thousands of concurrent tournament spectators. The architecture prioritizes offline reliability, real-time collaboration, and seamless USA Ultimate integration.

**Next Steps:**
1. Implement Phase 1 with the enhanced data models
2. Build offline storage layer first (Hive)
3. Add sync infrastructure in parallel
4. Test extensively in field conditions
5. Beta launch with 5 trusted tournaments

Ultimate Hub is positioned to become the definitive platform for Ultimate Frisbee. Execute with excellence.
