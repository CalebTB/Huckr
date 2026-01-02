# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Ultimate Hub is an ultimate frisbee tournament management and live game tracking app built with Flutter and Firebase. The goal is to become the all-in-one platform for ultimate frisbee, filling the gap left by abandoned apps (UltiAnalytics removed from Google Play March 2024), clunky governing body software (USA Ultimate Score Reporter), and persistent spreadsheet workflows.

**Target Market**: 63,000+ USA Ultimate members, 3+ million casual players, highly educated demographic (90% attended university), spending ~$1,000 annually on the sport.

## Build & Development Commands

```bash
# Navigate to Flutter project
cd ultimate_hub

# Get dependencies
flutter pub get

# Run code generation (freezed, json_serializable, riverpod_generator, hive_generator)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run

# Run all tests
flutter test

# Run a single test file
flutter test test/widget_test.dart

# Analyze code for issues
flutter analyze

# iOS specific (from ultimate_hub/ios directory)
pod install
```

## Architecture

### Clean Architecture Layers

Each feature follows a three-layer structure:
- **data/**: Data sources, models, repository implementations
- **domain/**: Entities (freezed), repository interfaces, use cases
- **presentation/**: Providers (Riverpod), screens, widgets

### Key Directories

```
ultimate_hub/lib/
├── core/                 # Shared utilities, theme, constants, enums
│   ├── constants/        # Field dimensions, game rules, wind conditions
│   ├── enums/            # GameStatus, PlayType, LineType, Division, etc.
│   ├── theme/            # Golden Hour theme (app_theme.dart)
│   └── domain/entities/  # Shared entities (Team, Player)
├── features/
│   ├── home/             # Home screen
│   └── live_game/        # Phase 1: Live game tracking (primary feature)
│       ├── domain/entities/  # Game, Play entities
│       └── presentation/
│           ├── screens/      # GameSetup, LiveTracking, GameSummary
│           └── widgets/      # FieldCanvas, ScoreBoard, ActionButtons, etc.
├── router/               # GoRouter configuration
└── main.dart
```

### State Management & Data

- **State Management**: Riverpod 2.0 with code generation
- **Local Storage**: Hive (offline-first, critical for field use without connectivity)
- **Remote**: Firebase (Firestore + Realtime Database for live tracking)
- **Code Generation**: Freezed for immutable entities, JSON serialization

## Development Phases

### Phase 1: Live Game Tracking (Current)
- Single-user stat tracking that works offline
- Pre-game setup (teams, game format, caps, starting side)
- Offense/defense state management with contextual action buttons
- Pull tracking with hang time measurement
- Play-by-play logging with undo/edit capabilities
- End-of-game summary with top performers

### Phase 2: Team & Player Management
- Authentication (Firebase Auth)
- Team creation and roster management
- Player profiles with career stats across seasons
- Spirit of the Game scoring (WFDF 5-category system)

### Phase 3: Tournament Management
- Tournament Director dashboard
- Schedule builder with pool play → bracket formats
- Automatic tiebreaker calculations (USA Ultimate rules)
- Live spectator experience (ESPN-style field visualization)
- Real-time bracket advancement

## Theme System

Uses "Golden Hour" theme - warm sunset & amber glow inspired by late-afternoon Ultimate games:

**Dark Mode (Default - optimized for outdoor/sunlight use)**:
- Background: `#0D0906`
- Surface/Card: `#1E1810`
- Accent (Amber): `#F59E0B`
- Success (Goals): `#22C55E`
- Error (Turnovers): `#EF4444`

See `lib/core/theme/app_theme.dart` and `mock_designs/GoldenHourThemeGuide.md`

## Ultimate-Specific Features

These sport-specific features differentiate Ultimate Hub from generic sports apps:

- **Spirit of the Game Scoring**: WFDF 5-category system (Rules Knowledge, Fouls/Contact, Fair-mindedness, Attitude, Communication), 0-4 points per category
- **Gender Ratio Tracking**: For mixed division play, rules specify ratios of male-matching/female-matching players
- **O-Line/D-Line Management**: Ultimate substitutes entire 7-player lines between points, not individuals
- **Pull Analytics**: Pull distance, hang time, in-bounds accuracy, field position
- **Soft/Hard Cap Timers**: Automatic point-to-win calculations when caps hit
- **Hockey Assists**: The pass before the assist (unique to Ultimate stats)

## Available Agents

Use specialized agents for domain expertise:

| Task | Agent |
|------|-------|
| Widget/screen implementation | `flutter-expert` |
| Database/auth design | `firebase-expert` |
| Rule accuracy & player perspective | `ultimate-frisbee-guru` |
| Issue/branch/commit/PR | `github-project-orchestrator` |
| UI design decisions | `ui-design-expert` |

## Git Conventions

**Commit messages**: `type(scope): description (#issue-number)`
- Types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`

**Branch names**: `type/issue-number-brief-description`

**Issue titles**: `[TYPE] Component: Brief descriptive title`

## Quality Gates

Before committing:
1. Build must pass: `flutter build`
2. Tests must pass: `flutter test`
3. No lint errors: `flutter analyze`

## Key Design Principles

1. **Offline-First**: App must work flawlessly without internet. Sync is a bonus.
2. **Field-Ready Design**: Large touch targets, high contrast, works with gloves/sunlight/divided attention
3. **Progressive Disclosure**: Simple by default, powerful when needed
4. **Contextual Actions**: Show relevant buttons based on game state (offense/defense, disc holder, etc.)

## Key Documentation Files

- `ARCHITECTURE.md` - Full technical architecture and database schema
- `mock_designs/GoldenHourThemeGuide.md` - Complete theme specification
- `UltimateHub_Phase1_Phase2_Development_Guide.md` - Detailed Phase 1 & 2 specs
- `UltimateHub_Phase3_TechnicalSpecs.md` - Tournament management specs
- `compass_artifact_*.md` - Market analysis and business strategy

## Ultimate Frisbee Domain Notes

- Field dimensions: 100m x 37m with 18m end zones (WFDF) or 70yds x 40yds with 20yd end zones (USAU)
- Standard game: first to 15 points, win by 2
- Soft cap: adds 1-2 to higher score when time expires
- Hard cap: next point wins when time expires
- Stall count: 10 seconds (USAU/WFDF rules)
- Line types: O-Line (offense) and D-Line (defense)
- 7 players per team on field
