# Ultimate Tournament Hub - Architecture Document

## Overview

A comprehensive Flutter application for managing ultimate frisbee tournaments, teams, and live game tracking with real-time updates and offline support.

---

## Tech Stack

### Frontend (Mobile App)
- **Framework**: Flutter 3.x (Dart)
- **State Management**: Riverpod 2.0 with code generation
- **Local Database**: Hive (offline-first, fast NoSQL)
- **Real-time Sync**: Supabase Realtime
- **Authentication**: Supabase Auth

### Backend: Supabase (Selected)

```
┌─────────────────────────────────────────────────────┐
│                   SUPABASE                          │
├─────────────────────────────────────────────────────┤
│  PostgreSQL      │  Auth       │  Realtime         │
│  (Main Database) │  (Users)    │  (WebSockets)     │
├─────────────────────────────────────────────────────┤
│  Edge Functions  │  Storage    │  Self-hostable    │
│  (Business Logic)│  (Media)    │  (Full control)   │
└─────────────────────────────────────────────────────┘
```

**Why Supabase:**
- Open-source with PostgreSQL power
- MCP integration for development workflow
- Self-hostable for long-term control
- Predictable pricing model
- Built-in Row-Level Security (RLS)
- Realtime subscriptions for live tracking
- Excellent Flutter SDK (supabase_flutter)

**Offline-First Strategy:**
- Local writes to Hive (immediate UI response)
- Background sync to Supabase when online
- Conflict resolution via timestamps and UUIDs

---

## Application Architecture

### Clean Architecture with Feature-First Structure

```
lib/
├── main.dart
├── app.dart
│
├── core/                          # Shared utilities
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── field_dimensions.dart  # Ultimate field specs
│   │   └── game_rules.dart        # Caps, timeouts, etc.
│   ├── errors/
│   │   └── failures.dart
│   ├── network/
│   │   └── network_info.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── colors.dart
│   │   └── typography.dart
│   ├── utils/
│   │   ├── date_utils.dart
│   │   └── validators.dart
│   └── widgets/                   # Shared widgets
│       ├── field_visualizer.dart
│       ├── score_display.dart
│       └── player_avatar.dart
│
├── features/
│   │
│   ├── auth/                      # Authentication
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── providers/
│   │       ├── screens/
│   │       └── widgets/
│   │
│   ├── live_game/                 # PHASE 1: Live Game Tracking
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── game_local_datasource.dart
│   │   │   │   └── game_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   ├── game_model.dart
│   │   │   │   ├── play_model.dart
│   │   │   │   └── game_event_model.dart
│   │   │   └── repositories/
│   │   │       └── game_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── game.dart
│   │   │   │   ├── play.dart
│   │   │   │   ├── field_position.dart
│   │   │   │   └── game_event.dart
│   │   │   ├── repositories/
│   │   │   │   └── game_repository.dart
│   │   │   └── usecases/
│   │   │       ├── start_game.dart
│   │   │       ├── record_play.dart
│   │   │       ├── end_point.dart
│   │   │       └── sync_game.dart
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── game_provider.dart
│   │       │   ├── game_clock_provider.dart
│   │       │   └── live_tracking_provider.dart
│   │       ├── screens/
│   │       │   ├── game_setup_screen.dart
│   │       │   ├── live_tracking_screen.dart
│   │       │   ├── field_tracker_screen.dart
│   │       │   └── game_summary_screen.dart
│   │       └── widgets/
│   │           ├── field_canvas.dart
│   │           ├── player_on_field.dart
│   │           ├── play_by_play_feed.dart
│   │           ├── game_clock.dart
│   │           ├── score_board.dart
│   │           └── action_buttons.dart
│   │
│   ├── teams/                     # PHASE 2: Team Management
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── players/                   # PHASE 2: Player Profiles
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── stats/                     # PHASE 2: Statistics & Analytics
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── tournaments/               # PHASE 3: Tournament Management
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── services/
│   ├── sync_service.dart          # Offline sync manager
│   ├── notification_service.dart
│   └── analytics_service.dart
│
└── router/
    └── app_router.dart            # Navigation (go_router)
```

---

## Database Schema

### Core Entities

```
┌─────────────────────────────────────────────────────────────────┐
│                         DATA MODEL                               │
└─────────────────────────────────────────────────────────────────┘

┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│    USER      │       │    TEAM      │       │  TOURNAMENT  │
├──────────────┤       ├──────────────┤       ├──────────────┤
│ id           │       │ id           │       │ id           │
│ email        │◄──────│ captainId    │       │ tdId (User)  │
│ displayName  │       │ name         │◄──────│ name         │
│ avatarUrl    │       │ logoUrl      │       │ location     │
│ createdAt    │       │ division     │       │ startDate    │
└──────────────┘       │ type (Uni/   │       │ endDate      │
       │               │   Mixed/Open/│       │ status       │
       │               │   Women)     │       │ format       │
       ▼               │ createdAt    │       │ inviteOnly   │
┌──────────────┐       └──────────────┘       └──────────────┘
│ TEAM_MEMBER  │              │                      │
├──────────────┤              │                      │
│ id           │              │                      │
│ oderId       │◄─────────────┘                      │
│ teamId       │                                     │
│ role (player/│       ┌──────────────┐              │
│   captain/   │       │ TOURNAMENT_  │              │
│   manager)   │       │ TEAM         │◄─────────────┘
│ jerseyNumber │       ├──────────────┤
│ joinedAt     │       │ tournamentId │
└──────────────┘       │ teamId       │
                       │ seed         │
                       │ poolId       │
                       │ status       │
                       │ invitedAt    │
                       │ acceptedAt   │
                       └──────────────┘

┌──────────────────────────────────────────────────────────────────┐
│                         GAME TRACKING                            │
└──────────────────────────────────────────────────────────────────┘

┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│    GAME      │       │    POINT     │       │    PLAY      │
├──────────────┤       ├──────────────┤       ├──────────────┤
│ id           │       │ id           │       │ id           │
│ tournamentId │──┐    │ gameId       │──┐    │ pointId      │
│ homeTeamId   │  │    │ pointNumber  │  │    │ playNumber   │
│ awayTeamId   │  │    │ startingTeam │  │    │ playerId     │
│ homeScore    │  │    │ scoringTeam  │  │    │ type         │
│ awayScore    │  │    │ startTime    │  │    │   (catch/    │
│ status       │  │    │ endTime      │  │    │    throw/    │
│ scheduledAt  │  │    │ lineType     │  │    │    drop/     │
│ startedAt    │  │    │   (O/D)      │  │    │    turnover/ │
│ endedAt      │  │    │ turnovers    │  │    │    block/    │
│ softCapTime  │  │    └──────────────┘  │    │    goal/     │
│ hardCapTime  │  │           │          │    │    pull)     │
│ gameLengthMin│  │           │          │    │ fieldX       │
│ round        │  │           ▼          │    │ fieldY       │
│ poolId       │  │    ┌──────────────┐  │    │ timestamp    │
│ bracketPos   │  │    │  POINT_      │  │    │ fromPlayerId │
│ windSpeed    │  │    │  PLAYER      │  │    │ outcome      │
│ windDirection│  │    ├──────────────┤  │    └──────────────┘
│ isDelayed    │  │    │ pointId      │◄─┘
│ delayReason  │  │    │ playerId     │
└──────────────┘  │    │ teamId       │
                  │    │ onField      │
                  │    └──────────────┘
                  │
                  │    ┌──────────────┐
                  │    │ PLAYER_GAME_ │
                  │    │ STATS        │
                  │    ├──────────────┤
                  └───►│ gameId       │
                       │ playerId     │
                       │ teamId       │
                       │ goals        │
                       │ assists      │
                       │ blocks       │
                       │ turnovers    │
                       │ drops        │
                       │ catches      │
                       │ throws       │
                       │ pointsPlayed │
                       │ oPointsPlayed│
                       │ dPointsPlayed│
                       │ plusMinus    │
                       └──────────────┘

┌──────────────────────────────────────────────────────────────────┐
│                         TOURNAMENT                               │
└──────────────────────────────────────────────────────────────────┘

┌──────────────┐       ┌──────────────┐       ┌──────────────┐
│    POOL      │       │   BRACKET    │       │   DELAY      │
├──────────────┤       ├──────────────┤       ├──────────────┤
│ id           │       │ id           │       │ id           │
│ tournamentId │       │ tournamentId │       │ tournamentId │
│ name (A,B,C) │       │ type         │       │ reason       │
│ teams[]      │       │   (winners/  │       │ startTime    │
└──────────────┘       │    losers/   │       │ endTime      │
                       │    placement)│       │ affectedGames│
                       │ rounds       │       │ announcement │
                       │ games[]      │       └──────────────┘
                       └──────────────┘

┌──────────────┐
│ TOURNAMENT_  │
│ INVITE       │
├──────────────┤
│ id           │
│ tournamentId │
│ teamId       │
│ status       │
│   (pending/  │
│    accepted/ │
│    declined) │
│ sentAt       │
│ respondedAt  │
└──────────────┘
```

---

## Offline-First Architecture

### Sync Strategy

```
┌─────────────────────────────────────────────────────────────────┐
│                    OFFLINE-FIRST FLOW                           │
└─────────────────────────────────────────────────────────────────┘

┌──────────────┐      ┌──────────────┐      ┌──────────────┐
│   UI LAYER   │      │  LOCAL DB    │      │  REMOTE DB   │
│   (Flutter)  │      │   (Hive)     │      │  (Supabase)  │
└──────┬───────┘      └──────┬───────┘      └──────┬───────┘
       │                     │                     │
       │  1. User Action     │                     │
       │─────────────────────►                     │
       │                     │                     │
       │  2. Immediate       │                     │
       │     Response        │                     │
       │◄─────────────────────                     │
       │                     │                     │
       │                     │  3. Background Sync │
       │                     │     (when online)   │
       │                     │─────────────────────►
       │                     │                     │
       │                     │  4. Sync Response   │
       │                     │◄─────────────────────
       │                     │                     │
       │  5. Update if       │                     │
       │     conflicts       │                     │
       │◄─────────────────────                     │
       │                     │                     │
```

### Conflict Resolution for Live Games

```dart
// When two people track the same game offline:
// - Use timestamp-based last-write-wins for simple fields
// - Use CRDT (Conflict-free Replicated Data Types) for play events
// - Each play gets a unique UUID + timestamp
// - Plays are append-only, never modified
// - Merge by sorting all plays by timestamp
```

---

## Real-Time Live Tracking Flow

### ESPN-Style Field Tracking

```
┌─────────────────────────────────────────────────────────────────┐
│                    LIVE TRACKING FLOW                           │
└─────────────────────────────────────────────────────────────────┘

TRACKER DEVICE                           VIEWER DEVICES
┌──────────────┐                        ┌──────────────┐
│              │                        │              │
│  Tap on      │   1. Record Play      │  See disc    │
│  field to    │──────────────────────►│  position    │
│  mark disc   │                        │  update      │
│  position    │   2. Supabase          │  live        │
│              │      Realtime          │              │
│  Select      │                        │  Play-by-    │
│  action      │   3. Broadcast to      │  play feed   │
│  (catch,     │      all listeners     │  updates     │
│  throw,      │──────────────────────►│              │
│  turnover)   │                        │  Stats       │
│              │                        │  update      │
└──────────────┘                        └──────────────┘

Data pushed to Supabase with Realtime subscriptions:
INSERT INTO plays (game_id, play_type, field_x, field_y, ...)
→ Triggers Realtime notification to all subscribed clients
→ Clients receive play event and update UI
```

---

## Key Flutter Packages

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3

  # Supabase Backend
  supabase_flutter: ^2.3.0

  # Local Storage (Offline)
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Navigation
  go_router: ^13.0.0
  
  # UI
  flutter_animate: ^4.3.0
  google_fonts: ^6.1.0
  fl_chart: ^0.66.0           # For stats charts
  
  # Field Visualization
  flutter_svg: ^2.0.9
  custom_painter: built-in    # For field canvas
  
  # Utilities
  uuid: ^4.2.1
  intl: ^0.18.1
  connectivity_plus: ^5.0.2
  
  # Code Generation
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  riverpod_generator: ^2.3.9
  hive_generator: ^2.0.1
```

---

## Phase 1 Features: Live Game Tracking

### Core Screens

1. **Game Setup Screen**
   - Select teams (or quick add)
   - Set game parameters (caps, length)
   - Select starting line
   - Record wind conditions

2. **Live Tracking Screen**
   - Interactive field canvas
   - Tap to mark disc position
   - Action buttons (Catch, Throw, Drop, Turn, D, Goal)
   - Current score display
   - Game clock with cap timers
   - Players on field sidebar

3. **Play-by-Play Feed**
   - Scrollable list of all plays
   - Each play shows: player, action, position, time
   - Undo capability

4. **Game Summary Screen**
   - Final score
   - Team stats comparison
   - Individual player stats
   - Point-by-point breakdown
   - Option to upload/sync

### Tracking Actions

| Action | What it Records | Derived Stats |
|--------|-----------------|---------------|
| **Pull** | Who pulled, hang time, landing position | Pull distance |
| **Catch** | Who caught, position on field | Catches, completion % |
| **Throw** | Who threw (auto from last catch) | Throws, completion % |
| **Drop** | Who dropped, position | Drops |
| **Turnover** | Type (throwaway/stall/OB), position | Turnovers |
| **Block (D)** | Who got D, position | Blocks |
| **Goal** | Scorer + Assister (auto from last 2 touches) | Goals, Assists |
| **Timeout** | Which team, time remaining | - |
| **Sub** | Players in/out | Points played |

---

## Next Steps

1. **Set up Flutter project with folder structure**
2. **Create core data models (Game, Play, Player, Team) with Freezed**
3. **Configure Supabase project and database schema**
4. **Implement local storage with Hive**
5. **Build data layer with offline-first repositories**
6. **Build the field canvas widget**
7. **Build the live tracking screen**
8. **Integrate Supabase Realtime for live updates**

See GitHub Issues for detailed Phase 1 implementation tasks.
