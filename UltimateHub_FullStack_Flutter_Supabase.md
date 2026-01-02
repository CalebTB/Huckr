# Ultimate Hub: Full Stack Architecture
## Flutter + Supabase Technical Documentation

*Version 1.0 | January 2026*

---

## Table of Contents

1. [Architecture Overview](#1-architecture-overview)
2. [Technology Stack](#2-technology-stack)
3. [Project Structure](#3-project-structure)
4. [Supabase Setup](#4-supabase-setup)
5. [Database Schema](#5-database-schema)
6. [Authentication](#6-authentication)
7. [Row-Level Security (RLS)](#7-row-level-security-rls)
8. [Realtime Subscriptions](#8-realtime-subscriptions)
9. [Offline Sync Strategy](#9-offline-sync-strategy)
10. [API Layer & Repository Pattern](#10-api-layer--repository-pattern)
11. [State Management](#11-state-management)
12. [File Storage](#12-file-storage)
13. [Edge Functions](#13-edge-functions)
14. [Push Notifications](#14-push-notifications)
15. [Deployment & DevOps](#15-deployment--devops)
16. [Development Workflow](#16-development-workflow)
17. [Testing Strategy](#17-testing-strategy)
18. [Performance Optimization](#18-performance-optimization)
19. [Migration Path](#19-migration-path)

---

## 1. Architecture Overview

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           CLIENT LAYER                                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐    │
│  │   iOS App   │  │ Android App │  │   Web App   │  │ Desktop App │    │
│  │  (Flutter)  │  │  (Flutter)  │  │  (Flutter)  │  │  (Flutter)  │    │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘    │
│         │                │                │                │            │
│         └────────────────┴────────────────┴────────────────┘            │
│                                   │                                      │
│  ┌────────────────────────────────┴────────────────────────────────┐   │
│  │                    LOCAL STORAGE (SQLite)                        │   │
│  │              Offline-first with Brick/PowerSync                  │   │
│  └────────────────────────────────┬────────────────────────────────┘   │
└───────────────────────────────────┼─────────────────────────────────────┘
                                    │
                              ┌─────┴─────┐
                              │  INTERNET │
                              └─────┬─────┘
                                    │
┌───────────────────────────────────┼─────────────────────────────────────┐
│                           SUPABASE LAYER                                 │
│                                   │                                      │
│  ┌────────────────────────────────┴────────────────────────────────┐   │
│  │                         API GATEWAY                              │   │
│  │                    (PostgREST + GoTrue)                          │   │
│  └────────────────────────────────┬────────────────────────────────┘   │
│                                   │                                      │
│  ┌───────────────┬────────────────┼────────────────┬───────────────┐   │
│  │               │                │                │               │    │
│  │  ┌─────────┐  │  ┌──────────┐  │  ┌──────────┐  │  ┌─────────┐  │   │
│  │  │  Auth   │  │  │ Realtime │  │  │ Storage  │  │  │  Edge   │  │   │
│  │  │(GoTrue) │  │  │(Postgres │  │  │  (S3)    │  │  │Functions│  │   │
│  │  │         │  │  │ Changes) │  │  │          │  │  │ (Deno)  │  │   │
│  │  └─────────┘  │  └──────────┘  │  └──────────┘  │  └─────────┘  │   │
│  │               │                │                │               │    │
│  └───────────────┴────────────────┼────────────────┴───────────────┘   │
│                                   │                                      │
│  ┌────────────────────────────────┴────────────────────────────────┐   │
│  │                     POSTGRESQL DATABASE                          │   │
│  │           Row-Level Security • Triggers • Functions              │   │
│  └─────────────────────────────────────────────────────────────────┘   │
│                                                                          │
└──────────────────────────────────────────────────────────────────────────┘
```

### Design Principles

| Principle | Implementation |
|-----------|----------------|
| Offline-First | Local SQLite with sync engine; games fully playable without internet |
| Real-time | Supabase Realtime for spectator views, live dashboards |
| Type-Safe | Freezed models, generated Supabase types |
| Secure | Row-Level Security for all tables; no client-side trust |
| Scalable | Postgres can handle millions of plays; connection pooling via Supavisor |

---

## 2. Technology Stack

### Frontend (Flutter)

| Category | Technology | Purpose |
|----------|------------|---------|
| Framework | Flutter 3.24+ | Cross-platform UI |
| State Management | Riverpod 2.x | Reactive state with code generation |
| Data Classes | Freezed + json_serializable | Immutable models with JSON support |
| Local Database | SQLite (via drift or sqflite) | Offline storage |
| Offline Sync | PowerSync or Brick | Bidirectional sync with Supabase |
| HTTP Client | supabase_flutter | Official Supabase SDK |
| Routing | go_router | Declarative navigation |
| Forms | flutter_form_builder | Complex form handling |
| Testing | flutter_test, mocktail | Unit/widget/integration tests |

### Backend (Supabase)

| Component | Technology | Purpose |
|-----------|------------|---------|
| Database | PostgreSQL 15 | Primary data store |
| Auth | GoTrue | Authentication service |
| API | PostgREST | Auto-generated REST API |
| Realtime | Realtime Server | WebSocket subscriptions |
| Storage | S3-compatible | File uploads (logos, photos) |
| Functions | Deno Edge Functions | Custom server logic |
| Cron | pg_cron | Scheduled jobs |

### Dependencies (pubspec.yaml)

```yaml
name: ultimate_hub
description: The all-in-one platform for Ultimate Frisbee
version: 1.0.0+1

environment:
  sdk: '>=3.2.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # Supabase
  supabase_flutter: ^2.3.0
  
  # State Management
  flutter_riverpod: ^2.4.9
  riverpod_annotation: ^2.3.3
  
  # Data Classes
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  
  # Local Database & Offline Sync
  powersync: ^1.4.2           # OR brick_offline_first_with_supabase
  drift: ^2.14.1
  sqlite3_flutter_libs: ^0.5.18
  path_provider: ^2.1.1
  path: ^1.8.3
  
  # Routing
  go_router: ^13.0.1
  
  # UI Components
  flutter_svg: ^2.0.9
  cached_network_image: ^3.3.1
  
  # Utilities
  uuid: ^4.2.2
  intl: ^0.18.1
  collection: ^1.18.0
  logger: ^2.0.2+1
  
  # Platform
  url_launcher: ^6.2.2
  share_plus: ^7.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  
  # Code Generation
  build_runner: ^2.4.8
  freezed: ^2.4.6
  json_serializable: ^6.7.1
  riverpod_generator: ^2.3.9
  
  # Testing
  mocktail: ^1.0.1
  
flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
```

---

## 3. Project Structure

```
lib/
├── main.dart                          # App entry point
├── app.dart                           # MaterialApp configuration
│
├── core/                              # Shared utilities & config
│   ├── config/
│   │   ├── env.dart                   # Environment variables
│   │   ├── supabase_config.dart       # Supabase initialization
│   │   └── app_config.dart            # Feature flags, constants
│   │
│   ├── database/
│   │   ├── database.dart              # Drift database setup
│   │   ├── tables/                    # Local table definitions
│   │   └── daos/                      # Data access objects
│   │
│   ├── sync/
│   │   ├── sync_engine.dart           # PowerSync/Brick setup
│   │   ├── sync_rules.dart            # Sync conflict resolution
│   │   └── offline_queue.dart         # Pending operations queue
│   │
│   ├── network/
│   │   ├── api_client.dart            # Supabase client wrapper
│   │   ├── connectivity.dart          # Network status monitoring
│   │   └── api_exceptions.dart        # Custom exceptions
│   │
│   ├── theme/
│   │   ├── golden_hour_theme.dart     # App theme definition
│   │   ├── colors.dart                # Color palette
│   │   └── typography.dart            # Text styles
│   │
│   └── utils/
│       ├── extensions.dart            # Dart extensions
│       ├── validators.dart            # Form validation
│       └── formatters.dart            # Date/number formatting
│
├── features/                          # Feature modules
│   │
│   ├── auth/                          # Authentication
│   │   ├── data/
│   │   │   ├── auth_repository.dart
│   │   │   └── models/
│   │   │       └── user_profile.dart
│   │   ├── domain/
│   │   │   └── auth_service.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── login_screen.dart
│   │   │   │   ├── signup_screen.dart
│   │   │   │   └── profile_screen.dart
│   │   │   ├── widgets/
│   │   │   │   └── auth_form.dart
│   │   │   └── providers/
│   │   │       └── auth_provider.dart
│   │   └── auth.dart                  # Barrel export
│   │
│   ├── games/                         # Live Game Tracking (Phase 1)
│   │   ├── data/
│   │   │   ├── game_repository.dart
│   │   │   ├── play_repository.dart
│   │   │   └── models/
│   │   │       ├── game.dart
│   │   │       ├── game_setup.dart
│   │   │       ├── play.dart
│   │   │       ├── play_type.dart
│   │   │       └── game_state.dart
│   │   ├── domain/
│   │   │   ├── game_service.dart
│   │   │   └── stat_calculator.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── game_setup_screen.dart
│   │   │   │   ├── stat_tracker_screen.dart
│   │   │   │   ├── game_summary_screen.dart
│   │   │   │   └── spectator_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── field_canvas.dart
│   │   │   │   ├── player_grid.dart
│   │   │   │   ├── action_buttons.dart
│   │   │   │   ├── score_display.dart
│   │   │   │   ├── play_feed.dart
│   │   │   │   └── game_clock.dart
│   │   │   └── providers/
│   │   │       ├── game_provider.dart
│   │   │       ├── game_state_provider.dart
│   │   │       └── play_provider.dart
│   │   └── games.dart
│   │
│   ├── teams/                         # Team Management (Phase 2)
│   │   ├── data/
│   │   │   ├── team_repository.dart
│   │   │   └── models/
│   │   │       ├── team.dart
│   │   │       ├── team_member.dart
│   │   │       └── team_role.dart
│   │   ├── domain/
│   │   │   └── team_service.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── teams_list_screen.dart
│   │   │   │   ├── team_detail_screen.dart
│   │   │   │   ├── create_team_screen.dart
│   │   │   │   └── roster_screen.dart
│   │   │   ├── widgets/
│   │   │   └── providers/
│   │   └── teams.dart
│   │
│   ├── players/                       # Player Profiles (Phase 2)
│   │   ├── data/
│   │   │   ├── player_repository.dart
│   │   │   └── models/
│   │   │       ├── player.dart
│   │   │       └── career_stats.dart
│   │   ├── domain/
│   │   │   └── stats_aggregator.dart
│   │   ├── presentation/
│   │   └── players.dart
│   │
│   ├── tournaments/                   # Tournament Management (Phase 3)
│   │   ├── data/
│   │   │   ├── tournament_repository.dart
│   │   │   └── models/
│   │   │       ├── tournament.dart
│   │   │       ├── division.dart
│   │   │       ├── pool.dart
│   │   │       ├── bracket.dart
│   │   │       └── registration.dart
│   │   ├── domain/
│   │   │   ├── bracket_service.dart
│   │   │   ├── tiebreaker_calculator.dart
│   │   │   └── schedule_generator.dart
│   │   ├── presentation/
│   │   └── tournaments.dart
│   │
│   └── home/                          # Home Dashboard
│       ├── presentation/
│       │   ├── screens/
│       │   │   └── home_screen.dart
│       │   └── widgets/
│       │       ├── recent_games_card.dart
│       │       ├── my_teams_card.dart
│       │       └── upcoming_tournaments_card.dart
│       └── home.dart
│
├── shared/                            # Shared widgets & utilities
│   ├── widgets/
│   │   ├── loading_indicator.dart
│   │   ├── error_view.dart
│   │   ├── empty_state.dart
│   │   └── confirm_dialog.dart
│   └── providers/
│       └── connectivity_provider.dart
│
└── routing/
    ├── app_router.dart                # Route definitions
    └── route_guards.dart              # Auth guards
```

---

## 4. Supabase Setup

### 4.1 Project Initialization

```bash
# Install Supabase CLI
npm install -g supabase

# Initialize project
supabase init

# Start local development
supabase start

# Link to remote project
supabase link --project-ref your-project-ref
```

### 4.2 Flutter Configuration

**lib/core/config/supabase_config.dart**

```dart
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String _prodUrl = 'https://your-project.supabase.co';
  static const String _prodAnonKey = 'your-anon-key';
  
  static const String _localUrl = 'http://localhost:54321';
  static const String _localAnonKey = 'your-local-anon-key';
  
  static String get url => kDebugMode ? _localUrl : _prodUrl;
  static String get anonKey => kDebugMode ? _localAnonKey : _prodAnonKey;
  
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        logLevel: RealtimeLogLevel.info,
      ),
    );
  }
  
  static SupabaseClient get client => Supabase.instance.client;
  static GoTrueClient get auth => client.auth;
  static SupabaseStorageClient get storage => client.storage;
  static RealtimeClient get realtime => client.realtime;
}
```

**lib/main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/supabase_config.dart';
import 'core/sync/sync_engine.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  await SupabaseConfig.initialize();
  
  // Initialize offline sync engine
  await SyncEngine.initialize();
  
  runApp(
    const ProviderScope(
      child: UltimateHubApp(),
    ),
  );
}
```

---

## 5. Database Schema

### 5.1 Entity Relationship Diagram

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│     users       │     │     teams       │     │   tournaments   │
├─────────────────┤     ├─────────────────┤     ├─────────────────┤
│ id (PK)         │     │ id (PK)         │     │ id (PK)         │
│ email           │     │ name            │     │ name            │
│ display_name    │     │ abbreviation    │     │ start_date      │
│ avatar_url      │     │ division        │     │ end_date        │
│ position        │     │ level           │     │ location        │
│ created_at      │     │ logo_url        │     │ status          │
│ updated_at      │     │ owner_id (FK)   │────▶│ organizer_id    │
└────────┬────────┘     │ created_at      │     │ created_at      │
         │              └────────┬────────┘     └────────┬────────┘
         │                       │                       │
         │              ┌────────┴────────┐              │
         │              ▼                 ▼              │
         │     ┌─────────────────┐  ┌──────────────┐    │
         │     │  team_members   │  │  team_games  │    │
         │     ├─────────────────┤  ├──────────────┤    │
         └────▶│ id (PK)         │  │ team_id (FK) │◀───┤
               │ team_id (FK)    │  │ game_id (FK) │    │
               │ user_id (FK)    │  │ is_home      │    │
               │ jersey_number   │  └──────────────┘    │
               │ role            │         ▲            │
               │ joined_at       │         │            │
               └─────────────────┘         │            │
                                           │            │
                                  ┌────────┴────────┐   │
                                  │      games      │   │
                                  ├─────────────────┤   │
                                  │ id (PK)         │   │
                                  │ home_team_name  │   │
                                  │ away_team_name  │   │
                                  │ home_score      │   │
                                  │ away_score      │   │
                                  │ status          │   │
                                  │ game_to_score   │   │
                                  │ time_cap_mins   │   │
                                  │ started_at      │   │
                                  │ completed_at    │   │
                                  │ tournament_id   │◀──┘
                                  │ created_by      │
                                  │ created_at      │
                                  └────────┬────────┘
                                           │
                                  ┌────────┴────────┐
                                  │      plays      │
                                  ├─────────────────┤
                                  │ id (PK)         │
                                  │ game_id (FK)    │
                                  │ type            │
                                  │ primary_player  │
                                  │ secondary_player│
                                  │ team_side       │
                                  │ metadata (JSONB)│
                                  │ game_time_secs  │
                                  │ sequence_num    │
                                  │ created_at      │
                                  └─────────────────┘
```

### 5.2 SQL Schema Definitions

**supabase/migrations/20260102000000_initial_schema.sql**

```sql
-- ============================================================
-- ULTIMATE HUB DATABASE SCHEMA
-- Version 1.0 | Flutter + Supabase Stack
-- ============================================================

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";  -- For text search

-- ============================================================
-- ENUMS
-- ============================================================

CREATE TYPE user_position AS ENUM (
  'handler',
  'cutter',
  'hybrid',
  'unspecified'
);

CREATE TYPE team_division AS ENUM (
  'mens',
  'womens',
  'mixed'
);

CREATE TYPE team_level AS ENUM (
  'club',
  'college',
  'high_school',
  'youth',
  'masters',
  'recreational'
);

CREATE TYPE team_role AS ENUM (
  'owner',
  'captain',
  'coach',
  'player',
  'manager',
  'spectator'
);

CREATE TYPE game_status AS ENUM (
  'setup',
  'active',
  'halftime',
  'soft_cap',
  'hard_cap',
  'completed',
  'abandoned'
);

CREATE TYPE play_type AS ENUM (
  -- Offensive plays
  'pickup',
  'pass',
  'goal',
  'drop',
  'throwaway',
  'stall',
  -- Defensive plays
  'pull',
  'block',
  'interception',
  'callahan',
  -- Neutral plays
  'timeout',
  'injury',
  'end_of_point',
  'substitution',
  -- Fouls/Violations
  'foul',
  'violation',
  'contested_foul',
  'retracted_foul'
);

CREATE TYPE pull_result AS ENUM (
  'in_bounds',
  'out_of_bounds_brick',
  'out_of_bounds_sideline',
  'dropped'
);

CREATE TYPE tournament_status AS ENUM (
  'draft',
  'registration_open',
  'registration_closed',
  'active',
  'completed',
  'cancelled'
);

-- ============================================================
-- USERS TABLE (extends Supabase auth.users)
-- ============================================================

CREATE TABLE public.users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT UNIQUE NOT NULL,
  display_name TEXT NOT NULL,
  avatar_url TEXT,
  position user_position DEFAULT 'unspecified',
  bio TEXT,
  city TEXT,
  state TEXT,
  country TEXT DEFAULT 'USA',
  usau_id TEXT,  -- USA Ultimate member ID
  
  -- Notification preferences
  notifications_enabled BOOLEAN DEFAULT true,
  email_notifications BOOLEAN DEFAULT true,
  
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- Auto-create user profile on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.users (id, email, display_name)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'display_name', split_part(NEW.email, '@', 1))
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================================
-- TEAMS TABLE
-- ============================================================

CREATE TABLE public.teams (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  abbreviation TEXT NOT NULL CHECK (char_length(abbreviation) <= 4),
  division team_division NOT NULL,
  level team_level NOT NULL,
  logo_url TEXT,
  primary_color TEXT DEFAULT '#FF6B35',  -- Golden Hour orange
  secondary_color TEXT DEFAULT '#1A1A2E',
  city TEXT,
  state TEXT,
  country TEXT DEFAULT 'USA',
  usau_team_id TEXT,  -- USA Ultimate team ID
  
  owner_id UUID NOT NULL REFERENCES public.users(id) ON DELETE RESTRICT,
  
  is_public BOOLEAN DEFAULT true,  -- Discoverable in search
  
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  
  UNIQUE(name, division, level)
);

CREATE INDEX idx_teams_owner ON public.teams(owner_id);
CREATE INDEX idx_teams_search ON public.teams USING gin(name gin_trgm_ops);

-- ============================================================
-- TEAM MEMBERS TABLE
-- ============================================================

CREATE TABLE public.team_members (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  team_id UUID NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  
  jersey_number TEXT,
  role team_role NOT NULL DEFAULT 'player',
  
  is_active BOOLEAN DEFAULT true,
  joined_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  left_at TIMESTAMPTZ,
  
  -- Season tracking (for career stats)
  season_year INTEGER DEFAULT EXTRACT(YEAR FROM NOW()),
  
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  
  UNIQUE(team_id, user_id, season_year)
);

CREATE INDEX idx_team_members_team ON public.team_members(team_id);
CREATE INDEX idx_team_members_user ON public.team_members(user_id);

-- ============================================================
-- GAMES TABLE
-- ============================================================

CREATE TABLE public.games (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  
  -- Team information (names stored for flexibility)
  home_team_name TEXT NOT NULL,
  away_team_name TEXT NOT NULL,
  home_team_id UUID REFERENCES public.teams(id),
  away_team_id UUID REFERENCES public.teams(id),
  
  -- Score
  home_score INTEGER NOT NULL DEFAULT 0,
  away_score INTEGER NOT NULL DEFAULT 0,
  
  -- Game status
  status game_status NOT NULL DEFAULT 'setup',
  is_offense BOOLEAN NOT NULL DEFAULT true,  -- Current possession state
  current_point_number INTEGER DEFAULT 1,
  
  -- Game configuration
  game_to_score INTEGER NOT NULL DEFAULT 15,
  point_cap INTEGER,
  time_cap_minutes INTEGER,
  soft_cap_addition INTEGER DEFAULT 1,
  hard_cap_addition INTEGER DEFAULT 0,
  
  -- Timing
  started_at TIMESTAMPTZ,
  halftime_at TIMESTAMPTZ,
  soft_cap_at TIMESTAMPTZ,
  hard_cap_at TIMESTAMPTZ,
  completed_at TIMESTAMPTZ,
  
  -- Tournament context (nullable for standalone games)
  tournament_id UUID REFERENCES public.tournaments(id),
  pool_id UUID,
  bracket_round TEXT,
  field_number TEXT,
  
  -- Tracking metadata
  created_by UUID NOT NULL REFERENCES public.users(id),
  
  -- Offline sync support
  client_created_at TIMESTAMPTZ,  -- Client timestamp for conflict resolution
  sync_version INTEGER DEFAULT 1,
  
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

CREATE INDEX idx_games_status ON public.games(status);
CREATE INDEX idx_games_tournament ON public.games(tournament_id);
CREATE INDEX idx_games_created_by ON public.games(created_by);
CREATE INDEX idx_games_updated ON public.games(updated_at DESC);

-- ============================================================
-- GAME LINEUP TABLE (players in each game)
-- ============================================================

CREATE TABLE public.game_lineups (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  game_id UUID NOT NULL REFERENCES public.games(id) ON DELETE CASCADE,
  
  -- Player info (can be ad-hoc or linked to user)
  player_name TEXT NOT NULL,
  jersey_number TEXT,
  user_id UUID REFERENCES public.users(id),
  
  -- Which team this player is on for this game
  team_side TEXT NOT NULL CHECK (team_side IN ('home', 'away')),
  
  is_active BOOLEAN DEFAULT true,
  
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

CREATE INDEX idx_game_lineups_game ON public.game_lineups(game_id);
CREATE INDEX idx_game_lineups_user ON public.game_lineups(user_id);

-- ============================================================
-- PLAYS TABLE
-- ============================================================

CREATE TABLE public.plays (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  game_id UUID NOT NULL REFERENCES public.games(id) ON DELETE CASCADE,
  
  -- Play details
  type play_type NOT NULL,
  team_side TEXT NOT NULL CHECK (team_side IN ('home', 'away')),
  
  -- Players involved
  primary_player_id UUID REFERENCES public.game_lineups(id),
  secondary_player_id UUID REFERENCES public.game_lineups(id),  -- For passes: receiver
  
  -- Point context
  point_number INTEGER NOT NULL,
  
  -- Timing
  game_time_seconds INTEGER,  -- Seconds since game start
  
  -- Sequence within point (for ordering)
  sequence_number INTEGER NOT NULL,
  
  -- Additional data (varies by play type)
  metadata JSONB DEFAULT '{}',
  /*
    Examples:
    Pull: { "hang_time_ms": 3400, "result": "in_bounds", "pull_type": "IO" }
    Goal: { "assist": true }
    Turnover: { "forced": true }
    Foul: { "contested": false, "call": "strip" }
  */
  
  -- Offline sync
  client_created_at TIMESTAMPTZ,
  
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

CREATE INDEX idx_plays_game ON public.plays(game_id);
CREATE INDEX idx_plays_game_sequence ON public.plays(game_id, sequence_number);
CREATE INDEX idx_plays_type ON public.plays(type);

-- ============================================================
-- TOURNAMENTS TABLE
-- ============================================================

CREATE TABLE public.tournaments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  
  name TEXT NOT NULL,
  description TEXT,
  
  -- Dates
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  registration_deadline DATE,
  
  -- Location
  city TEXT NOT NULL,
  state TEXT,
  country TEXT DEFAULT 'USA',
  venue_name TEXT,
  venue_address TEXT,
  
  -- Status
  status tournament_status NOT NULL DEFAULT 'draft',
  
  -- Configuration
  divisions team_division[] NOT NULL,
  entry_fee_cents INTEGER,  -- Store in cents to avoid float issues
  
  -- Organizer
  organizer_id UUID NOT NULL REFERENCES public.users(id),
  organizer_email TEXT,
  organizer_phone TEXT,
  
  -- Branding
  logo_url TEXT,
  website_url TEXT,
  
  -- USAU integration
  usau_sanctioned BOOLEAN DEFAULT false,
  usau_event_id TEXT,
  
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

CREATE INDEX idx_tournaments_dates ON public.tournaments(start_date, end_date);
CREATE INDEX idx_tournaments_status ON public.tournaments(status);

-- ============================================================
-- TOURNAMENT DIVISIONS TABLE
-- ============================================================

CREATE TABLE public.tournament_divisions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tournament_id UUID NOT NULL REFERENCES public.tournaments(id) ON DELETE CASCADE,
  
  division team_division NOT NULL,
  level team_level NOT NULL,
  
  -- Format configuration
  num_teams INTEGER NOT NULL,
  num_pools INTEGER,
  teams_per_pool INTEGER,
  
  -- Game settings
  game_to_score INTEGER DEFAULT 13,
  time_cap_minutes INTEGER DEFAULT 75,
  
  -- Pool play format
  pool_format TEXT DEFAULT 'round_robin',  -- round_robin, partial
  
  -- Bracket format
  bracket_format TEXT DEFAULT 'single_elimination',  -- single, double, consolation
  bracket_seeding TEXT DEFAULT 'pool_finish',  -- pool_finish, manual
  
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- ============================================================
-- POOLS TABLE
-- ============================================================

CREATE TABLE public.pools (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  division_id UUID NOT NULL REFERENCES public.tournament_divisions(id) ON DELETE CASCADE,
  
  name TEXT NOT NULL,  -- 'Pool A', 'Pool B', etc.
  
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

-- ============================================================
-- POOL STANDINGS TABLE (cached standings)
-- ============================================================

CREATE TABLE public.pool_standings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  pool_id UUID NOT NULL REFERENCES public.pools(id) ON DELETE CASCADE,
  team_id UUID NOT NULL REFERENCES public.teams(id),
  
  rank INTEGER,
  wins INTEGER DEFAULT 0,
  losses INTEGER DEFAULT 0,
  point_differential INTEGER DEFAULT 0,
  points_for INTEGER DEFAULT 0,
  points_against INTEGER DEFAULT 0,
  
  -- Tiebreaker info
  tiebreaker_applied BOOLEAN DEFAULT false,
  tiebreaker_notes TEXT,
  
  updated_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  
  UNIQUE(pool_id, team_id)
);

-- ============================================================
-- TOURNAMENT REGISTRATIONS TABLE
-- ============================================================

CREATE TABLE public.tournament_registrations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  tournament_id UUID NOT NULL REFERENCES public.tournaments(id) ON DELETE CASCADE,
  division_id UUID NOT NULL REFERENCES public.tournament_divisions(id),
  team_id UUID NOT NULL REFERENCES public.teams(id),
  
  -- Registration status
  status TEXT NOT NULL DEFAULT 'pending',  -- pending, confirmed, waitlisted, cancelled
  
  -- Payment
  paid BOOLEAN DEFAULT false,
  paid_at TIMESTAMPTZ,
  payment_reference TEXT,
  
  -- Pool assignment (set by TD)
  pool_id UUID REFERENCES public.pools(id),
  seed_number INTEGER,
  
  -- Contact info for tournament
  captain_email TEXT NOT NULL,
  captain_phone TEXT,
  
  registered_by UUID NOT NULL REFERENCES public.users(id),
  registered_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  
  notes TEXT,
  
  UNIQUE(tournament_id, team_id)
);

-- ============================================================
-- INVITATIONS TABLE (for team invites)
-- ============================================================

CREATE TABLE public.invitations (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  team_id UUID NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
  
  -- Invite target (email or shareable code)
  email TEXT,
  invite_code TEXT UNIQUE,
  
  role team_role DEFAULT 'player',
  
  -- Status
  status TEXT NOT NULL DEFAULT 'pending',  -- pending, accepted, declined, expired
  
  invited_by UUID NOT NULL REFERENCES public.users(id),
  accepted_by UUID REFERENCES public.users(id),
  
  expires_at TIMESTAMPTZ DEFAULT (NOW() + INTERVAL '7 days'),
  created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

CREATE INDEX idx_invitations_team ON public.invitations(team_id);
CREATE INDEX idx_invitations_email ON public.invitations(email);
CREATE INDEX idx_invitations_code ON public.invitations(invite_code);

-- ============================================================
-- CAREER STATS VIEW (aggregated player statistics)
-- ============================================================

CREATE OR REPLACE VIEW public.player_career_stats AS
SELECT 
  gl.user_id,
  u.display_name,
  
  -- Game counts
  COUNT(DISTINCT g.id) AS games_played,
  COUNT(DISTINCT g.id) FILTER (
    WHERE (gl.team_side = 'home' AND g.home_score > g.away_score)
       OR (gl.team_side = 'away' AND g.away_score > g.home_score)
  ) AS wins,
  
  -- Scoring
  COUNT(*) FILTER (WHERE p.type = 'goal' AND p.primary_player_id = gl.id) AS goals,
  COUNT(*) FILTER (WHERE p.type = 'goal' AND p.secondary_player_id = gl.id) AS assists,
  
  -- Completions
  COUNT(*) FILTER (WHERE p.type = 'pass' AND p.primary_player_id = gl.id) AS throws,
  COUNT(*) FILTER (WHERE p.type = 'pass' AND p.secondary_player_id = gl.id) AS catches,
  
  -- Turnovers
  COUNT(*) FILTER (WHERE p.type IN ('drop', 'throwaway', 'stall') AND p.primary_player_id = gl.id) AS turnovers,
  COUNT(*) FILTER (WHERE p.type = 'drop' AND p.primary_player_id = gl.id) AS drops,
  COUNT(*) FILTER (WHERE p.type = 'throwaway' AND p.primary_player_id = gl.id) AS throwaways,
  
  -- Defense
  COUNT(*) FILTER (WHERE p.type = 'block' AND p.primary_player_id = gl.id) AS blocks,
  COUNT(*) FILTER (WHERE p.type = 'interception' AND p.primary_player_id = gl.id) AS interceptions,
  COUNT(*) FILTER (WHERE p.type = 'callahan' AND p.primary_player_id = gl.id) AS callahans,
  
  -- Pulls
  COUNT(*) FILTER (WHERE p.type = 'pull' AND p.primary_player_id = gl.id) AS pulls

FROM public.game_lineups gl
JOIN public.users u ON u.id = gl.user_id
JOIN public.games g ON g.id = gl.game_id
LEFT JOIN public.plays p ON p.game_id = g.id 
  AND (p.primary_player_id = gl.id OR p.secondary_player_id = gl.id)
WHERE g.status = 'completed'
  AND gl.user_id IS NOT NULL
GROUP BY gl.user_id, u.display_name;

-- ============================================================
-- FUNCTIONS
-- ============================================================

-- Update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply to all tables with updated_at
CREATE TRIGGER update_users_updated_at
  BEFORE UPDATE ON public.users
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_teams_updated_at
  BEFORE UPDATE ON public.teams
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_games_updated_at
  BEFORE UPDATE ON public.games
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_tournaments_updated_at
  BEFORE UPDATE ON public.tournaments
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Recalculate pool standings
CREATE OR REPLACE FUNCTION recalculate_pool_standings(p_pool_id UUID)
RETURNS VOID AS $$
BEGIN
  -- Clear existing standings
  DELETE FROM public.pool_standings WHERE pool_id = p_pool_id;
  
  -- Insert recalculated standings
  INSERT INTO public.pool_standings (pool_id, team_id, wins, losses, point_differential, points_for, points_against)
  SELECT 
    p_pool_id,
    tr.team_id,
    COUNT(*) FILTER (
      WHERE (tg.is_home AND g.home_score > g.away_score)
         OR (NOT tg.is_home AND g.away_score > g.home_score)
    ) AS wins,
    COUNT(*) FILTER (
      WHERE (tg.is_home AND g.home_score < g.away_score)
         OR (NOT tg.is_home AND g.away_score < g.home_score)
    ) AS losses,
    SUM(
      CASE WHEN tg.is_home 
        THEN LEAST(g.home_score - g.away_score, 5)  -- Cap at +/- 5
        ELSE LEAST(g.away_score - g.home_score, 5)
      END
    ) AS point_differential,
    SUM(CASE WHEN tg.is_home THEN g.home_score ELSE g.away_score END) AS points_for,
    SUM(CASE WHEN tg.is_home THEN g.away_score ELSE g.home_score END) AS points_against
  FROM public.tournament_registrations tr
  JOIN public.team_games tg ON tg.team_id = tr.team_id
  JOIN public.games g ON g.id = tg.game_id AND g.status = 'completed'
  WHERE tr.pool_id = p_pool_id
  GROUP BY tr.team_id;
  
  -- Update ranks (simple W-L ordering, tiebreakers handled separately)
  UPDATE public.pool_standings ps
  SET rank = subq.rank
  FROM (
    SELECT id, ROW_NUMBER() OVER (ORDER BY wins DESC, point_differential DESC) AS rank
    FROM public.pool_standings
    WHERE pool_id = p_pool_id
  ) subq
  WHERE ps.id = subq.id;
END;
$$ LANGUAGE plpgsql;

-- ============================================================
-- INDEXES FOR COMMON QUERIES
-- ============================================================

-- Fast lookup for user's teams
CREATE INDEX idx_team_members_user_active 
  ON public.team_members(user_id) 
  WHERE is_active = true;

-- Fast lookup for active games
CREATE INDEX idx_games_active 
  ON public.games(status, updated_at DESC)
  WHERE status IN ('active', 'halftime', 'soft_cap', 'hard_cap');

-- Fast play feed for game
CREATE INDEX idx_plays_game_recent 
  ON public.plays(game_id, created_at DESC);

-- Tournament games
CREATE INDEX idx_games_tournament_status 
  ON public.games(tournament_id, status);
```

### 5.3 Dart Model Definitions (Freezed)

**lib/features/games/data/models/game.dart**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

enum GameStatus {
  setup,
  active,
  halftime,
  @JsonValue('soft_cap')
  softCap,
  @JsonValue('hard_cap')
  hardCap,
  completed,
  abandoned,
}

@freezed
class Game with _$Game {
  const factory Game({
    required String id,
    
    // Teams
    required String homeTeamName,
    required String awayTeamName,
    String? homeTeamId,
    String? awayTeamId,
    
    // Score
    @Default(0) int homeScore,
    @Default(0) int awayScore,
    
    // Status
    @Default(GameStatus.setup) GameStatus status,
    @Default(true) bool isOffense,
    @Default(1) int currentPointNumber,
    
    // Configuration
    @Default(15) int gameToScore,
    int? pointCap,
    int? timeCapMinutes,
    @Default(1) int softCapAddition,
    @Default(0) int hardCapAddition,
    
    // Timing
    DateTime? startedAt,
    DateTime? halftimeAt,
    DateTime? softCapAt,
    DateTime? hardCapAt,
    DateTime? completedAt,
    
    // Tournament context
    String? tournamentId,
    String? poolId,
    String? bracketRound,
    String? fieldNumber,
    
    // Metadata
    required String createdBy,
    DateTime? clientCreatedAt,
    @Default(1) int syncVersion,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Game;
  
  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  
  const Game._();
  
  /// Check if game is in a cap state
  bool get isInCap => status == GameStatus.softCap || status == GameStatus.hardCap;
  
  /// Get effective game point target
  int get effectiveGameTo {
    if (status == GameStatus.hardCap) {
      return (homeScore > awayScore ? homeScore : awayScore) + hardCapAddition;
    }
    if (status == GameStatus.softCap) {
      return (homeScore > awayScore ? homeScore : awayScore) + softCapAddition;
    }
    return gameToScore;
  }
  
  /// Check if game is over
  bool get isGameOver {
    if (status == GameStatus.completed || status == GameStatus.abandoned) {
      return true;
    }
    return homeScore >= effectiveGameTo || awayScore >= effectiveGameTo;
  }
}
```

**lib/features/games/data/models/play.dart**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'play.freezed.dart';
part 'play.g.dart';

enum PlayType {
  // Offensive plays
  pickup,
  pass,
  goal,
  drop,
  throwaway,
  stall,
  
  // Defensive plays
  pull,
  block,
  interception,
  callahan,
  
  // Neutral plays
  timeout,
  injury,
  @JsonValue('end_of_point')
  endOfPoint,
  substitution,
  
  // Fouls/Violations
  foul,
  violation,
  @JsonValue('contested_foul')
  contestedFoul,
  @JsonValue('retracted_foul')
  retractedFoul,
}

enum TeamSide {
  home,
  away,
}

enum PullResult {
  @JsonValue('in_bounds')
  inBounds,
  @JsonValue('out_of_bounds_brick')
  outOfBoundsBrick,
  @JsonValue('out_of_bounds_sideline')
  outOfBoundsSideline,
  dropped,
}

@freezed
class Play with _$Play {
  const factory Play({
    required String id,
    required String gameId,
    
    required PlayType type,
    required TeamSide teamSide,
    
    String? primaryPlayerId,
    String? secondaryPlayerId,
    
    required int pointNumber,
    int? gameTimeSeconds,
    required int sequenceNumber,
    
    @Default({}) Map<String, dynamic> metadata,
    
    DateTime? clientCreatedAt,
    required DateTime createdAt,
  }) = _Play;
  
  factory Play.fromJson(Map<String, dynamic> json) => _$PlayFromJson(json);
  
  const Play._();
  
  /// Helper getters for pull metadata
  int? get pullHangTimeMs => metadata['hang_time_ms'] as int?;
  PullResult? get pullResult {
    final result = metadata['result'] as String?;
    if (result == null) return null;
    return PullResult.values.firstWhere(
      (e) => e.name == result || e.toString().split('.').last == result,
    );
  }
  String? get pullType => metadata['pull_type'] as String?;
  
  /// Check if this play resulted in a turnover
  bool get isTurnover => [
    PlayType.drop,
    PlayType.throwaway,
    PlayType.stall,
    PlayType.block,
    PlayType.interception,
  ].contains(type);
  
  /// Check if this is a scoring play
  bool get isScore => type == PlayType.goal || type == PlayType.callahan;
}
```

**lib/features/teams/data/models/team.dart**

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';
part 'team.g.dart';

enum TeamDivision {
  mens,
  womens,
  mixed,
}

enum TeamLevel {
  club,
  college,
  @JsonValue('high_school')
  highSchool,
  youth,
  masters,
  recreational,
}

@freezed
class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    required String abbreviation,
    required TeamDivision division,
    required TeamLevel level,
    
    String? logoUrl,
    @Default('#FF6B35') String primaryColor,
    @Default('#1A1A2E') String secondaryColor,
    
    String? city,
    String? state,
    @Default('USA') String country,
    
    String? usauTeamId,
    
    required String ownerId,
    @Default(true) bool isPublic,
    
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Team;
  
  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

enum TeamRole {
  owner,
  captain,
  coach,
  player,
  manager,
  spectator,
}

@freezed
class TeamMember with _$TeamMember {
  const factory TeamMember({
    required String id,
    required String teamId,
    required String userId,
    
    String? jerseyNumber,
    @Default(TeamRole.player) TeamRole role,
    
    @Default(true) bool isActive,
    required DateTime joinedAt,
    DateTime? leftAt,
    
    int? seasonYear,
    
    required DateTime createdAt,
    required DateTime updatedAt,
    
    // Joined data
    String? displayName,
    String? avatarUrl,
  }) = _TeamMember;
  
  factory TeamMember.fromJson(Map<String, dynamic> json) => _$TeamMemberFromJson(json);
}
```

---

## 6. Authentication

### 6.1 Auth Service

**lib/features/auth/data/auth_repository.dart**

```dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/config/supabase_config.dart';

class AuthRepository {
  final GoTrueClient _auth = SupabaseConfig.auth;
  
  /// Current user session
  Session? get currentSession => _auth.currentSession;
  User? get currentUser => _auth.currentUser;
  bool get isAuthenticated => currentUser != null;
  
  /// Auth state stream
  Stream<AuthState> get authStateChanges => _auth.onAuthStateChange;
  
  /// Email sign up
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    return await _auth.signUp(
      email: email,
      password: password,
      data: {
        'display_name': displayName,
      },
    );
  }
  
  /// Email sign in
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
  
  /// OAuth sign in (Google, Apple)
  Future<bool> signInWithOAuth(OAuthProvider provider) async {
    final response = await _auth.signInWithOAuth(
      provider,
      redirectTo: 'io.supabase.ultimatehub://login-callback/',
    );
    return response;
  }
  
  /// Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
  
  /// Password reset
  Future<void> resetPassword(String email) async {
    await _auth.resetPasswordForEmail(
      email,
      redirectTo: 'io.supabase.ultimatehub://reset-callback/',
    );
  }
  
  /// Update password
  Future<UserResponse> updatePassword(String newPassword) async {
    return await _auth.updateUser(
      UserAttributes(password: newPassword),
    );
  }
  
  /// Refresh session
  Future<AuthResponse> refreshSession() async {
    return await _auth.refreshSession();
  }
}
```

### 6.2 Auth Provider (Riverpod)

**lib/features/auth/presentation/providers/auth_provider.dart**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/auth_repository.dart';
import '../../data/models/user_profile.dart';

part 'auth_provider.g.dart';

/// Auth repository provider
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository();
}

/// Current auth state
@riverpod
Stream<AuthState> authState(AuthStateRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

/// Current user provider
@riverpod
User? currentUser(CurrentUserRef ref) {
  final authState = ref.watch(authStateProvider);
  return authState.whenData((state) => state.session?.user).valueOrNull;
}

/// User profile provider
@riverpod
Future<UserProfile?> userProfile(UserProfileRef ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  
  final supabase = Supabase.instance.client;
  final response = await supabase
      .from('users')
      .select()
      .eq('id', user.id)
      .single();
  
  return UserProfile.fromJson(response);
}

/// Auth controller for actions
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}
  
  Future<void> signIn(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signIn(
        email: email,
        password: password,
      );
    });
  }
  
  Future<void> signUp(String email, String password, String displayName) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
    });
  }
  
  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signInWithOAuth(
        OAuthProvider.google,
      );
    });
  }
  
  Future<void> signInWithApple() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(authRepositoryProvider).signInWithOAuth(
        OAuthProvider.apple,
      );
    });
  }
  
  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}
```

### 6.3 OAuth Configuration

**iOS (ios/Runner/Info.plist)**

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>io.supabase.ultimatehub</string>
    </array>
  </dict>
</array>
```

**Android (android/app/src/main/AndroidManifest.xml)**

```xml
<manifest ...>
  <application ...>
    <activity ...>
      <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="io.supabase.ultimatehub" />
      </intent-filter>
    </activity>
  </application>
</manifest>
```

---

## 7. Row-Level Security (RLS)

### 7.1 RLS Policies

**supabase/migrations/20260102000001_rls_policies.sql**

```sql
-- ============================================================
-- ROW LEVEL SECURITY POLICIES
-- ============================================================

-- Enable RLS on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.teams ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.team_members ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.games ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.game_lineups ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.plays ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tournaments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.tournament_registrations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.invitations ENABLE ROW LEVEL SECURITY;

-- ============================================================
-- USERS POLICIES
-- ============================================================

-- Users can read any public profile
CREATE POLICY "Public profiles are viewable by everyone"
  ON public.users FOR SELECT
  USING (true);

-- Users can update their own profile
CREATE POLICY "Users can update own profile"
  ON public.users FOR UPDATE
  USING (auth.uid() = id);

-- ============================================================
-- TEAMS POLICIES
-- ============================================================

-- Public teams are viewable by everyone
CREATE POLICY "Public teams are viewable"
  ON public.teams FOR SELECT
  USING (is_public = true OR owner_id = auth.uid());

-- Team owners and captains can update
CREATE POLICY "Team admins can update"
  ON public.teams FOR UPDATE
  USING (
    owner_id = auth.uid() OR
    EXISTS (
      SELECT 1 FROM public.team_members
      WHERE team_id = teams.id
        AND user_id = auth.uid()
        AND role IN ('owner', 'captain', 'coach')
        AND is_active = true
    )
  );

-- Any authenticated user can create a team
CREATE POLICY "Authenticated users can create teams"
  ON public.teams FOR INSERT
  WITH CHECK (auth.uid() = owner_id);

-- Only owner can delete team
CREATE POLICY "Team owners can delete"
  ON public.teams FOR DELETE
  USING (owner_id = auth.uid());

-- ============================================================
-- TEAM MEMBERS POLICIES
-- ============================================================

-- Team members are viewable by team members
CREATE POLICY "Team members viewable by team"
  ON public.team_members FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.team_members tm
      WHERE tm.team_id = team_members.team_id
        AND tm.user_id = auth.uid()
        AND tm.is_active = true
    )
    OR
    EXISTS (
      SELECT 1 FROM public.teams t
      WHERE t.id = team_members.team_id
        AND t.is_public = true
    )
  );

-- Team admins can manage members
CREATE POLICY "Team admins can manage members"
  ON public.team_members FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM public.teams t
      WHERE t.id = team_members.team_id
        AND (
          t.owner_id = auth.uid() OR
          EXISTS (
            SELECT 1 FROM public.team_members tm
            WHERE tm.team_id = t.id
              AND tm.user_id = auth.uid()
              AND tm.role IN ('owner', 'captain', 'coach')
              AND tm.is_active = true
          )
        )
    )
  );

-- Users can leave teams (update own membership)
CREATE POLICY "Users can leave teams"
  ON public.team_members FOR UPDATE
  USING (user_id = auth.uid());

-- ============================================================
-- GAMES POLICIES
-- ============================================================

-- Games viewable by:
-- - Creator
-- - Team members (if linked)
-- - Tournament participants (if tournament game)
-- - Everyone if game is in a public tournament
CREATE POLICY "Games viewable by participants"
  ON public.games FOR SELECT
  USING (
    created_by = auth.uid() OR
    EXISTS (
      SELECT 1 FROM public.team_members tm
      WHERE (tm.team_id = games.home_team_id OR tm.team_id = games.away_team_id)
        AND tm.user_id = auth.uid()
        AND tm.is_active = true
    ) OR
    EXISTS (
      SELECT 1 FROM public.tournaments t
      WHERE t.id = games.tournament_id
        AND t.status IN ('active', 'completed')
    )
  );

-- Game creators can update
CREATE POLICY "Game creators can update"
  ON public.games FOR UPDATE
  USING (created_by = auth.uid());

-- Authenticated users can create games
CREATE POLICY "Authenticated users can create games"
  ON public.games FOR INSERT
  WITH CHECK (auth.uid() = created_by);

-- ============================================================
-- GAME LINEUPS POLICIES
-- ============================================================

-- Lineups viewable if game is viewable
CREATE POLICY "Lineups viewable with game"
  ON public.game_lineups FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.games g
      WHERE g.id = game_lineups.game_id
        AND (
          g.created_by = auth.uid() OR
          EXISTS (
            SELECT 1 FROM public.tournaments t
            WHERE t.id = g.tournament_id
              AND t.status IN ('active', 'completed')
          )
        )
    )
  );

-- Game creator can manage lineups
CREATE POLICY "Game creator manages lineups"
  ON public.game_lineups FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM public.games g
      WHERE g.id = game_lineups.game_id
        AND g.created_by = auth.uid()
    )
  );

-- ============================================================
-- PLAYS POLICIES
-- ============================================================

-- Plays viewable if game is viewable
CREATE POLICY "Plays viewable with game"
  ON public.plays FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.games g
      WHERE g.id = plays.game_id
        AND (
          g.created_by = auth.uid() OR
          EXISTS (
            SELECT 1 FROM public.tournaments t
            WHERE t.id = g.tournament_id
              AND t.status IN ('active', 'completed')
          )
        )
    )
  );

-- Game creator can log plays
CREATE POLICY "Game creator logs plays"
  ON public.plays FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.games g
      WHERE g.id = plays.game_id
        AND g.created_by = auth.uid()
    )
  );

-- Game creator can update/delete plays (for undo)
CREATE POLICY "Game creator edits plays"
  ON public.plays FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM public.games g
      WHERE g.id = plays.game_id
        AND g.created_by = auth.uid()
    )
  );

CREATE POLICY "Game creator deletes plays"
  ON public.plays FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM public.games g
      WHERE g.id = plays.game_id
        AND g.created_by = auth.uid()
    )
  );

-- ============================================================
-- TOURNAMENTS POLICIES
-- ============================================================

-- Active/completed tournaments are public
CREATE POLICY "Public tournaments viewable"
  ON public.tournaments FOR SELECT
  USING (status IN ('registration_open', 'registration_closed', 'active', 'completed'));

-- Draft tournaments visible to organizer only
CREATE POLICY "Draft tournaments visible to organizer"
  ON public.tournaments FOR SELECT
  USING (status = 'draft' AND organizer_id = auth.uid());

-- Organizers can manage their tournaments
CREATE POLICY "Organizers manage tournaments"
  ON public.tournaments FOR ALL
  USING (organizer_id = auth.uid());

-- Authenticated users can create tournaments
CREATE POLICY "Authenticated users create tournaments"
  ON public.tournaments FOR INSERT
  WITH CHECK (auth.uid() = organizer_id);

-- ============================================================
-- INVITATIONS POLICIES
-- ============================================================

-- Invitations viewable by team admins and invitee
CREATE POLICY "Invitations viewable by parties"
  ON public.invitations FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.teams t
      WHERE t.id = invitations.team_id
        AND (
          t.owner_id = auth.uid() OR
          EXISTS (
            SELECT 1 FROM public.team_members tm
            WHERE tm.team_id = t.id
              AND tm.user_id = auth.uid()
              AND tm.role IN ('owner', 'captain')
              AND tm.is_active = true
          )
        )
    )
    OR email = (SELECT email FROM auth.users WHERE id = auth.uid())
  );

-- Team admins can create invitations
CREATE POLICY "Team admins create invitations"
  ON public.invitations FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.teams t
      WHERE t.id = invitations.team_id
        AND (
          t.owner_id = auth.uid() OR
          EXISTS (
            SELECT 1 FROM public.team_members tm
            WHERE tm.team_id = t.id
              AND tm.user_id = auth.uid()
              AND tm.role IN ('owner', 'captain')
              AND tm.is_active = true
          )
        )
    )
  );

-- Invitees can update status (accept/decline)
CREATE POLICY "Invitees can accept/decline"
  ON public.invitations FOR UPDATE
  USING (
    email = (SELECT email FROM auth.users WHERE id = auth.uid())
    OR invite_code IS NOT NULL  -- Allow anyone with code to accept
  );
```

---

## 8. Realtime Subscriptions

### 8.1 Game Realtime Provider

**lib/features/games/presentation/providers/game_realtime_provider.dart**

```dart
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/game.dart';
import '../../data/models/play.dart';

part 'game_realtime_provider.g.dart';

/// Watch a single game in realtime (for spectators)
@riverpod
Stream<Game> watchGame(WatchGameRef ref, String gameId) {
  final supabase = Supabase.instance.client;
  
  return supabase
      .from('games')
      .stream(primaryKey: ['id'])
      .eq('id', gameId)
      .map((data) => Game.fromJson(data.first));
}

/// Watch plays for a game in realtime
@riverpod
Stream<List<Play>> watchPlays(WatchPlaysRef ref, String gameId) {
  final supabase = Supabase.instance.client;
  
  return supabase
      .from('plays')
      .stream(primaryKey: ['id'])
      .eq('game_id', gameId)
      .order('sequence_number', ascending: false)
      .map((data) => data.map((e) => Play.fromJson(e)).toList());
}

/// Watch all active tournament games (for TD dashboard)
@riverpod
Stream<List<Game>> watchTournamentGames(
  WatchTournamentGamesRef ref,
  String tournamentId,
) {
  final supabase = Supabase.instance.client;
  
  return supabase
      .from('games')
      .stream(primaryKey: ['id'])
      .eq('tournament_id', tournamentId)
      .inFilter('status', ['active', 'halftime', 'soft_cap', 'hard_cap'])
      .map((data) => data.map((e) => Game.fromJson(e)).toList());
}

/// Subscribe to game score changes (lightweight)
@riverpod
class GameScoreSubscription extends _$GameScoreSubscription {
  RealtimeChannel? _channel;
  
  @override
  AsyncValue<({int homeScore, int awayScore})> build(String gameId) {
    _subscribe(gameId);
    ref.onDispose(() => _channel?.unsubscribe());
    return const AsyncLoading();
  }
  
  void _subscribe(String gameId) {
    final supabase = Supabase.instance.client;
    
    _channel = supabase.channel('game-score-$gameId')
      .onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'games',
        filter: PostgresChangeFilter(
          type: PostgresChangeFilterType.eq,
          column: 'id',
          value: gameId,
        ),
        callback: (payload) {
          final newData = payload.newRecord;
          state = AsyncData((
            homeScore: newData['home_score'] as int,
            awayScore: newData['away_score'] as int,
          ));
        },
      )
      .subscribe();
  }
}

/// Presence for live viewers count
@riverpod
class GamePresence extends _$GamePresence {
  RealtimeChannel? _channel;
  
  @override
  int build(String gameId) {
    _setupPresence(gameId);
    ref.onDispose(() => _channel?.unsubscribe());
    return 0;
  }
  
  void _setupPresence(String gameId) {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id ?? 'anonymous';
    
    _channel = supabase.channel('game-presence-$gameId')
      .onPresenceSync((payload) {
        final presenceState = _channel?.presenceState();
        state = presenceState?.length ?? 0;
      })
      .subscribe((status, error) async {
        if (status == RealtimeSubscribeStatus.subscribed) {
          await _channel?.track({
            'user_id': userId,
            'online_at': DateTime.now().toIso8601String(),
          });
        }
      });
  }
}
```

### 8.2 Spectator Screen Example

**lib/features/games/presentation/screens/spectator_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/game_realtime_provider.dart';
import '../widgets/score_display.dart';
import '../widgets/play_feed.dart';
import '../widgets/field_canvas.dart';

class SpectatorScreen extends ConsumerWidget {
  final String gameId;
  
  const SpectatorScreen({super.key, required this.gameId});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameAsync = ref.watch(watchGameProvider(gameId));
    final playsAsync = ref.watch(watchPlaysProvider(gameId));
    final viewerCount = ref.watch(gamePresenceProvider(gameId));
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Game'),
        actions: [
          Chip(
            avatar: const Icon(Icons.visibility, size: 16),
            label: Text('$viewerCount watching'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: gameAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (game) => Column(
          children: [
            // Score header
            ScoreDisplay(game: game),
            
            // Field visualization
            Expanded(
              flex: 2,
              child: FieldCanvas(
                game: game,
                plays: playsAsync.valueOrNull ?? [],
              ),
            ),
            
            // Live play feed
            Expanded(
              flex: 1,
              child: playsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (plays) => PlayFeed(plays: plays),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 9. Offline Sync Strategy

### 9.1 PowerSync Configuration

Ultimate Hub uses [PowerSync](https://www.powersync.com/) for offline-first sync with Supabase. PowerSync provides:
- Full offline CRUD operations
- Automatic conflict resolution
- Selective sync (only sync relevant data)
- Real-time sync when online

**lib/core/sync/sync_engine.dart**

```dart
import 'package:powersync/powersync.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'sync_schema.dart';

class SyncEngine {
  static PowerSyncDatabase? _database;
  
  static PowerSyncDatabase get database {
    if (_database == null) {
      throw StateError('SyncEngine not initialized');
    }
    return _database!;
  }
  
  static Future<void> initialize() async {
    final dir = await getApplicationSupportDirectory();
    final dbPath = join(dir.path, 'ultimate_hub.db');
    
    _database = PowerSyncDatabase(
      schema: syncSchema,
      path: dbPath,
    );
    
    await _database!.initialize();
    
    // Connect to Supabase
    final connector = SupabaseConnector();
    await _database!.connect(connector: connector);
  }
  
  static Future<void> disconnect() async {
    await _database?.disconnect();
  }
  
  /// Force sync now
  static Future<void> syncNow() async {
    await _database?.forceSync();
  }
  
  /// Get sync status
  static Stream<SyncStatus> get syncStatus => 
      _database?.statusStream ?? const Stream.empty();
}

/// Supabase connector for PowerSync
class SupabaseConnector extends PowerSyncBackendConnector {
  final SupabaseClient _client = Supabase.instance.client;
  
  @override
  Future<PowerSyncCredentials?> fetchCredentials() async {
    final session = _client.auth.currentSession;
    if (session == null) return null;
    
    // Get PowerSync token from Supabase Edge Function
    final response = await _client.functions.invoke(
      'powersync-token',
      body: {'user_id': session.user.id},
    );
    
    return PowerSyncCredentials(
      endpoint: 'https://your-instance.powersync.journeyapps.com',
      token: response.data['token'],
      userId: session.user.id,
    );
  }
  
  @override
  Future<void> uploadData(PowerSyncDatabase database) async {
    final batch = await database.getCrudBatch();
    if (batch == null) return;
    
    for (final op in batch.crud) {
      switch (op.op) {
        case UpdateType.put:
          await _client.from(op.table).upsert(op.opData!);
          break;
        case UpdateType.patch:
          await _client.from(op.table).update(op.opData!).eq('id', op.id);
          break;
        case UpdateType.delete:
          await _client.from(op.table).delete().eq('id', op.id);
          break;
      }
    }
    
    await batch.complete();
  }
}
```

### 9.2 Sync Schema Definition

**lib/core/sync/sync_schema.dart**

```dart
import 'package:powersync/powersync.dart';

final syncSchema = Schema([
  // Games table - sync all games user created or is part of
  Table('games', [
    Column.text('home_team_name'),
    Column.text('away_team_name'),
    Column.text('home_team_id'),
    Column.text('away_team_id'),
    Column.integer('home_score'),
    Column.integer('away_score'),
    Column.text('status'),
    Column.integer('is_offense'),
    Column.integer('current_point_number'),
    Column.integer('game_to_score'),
    Column.integer('point_cap'),
    Column.integer('time_cap_minutes'),
    Column.integer('soft_cap_addition'),
    Column.integer('hard_cap_addition'),
    Column.text('started_at'),
    Column.text('completed_at'),
    Column.text('tournament_id'),
    Column.text('created_by'),
    Column.text('client_created_at'),
    Column.integer('sync_version'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ]),
  
  // Plays table - sync plays for synced games
  Table('plays', [
    Column.text('game_id'),
    Column.text('type'),
    Column.text('team_side'),
    Column.text('primary_player_id'),
    Column.text('secondary_player_id'),
    Column.integer('point_number'),
    Column.integer('game_time_seconds'),
    Column.integer('sequence_number'),
    Column.text('metadata'),  // JSON string
    Column.text('client_created_at'),
    Column.text('created_at'),
  ], indexes: [
    Index('plays_game_idx', [IndexedColumn('game_id')]),
  ]),
  
  // Game lineups - sync for synced games
  Table('game_lineups', [
    Column.text('game_id'),
    Column.text('player_name'),
    Column.text('jersey_number'),
    Column.text('user_id'),
    Column.text('team_side'),
    Column.integer('is_active'),
    Column.text('created_at'),
  ], indexes: [
    Index('lineups_game_idx', [IndexedColumn('game_id')]),
  ]),
  
  // Teams - sync teams user is member of
  Table('teams', [
    Column.text('name'),
    Column.text('abbreviation'),
    Column.text('division'),
    Column.text('level'),
    Column.text('logo_url'),
    Column.text('primary_color'),
    Column.text('secondary_color'),
    Column.text('owner_id'),
    Column.integer('is_public'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ]),
  
  // Team members - sync for synced teams
  Table('team_members', [
    Column.text('team_id'),
    Column.text('user_id'),
    Column.text('jersey_number'),
    Column.text('role'),
    Column.integer('is_active'),
    Column.text('joined_at'),
    Column.integer('season_year'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ], indexes: [
    Index('members_team_idx', [IndexedColumn('team_id')]),
    Index('members_user_idx', [IndexedColumn('user_id')]),
  ]),
]);
```

### 9.3 Sync Rules (PowerSync Dashboard)

```yaml
# powersync.yaml - Sync rules configuration

bucket_definitions:
  # User's own data
  user_data:
    parameters: SELECT token_parameters.user_id AS user_id
    data:
      - SELECT * FROM users WHERE id = bucket.user_id
      
  # User's teams and team data
  user_teams:
    parameters: SELECT token_parameters.user_id AS user_id
    data:
      - SELECT teams.* FROM teams
        JOIN team_members ON team_members.team_id = teams.id
        WHERE team_members.user_id = bucket.user_id
          AND team_members.is_active = true
      - SELECT team_members.* FROM team_members
        WHERE team_id IN (
          SELECT team_id FROM team_members
          WHERE user_id = bucket.user_id AND is_active = true
        )
  
  # User's games
  user_games:
    parameters: SELECT token_parameters.user_id AS user_id
    data:
      - SELECT * FROM games WHERE created_by = bucket.user_id
      - SELECT plays.* FROM plays
        JOIN games ON games.id = plays.game_id
        WHERE games.created_by = bucket.user_id
      - SELECT game_lineups.* FROM game_lineups
        JOIN games ON games.id = game_lineups.game_id
        WHERE games.created_by = bucket.user_id
        
  # Shared game (for spectators/collaborators)
  shared_game:
    parameters: SELECT request_parameters.game_id AS game_id
    data:
      - SELECT * FROM games WHERE id = bucket.game_id
      - SELECT * FROM plays WHERE game_id = bucket.game_id
      - SELECT * FROM game_lineups WHERE game_id = bucket.game_id
```

### 9.4 Offline-First Repository Pattern

**lib/features/games/data/game_repository.dart**

```dart
import 'package:powersync/powersync.dart';
import 'package:uuid/uuid.dart';

import '../../../core/sync/sync_engine.dart';
import 'models/game.dart';
import 'models/play.dart';

class GameRepository {
  final PowerSyncDatabase _db = SyncEngine.database;
  final _uuid = const Uuid();
  
  /// Create a new game (works offline)
  Future<Game> createGame({
    required String homeTeamName,
    required String awayTeamName,
    required String createdBy,
    int gameToScore = 15,
    int? timeCapMinutes,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    
    final game = Game(
      id: id,
      homeTeamName: homeTeamName,
      awayTeamName: awayTeamName,
      gameToScore: gameToScore,
      timeCapMinutes: timeCapMinutes,
      createdBy: createdBy,
      clientCreatedAt: now,
      createdAt: now,
      updatedAt: now,
    );
    
    await _db.execute('''
      INSERT INTO games (
        id, home_team_name, away_team_name, home_score, away_score,
        status, is_offense, current_point_number, game_to_score,
        time_cap_minutes, soft_cap_addition, hard_cap_addition,
        created_by, client_created_at, sync_version, created_at, updated_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      game.id,
      game.homeTeamName,
      game.awayTeamName,
      game.homeScore,
      game.awayScore,
      game.status.name,
      game.isOffense ? 1 : 0,
      game.currentPointNumber,
      game.gameToScore,
      game.timeCapMinutes,
      game.softCapAddition,
      game.hardCapAddition,
      game.createdBy,
      game.clientCreatedAt?.toIso8601String(),
      game.syncVersion,
      game.createdAt.toIso8601String(),
      game.updatedAt.toIso8601String(),
    ]);
    
    return game;
  }
  
  /// Get game by ID (from local DB)
  Future<Game?> getGame(String id) async {
    final results = await _db.get(
      'SELECT * FROM games WHERE id = ?',
      [id],
    );
    
    if (results.isEmpty) return null;
    return _gameFromRow(results.first);
  }
  
  /// Watch game changes
  Stream<Game?> watchGame(String id) {
    return _db.watch(
      'SELECT * FROM games WHERE id = ?',
      parameters: [id],
    ).map((results) {
      if (results.isEmpty) return null;
      return _gameFromRow(results.first);
    });
  }
  
  /// Get all games for user
  Future<List<Game>> getUserGames(String userId) async {
    final results = await _db.getAll(
      'SELECT * FROM games WHERE created_by = ? ORDER BY updated_at DESC',
      [userId],
    );
    
    return results.map(_gameFromRow).toList();
  }
  
  /// Watch user's games
  Stream<List<Game>> watchUserGames(String userId) {
    return _db.watch(
      'SELECT * FROM games WHERE created_by = ? ORDER BY updated_at DESC',
      parameters: [userId],
    ).map((results) => results.map(_gameFromRow).toList());
  }
  
  /// Log a play (works offline)
  Future<Play> logPlay({
    required String gameId,
    required PlayType type,
    required TeamSide teamSide,
    required int pointNumber,
    required int sequenceNumber,
    String? primaryPlayerId,
    String? secondaryPlayerId,
    int? gameTimeSeconds,
    Map<String, dynamic>? metadata,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    
    final play = Play(
      id: id,
      gameId: gameId,
      type: type,
      teamSide: teamSide,
      primaryPlayerId: primaryPlayerId,
      secondaryPlayerId: secondaryPlayerId,
      pointNumber: pointNumber,
      gameTimeSeconds: gameTimeSeconds,
      sequenceNumber: sequenceNumber,
      metadata: metadata ?? {},
      clientCreatedAt: now,
      createdAt: now,
    );
    
    await _db.execute('''
      INSERT INTO plays (
        id, game_id, type, team_side, primary_player_id, secondary_player_id,
        point_number, game_time_seconds, sequence_number, metadata,
        client_created_at, created_at
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''', [
      play.id,
      play.gameId,
      play.type.name,
      play.teamSide.name,
      play.primaryPlayerId,
      play.secondaryPlayerId,
      play.pointNumber,
      play.gameTimeSeconds,
      play.sequenceNumber,
      play.metadata.isNotEmpty ? jsonEncode(play.metadata) : null,
      play.clientCreatedAt?.toIso8601String(),
      play.createdAt.toIso8601String(),
    ]);
    
    return play;
  }
  
  /// Get plays for a game
  Future<List<Play>> getPlays(String gameId) async {
    final results = await _db.getAll(
      'SELECT * FROM plays WHERE game_id = ? ORDER BY sequence_number DESC',
      [gameId],
    );
    
    return results.map(_playFromRow).toList();
  }
  
  /// Watch plays for a game
  Stream<List<Play>> watchPlays(String gameId) {
    return _db.watch(
      'SELECT * FROM plays WHERE game_id = ? ORDER BY sequence_number DESC',
      parameters: [gameId],
    ).map((results) => results.map(_playFromRow).toList());
  }
  
  /// Update game (score, status, etc.)
  Future<void> updateGame(String id, Map<String, dynamic> updates) async {
    final setClauses = updates.keys.map((k) => '$k = ?').join(', ');
    final values = [...updates.values, DateTime.now().toIso8601String(), id];
    
    await _db.execute(
      'UPDATE games SET $setClauses, updated_at = ? WHERE id = ?',
      values,
    );
  }
  
  /// Delete play (for undo)
  Future<void> deletePlay(String playId) async {
    await _db.execute('DELETE FROM plays WHERE id = ?', [playId]);
  }
  
  // Helper methods
  Game _gameFromRow(Map<String, dynamic> row) {
    return Game(
      id: row['id'] as String,
      homeTeamName: row['home_team_name'] as String,
      awayTeamName: row['away_team_name'] as String,
      homeTeamId: row['home_team_id'] as String?,
      awayTeamId: row['away_team_id'] as String?,
      homeScore: row['home_score'] as int,
      awayScore: row['away_score'] as int,
      status: GameStatus.values.firstWhere(
        (e) => e.name == row['status'],
        orElse: () => GameStatus.setup,
      ),
      isOffense: (row['is_offense'] as int) == 1,
      currentPointNumber: row['current_point_number'] as int,
      gameToScore: row['game_to_score'] as int,
      pointCap: row['point_cap'] as int?,
      timeCapMinutes: row['time_cap_minutes'] as int?,
      softCapAddition: row['soft_cap_addition'] as int? ?? 1,
      hardCapAddition: row['hard_cap_addition'] as int? ?? 0,
      startedAt: _parseDateTime(row['started_at']),
      completedAt: _parseDateTime(row['completed_at']),
      tournamentId: row['tournament_id'] as String?,
      createdBy: row['created_by'] as String,
      clientCreatedAt: _parseDateTime(row['client_created_at']),
      syncVersion: row['sync_version'] as int? ?? 1,
      createdAt: _parseDateTime(row['created_at'])!,
      updatedAt: _parseDateTime(row['updated_at'])!,
    );
  }
  
  Play _playFromRow(Map<String, dynamic> row) {
    return Play(
      id: row['id'] as String,
      gameId: row['game_id'] as String,
      type: PlayType.values.firstWhere((e) => e.name == row['type']),
      teamSide: TeamSide.values.firstWhere((e) => e.name == row['team_side']),
      primaryPlayerId: row['primary_player_id'] as String?,
      secondaryPlayerId: row['secondary_player_id'] as String?,
      pointNumber: row['point_number'] as int,
      gameTimeSeconds: row['game_time_seconds'] as int?,
      sequenceNumber: row['sequence_number'] as int,
      metadata: row['metadata'] != null 
          ? jsonDecode(row['metadata'] as String) as Map<String, dynamic>
          : {},
      clientCreatedAt: _parseDateTime(row['client_created_at']),
      createdAt: _parseDateTime(row['created_at'])!,
    );
  }
  
  DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    return DateTime.parse(value as String);
  }
}
```

---

## 10. API Layer & Repository Pattern

### 10.1 Base Repository

**lib/core/network/base_repository.dart**

```dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';

abstract class BaseRepository {
  SupabaseClient get supabase => SupabaseConfig.client;
  
  /// Handle Supabase errors consistently
  T handleError<T>(Object error, StackTrace stackTrace) {
    if (error is PostgrestException) {
      throw ApiException(
        message: error.message,
        code: error.code,
        details: error.details,
      );
    }
    throw ApiException(message: error.toString());
  }
}

class ApiException implements Exception {
  final String message;
  final String? code;
  final dynamic details;
  
  ApiException({
    required this.message,
    this.code,
    this.details,
  });
  
  @override
  String toString() => 'ApiException: $message (code: $code)';
}
```

### 10.2 Team Repository Example

**lib/features/teams/data/team_repository.dart**

```dart
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/network/base_repository.dart';
import 'models/team.dart';

class TeamRepository extends BaseRepository {
  /// Create a new team
  Future<Team> createTeam({
    required String name,
    required String abbreviation,
    required TeamDivision division,
    required TeamLevel level,
    required String ownerId,
  }) async {
    final response = await supabase
        .from('teams')
        .insert({
          'name': name,
          'abbreviation': abbreviation,
          'division': division.name,
          'level': level.name,
          'owner_id': ownerId,
        })
        .select()
        .single();
    
    // Auto-add owner as team member
    await supabase.from('team_members').insert({
      'team_id': response['id'],
      'user_id': ownerId,
      'role': 'owner',
    });
    
    return Team.fromJson(response);
  }
  
  /// Get team by ID
  Future<Team?> getTeam(String id) async {
    final response = await supabase
        .from('teams')
        .select()
        .eq('id', id)
        .maybeSingle();
    
    if (response == null) return null;
    return Team.fromJson(response);
  }
  
  /// Get user's teams
  Future<List<Team>> getUserTeams(String userId) async {
    final response = await supabase
        .from('teams')
        .select('''
          *,
          team_members!inner(user_id)
        ''')
        .eq('team_members.user_id', userId)
        .eq('team_members.is_active', true);
    
    return (response as List).map((e) => Team.fromJson(e)).toList();
  }
  
  /// Search public teams
  Future<List<Team>> searchTeams(String query) async {
    final response = await supabase
        .from('teams')
        .select()
        .eq('is_public', true)
        .ilike('name', '%$query%')
        .limit(20);
    
    return (response as List).map((e) => Team.fromJson(e)).toList();
  }
  
  /// Get team members
  Future<List<TeamMember>> getTeamMembers(String teamId) async {
    final response = await supabase
        .from('team_members')
        .select('''
          *,
          users(display_name, avatar_url)
        ''')
        .eq('team_id', teamId)
        .eq('is_active', true)
        .order('role');
    
    return (response as List).map((e) {
      final userData = e['users'] as Map<String, dynamic>?;
      return TeamMember.fromJson({
        ...e,
        'display_name': userData?['display_name'],
        'avatar_url': userData?['avatar_url'],
      });
    }).toList();
  }
  
  /// Invite user to team
  Future<void> inviteToTeam({
    required String teamId,
    required String email,
    required TeamRole role,
    required String invitedBy,
  }) async {
    await supabase.from('invitations').insert({
      'team_id': teamId,
      'email': email,
      'role': role.name,
      'invited_by': invitedBy,
    });
    
    // Trigger email via Edge Function
    await supabase.functions.invoke('send-invite-email', body: {
      'email': email,
      'team_id': teamId,
    });
  }
  
  /// Accept invitation
  Future<void> acceptInvitation(String invitationId, String userId) async {
    // Get invitation
    final invite = await supabase
        .from('invitations')
        .select()
        .eq('id', invitationId)
        .single();
    
    // Add as team member
    await supabase.from('team_members').insert({
      'team_id': invite['team_id'],
      'user_id': userId,
      'role': invite['role'],
    });
    
    // Update invitation status
    await supabase
        .from('invitations')
        .update({
          'status': 'accepted',
          'accepted_by': userId,
        })
        .eq('id', invitationId);
  }
}
```

---

## 11. State Management

### 11.1 Game State Provider

**lib/features/games/presentation/providers/game_state_provider.dart**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/game_repository.dart';
import '../../data/models/game.dart';
import '../../data/models/play.dart';

part 'game_state_provider.g.dart';

/// Active game state for stat tracking
@freezed
class ActiveGameState with _$ActiveGameState {
  const factory ActiveGameState({
    required Game game,
    required List<Play> plays,
    String? selectedPlayerId,
    @Default([]) List<ActiveGameState> undoStack,
    @Default([]) List<ActiveGameState> redoStack,
  }) = _ActiveGameState;
}

@riverpod
class ActiveGame extends _$ActiveGame {
  late final GameRepository _repo;
  
  @override
  ActiveGameState? build() {
    _repo = ref.read(gameRepositoryProvider);
    return null;
  }
  
  /// Start tracking a game
  Future<void> startGame(Game game) async {
    final plays = await _repo.getPlays(game.id);
    state = ActiveGameState(game: game, plays: plays);
  }
  
  /// Select a player (disc holder)
  void selectPlayer(String? playerId) {
    if (state == null) return;
    state = state!.copyWith(selectedPlayerId: playerId);
  }
  
  /// Log a pass (completion)
  Future<void> logPass(String receiverId) async {
    final current = state;
    if (current == null || current.selectedPlayerId == null) return;
    
    _pushUndo();
    
    final play = await _repo.logPlay(
      gameId: current.game.id,
      type: PlayType.pass,
      teamSide: current.game.isOffense ? TeamSide.home : TeamSide.away,
      pointNumber: current.game.currentPointNumber,
      sequenceNumber: current.plays.length + 1,
      primaryPlayerId: current.selectedPlayerId,
      secondaryPlayerId: receiverId,
    );
    
    state = current.copyWith(
      plays: [play, ...current.plays],
      selectedPlayerId: receiverId,
    );
  }
  
  /// Log a goal
  Future<void> logGoal(String scorerId) async {
    final current = state;
    if (current == null || current.selectedPlayerId == null) return;
    
    _pushUndo();
    
    // Log the goal play
    final play = await _repo.logPlay(
      gameId: current.game.id,
      type: PlayType.goal,
      teamSide: current.game.isOffense ? TeamSide.home : TeamSide.away,
      pointNumber: current.game.currentPointNumber,
      sequenceNumber: current.plays.length + 1,
      primaryPlayerId: current.selectedPlayerId,  // Thrower
      secondaryPlayerId: scorerId,  // Scorer
      metadata: {'assist': current.selectedPlayerId != scorerId},
    );
    
    // Update game score
    final isHome = current.game.isOffense;
    await _repo.updateGame(current.game.id, {
      'home_score': isHome ? current.game.homeScore + 1 : current.game.homeScore,
      'away_score': isHome ? current.game.awayScore : current.game.awayScore + 1,
      'current_point_number': current.game.currentPointNumber + 1,
      'is_offense': !current.game.isOffense,  // Switch possession
    });
    
    final updatedGame = await _repo.getGame(current.game.id);
    
    state = current.copyWith(
      game: updatedGame!,
      plays: [play, ...current.plays],
      selectedPlayerId: null,
    );
  }
  
  /// Log a turnover
  Future<void> logTurnover(PlayType turnoverType) async {
    final current = state;
    if (current == null) return;
    
    _pushUndo();
    
    final play = await _repo.logPlay(
      gameId: current.game.id,
      type: turnoverType,
      teamSide: current.game.isOffense ? TeamSide.home : TeamSide.away,
      pointNumber: current.game.currentPointNumber,
      sequenceNumber: current.plays.length + 1,
      primaryPlayerId: current.selectedPlayerId,
    );
    
    // Switch possession
    await _repo.updateGame(current.game.id, {
      'is_offense': !current.game.isOffense,
    });
    
    final updatedGame = await _repo.getGame(current.game.id);
    
    state = current.copyWith(
      game: updatedGame!,
      plays: [play, ...current.plays],
      selectedPlayerId: null,
    );
  }
  
  /// Log a defensive play (block, interception)
  Future<void> logDefensivePlay(PlayType type, String? defenderId) async {
    final current = state;
    if (current == null) return;
    
    _pushUndo();
    
    final play = await _repo.logPlay(
      gameId: current.game.id,
      type: type,
      teamSide: current.game.isOffense ? TeamSide.away : TeamSide.home,
      pointNumber: current.game.currentPointNumber,
      sequenceNumber: current.plays.length + 1,
      primaryPlayerId: defenderId,
    );
    
    // Switch possession
    await _repo.updateGame(current.game.id, {
      'is_offense': !current.game.isOffense,
    });
    
    final updatedGame = await _repo.getGame(current.game.id);
    
    state = current.copyWith(
      game: updatedGame!,
      plays: [play, ...current.plays],
      selectedPlayerId: null,
    );
  }
  
  /// Log a pull
  Future<void> logPull({
    required String pullerId,
    required int hangTimeMs,
    required PullResult result,
    String? pullType,
  }) async {
    final current = state;
    if (current == null) return;
    
    _pushUndo();
    
    final play = await _repo.logPlay(
      gameId: current.game.id,
      type: PlayType.pull,
      teamSide: current.game.isOffense ? TeamSide.away : TeamSide.home,
      pointNumber: current.game.currentPointNumber,
      sequenceNumber: current.plays.length + 1,
      primaryPlayerId: pullerId,
      metadata: {
        'hang_time_ms': hangTimeMs,
        'result': result.name,
        if (pullType != null) 'pull_type': pullType,
      },
    );
    
    state = current.copyWith(
      plays: [play, ...current.plays],
    );
  }
  
  /// Undo last action
  Future<void> undo() async {
    final current = state;
    if (current == null || current.undoStack.isEmpty) return;
    
    final previousState = current.undoStack.last;
    
    // Delete the last play from DB
    if (current.plays.isNotEmpty) {
      await _repo.deletePlay(current.plays.first.id);
    }
    
    // Restore game state if needed
    await _repo.updateGame(current.game.id, {
      'home_score': previousState.game.homeScore,
      'away_score': previousState.game.awayScore,
      'is_offense': previousState.game.isOffense ? 1 : 0,
      'current_point_number': previousState.game.currentPointNumber,
    });
    
    state = previousState.copyWith(
      undoStack: current.undoStack.sublist(0, current.undoStack.length - 1),
      redoStack: [...current.redoStack, current],
    );
  }
  
  /// Redo last undone action
  Future<void> redo() async {
    final current = state;
    if (current == null || current.redoStack.isEmpty) return;
    
    final nextState = current.redoStack.last;
    
    state = nextState.copyWith(
      undoStack: [...current.undoStack, current],
      redoStack: current.redoStack.sublist(0, current.redoStack.length - 1),
    );
  }
  
  void _pushUndo() {
    if (state == null) return;
    state = state!.copyWith(
      undoStack: [...state!.undoStack, state!],
      redoStack: [],
    );
  }
}

/// Game repository provider
@riverpod
GameRepository gameRepository(GameRepositoryRef ref) {
  return GameRepository();
}
```

---

## 12. File Storage

### 12.1 Storage Service

**lib/core/storage/storage_service.dart**

```dart
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import '../config/supabase_config.dart';

class StorageService {
  final SupabaseStorageClient _storage = SupabaseConfig.storage;
  final _uuid = const Uuid();
  
  /// Upload team logo
  Future<String> uploadTeamLogo(String teamId, File file) async {
    final extension = path.extension(file.path);
    final filePath = 'teams/$teamId/logo$extension';
    
    await _storage.from('logos').upload(
      filePath,
      file,
      fileOptions: const FileOptions(
        cacheControl: '3600',
        upsert: true,
      ),
    );
    
    return _storage.from('logos').getPublicUrl(filePath);
  }
  
  /// Upload user avatar
  Future<String> uploadAvatar(String userId, File file) async {
    final extension = path.extension(file.path);
    final filePath = 'avatars/$userId$extension';
    
    await _storage.from('avatars').upload(
      filePath,
      file,
      fileOptions: const FileOptions(
        cacheControl: '3600',
        upsert: true,
      ),
    );
    
    return _storage.from('avatars').getPublicUrl(filePath);
  }
  
  /// Upload tournament logo
  Future<String> uploadTournamentLogo(String tournamentId, File file) async {
    final extension = path.extension(file.path);
    final filePath = 'tournaments/$tournamentId/logo$extension';
    
    await _storage.from('logos').upload(
      filePath,
      file,
      fileOptions: const FileOptions(
        cacheControl: '3600',
        upsert: true,
      ),
    );
    
    return _storage.from('logos').getPublicUrl(filePath);
  }
  
  /// Delete file
  Future<void> deleteFile(String bucket, String filePath) async {
    await _storage.from(bucket).remove([filePath]);
  }
}
```

### 12.2 Storage Bucket Configuration

**supabase/storage/buckets.sql**

```sql
-- Create storage buckets
INSERT INTO storage.buckets (id, name, public)
VALUES 
  ('avatars', 'avatars', true),
  ('logos', 'logos', true),
  ('exports', 'exports', false);

-- RLS policies for avatars bucket
CREATE POLICY "Avatar images are publicly accessible"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'avatars');

CREATE POLICY "Users can upload their own avatar"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'avatars' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

CREATE POLICY "Users can update their own avatar"
  ON storage.objects FOR UPDATE
  USING (
    bucket_id = 'avatars' AND
    auth.uid()::text = (storage.foldername(name))[1]
  );

-- RLS policies for logos bucket
CREATE POLICY "Logos are publicly accessible"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'logos');

CREATE POLICY "Team owners can upload logos"
  ON storage.objects FOR INSERT
  WITH CHECK (
    bucket_id = 'logos' AND
    EXISTS (
      SELECT 1 FROM public.teams
      WHERE id::text = (storage.foldername(name))[2]
        AND owner_id = auth.uid()
    )
  );
```

---

## 13. Edge Functions

### 13.1 PowerSync Token Function

**supabase/functions/powersync-token/index.ts**

```typescript
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"
import * as jose from "https://deno.land/x/jose@v4.9.0/index.ts"

const POWERSYNC_URL = Deno.env.get('POWERSYNC_URL')!
const POWERSYNC_PRIVATE_KEY = Deno.env.get('POWERSYNC_PRIVATE_KEY')!

serve(async (req) => {
  try {
    const { user_id } = await req.json()
    
    // Verify request is authenticated
    const authHeader = req.headers.get('Authorization')
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Unauthorized' }), { status: 401 })
    }
    
    // Generate PowerSync JWT
    const privateKey = await jose.importPKCS8(POWERSYNC_PRIVATE_KEY, 'RS256')
    
    const token = await new jose.SignJWT({
      sub: user_id,
      iat: Math.floor(Date.now() / 1000),
      exp: Math.floor(Date.now() / 1000) + 3600, // 1 hour
      parameters: {
        user_id: user_id,
      },
    })
      .setProtectedHeader({ alg: 'RS256', kid: 'powersync' })
      .sign(privateKey)
    
    return new Response(JSON.stringify({ token }), {
      headers: { 'Content-Type': 'application/json' },
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 })
  }
})
```

### 13.2 Send Invite Email Function

**supabase/functions/send-invite-email/index.ts**

```typescript
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

const RESEND_API_KEY = Deno.env.get('RESEND_API_KEY')!

serve(async (req) => {
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  )
  
  const { email, team_id } = await req.json()
  
  // Get team info
  const { data: team } = await supabase
    .from('teams')
    .select('name')
    .eq('id', team_id)
    .single()
  
  // Get invitation with code
  const { data: invite } = await supabase
    .from('invitations')
    .select('id, invite_code')
    .eq('email', email)
    .eq('team_id', team_id)
    .single()
  
  // Send email via Resend
  const response = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${RESEND_API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      from: 'Ultimate Hub <noreply@ultimatehub.app>',
      to: email,
      subject: `You've been invited to join ${team?.name} on Ultimate Hub`,
      html: `
        <h1>Team Invitation</h1>
        <p>You've been invited to join <strong>${team?.name}</strong> on Ultimate Hub.</p>
        <p>
          <a href="https://ultimatehub.app/invite/${invite?.invite_code}">
            Accept Invitation
          </a>
        </p>
        <p>This invitation expires in 7 days.</p>
      `,
    }),
  })
  
  return new Response(JSON.stringify({ success: true }), {
    headers: { 'Content-Type': 'application/json' },
  })
})
```

### 13.3 Stats Aggregation Function

**supabase/functions/aggregate-stats/index.ts**

```typescript
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

// Triggered by pg_cron daily or on-demand
serve(async (req) => {
  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  )
  
  // Refresh materialized view for career stats
  await supabase.rpc('refresh_career_stats')
  
  // Update pool standings for active tournaments
  const { data: activeTournaments } = await supabase
    .from('tournaments')
    .select('id')
    .eq('status', 'active')
  
  for (const tournament of activeTournaments || []) {
    await supabase.rpc('recalculate_tournament_standings', {
      p_tournament_id: tournament.id,
    })
  }
  
  return new Response(JSON.stringify({ success: true }))
})
```

---

## 14. Push Notifications

### 14.1 FCM Setup with Supabase

**lib/core/notifications/notification_service.dart**

```dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = 
      FlutterLocalNotificationsPlugin();
  
  Future<void> initialize() async {
    // Request permission
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Get FCM token
      final token = await _messaging.getToken();
      if (token != null) {
        await _saveToken(token);
      }
      
      // Listen for token refresh
      _messaging.onTokenRefresh.listen(_saveToken);
    }
    
    // Initialize local notifications
    await _localNotifications.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );
    
    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    
    // Handle background message tap
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  }
  
  Future<void> _saveToken(String token) async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;
    
    await Supabase.instance.client
        .from('user_push_tokens')
        .upsert({
          'user_id': userId,
          'token': token,
          'platform': Platform.isIOS ? 'ios' : 'android',
          'updated_at': DateTime.now().toIso8601String(),
        });
  }
  
  void _handleForegroundMessage(RemoteMessage message) {
    _localNotifications.show(
      message.hashCode,
      message.notification?.title,
      message.notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'game_updates',
          'Game Updates',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: message.data['game_id'],
    );
  }
  
  void _handleMessageOpenedApp(RemoteMessage message) {
    final gameId = message.data['game_id'];
    if (gameId != null) {
      // Navigate to game
      // router.push('/games/$gameId');
    }
  }
  
  void _onNotificationTap(NotificationResponse response) {
    final gameId = response.payload;
    if (gameId != null) {
      // Navigate to game
    }
  }
  
  /// Subscribe to game updates
  Future<void> subscribeToGame(String gameId) async {
    await _messaging.subscribeToTopic('game_$gameId');
  }
  
  /// Subscribe to team updates
  Future<void> subscribeToTeam(String teamId) async {
    await _messaging.subscribeToTopic('team_$teamId');
  }
  
  /// Unsubscribe from game
  Future<void> unsubscribeFromGame(String gameId) async {
    await _messaging.unsubscribeFromTopic('game_$gameId');
  }
}
```

### 14.2 Database Trigger for Notifications

**supabase/migrations/20260102000002_notification_triggers.sql**

```sql
-- User push tokens table
CREATE TABLE public.user_push_tokens (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
  token TEXT NOT NULL,
  platform TEXT NOT NULL CHECK (platform IN ('ios', 'android', 'web')),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, token)
);

-- Function to send push notification via Edge Function
CREATE OR REPLACE FUNCTION notify_game_score()
RETURNS TRIGGER AS $$
DECLARE
  old_total INTEGER;
  new_total INTEGER;
BEGIN
  old_total := OLD.home_score + OLD.away_score;
  new_total := NEW.home_score + NEW.away_score;
  
  -- Only notify on score changes
  IF new_total > old_total THEN
    PERFORM net.http_post(
      url := CONCAT(current_setting('app.supabase_url'), '/functions/v1/send-push'),
      headers := jsonb_build_object(
        'Authorization', CONCAT('Bearer ', current_setting('app.service_role_key')),
        'Content-Type', 'application/json'
      ),
      body := jsonb_build_object(
        'topic', CONCAT('game_', NEW.id),
        'title', CONCAT(NEW.home_team_name, ' ', NEW.home_score, ' - ', NEW.away_score, ' ', NEW.away_team_name),
        'body', 'Score update!',
        'data', jsonb_build_object('game_id', NEW.id)
      )
    );
  END IF;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_game_score_change
  AFTER UPDATE OF home_score, away_score ON public.games
  FOR EACH ROW EXECUTE FUNCTION notify_game_score();
```

---

## 15. Deployment & DevOps

### 15.1 Environment Configuration

**.env.development**

```bash
SUPABASE_URL=http://localhost:54321
SUPABASE_ANON_KEY=your-local-anon-key
POWERSYNC_URL=https://your-dev-instance.powersync.journeyapps.com
```

**.env.production**

```bash
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-prod-anon-key
POWERSYNC_URL=https://your-prod-instance.powersync.journeyapps.com
```

### 15.2 CI/CD Pipeline (GitHub Actions)

**.github/workflows/deploy.yml**

```yaml
name: Deploy

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          channel: 'stable'
          cache: true
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Run code generation
        run: flutter pub run build_runner build --delete-conflicting-outputs
      
      - name: Analyze
        run: flutter analyze
      
      - name: Run tests
        run: flutter test --coverage
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: coverage/lcov.info

  deploy-supabase:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: supabase/setup-cli@v1
        with:
          version: latest
      
      - name: Link Supabase project
        run: supabase link --project-ref ${{ secrets.SUPABASE_PROJECT_REF }}
        env:
          SUPABASE_ACCESS_TOKEN: ${{ secrets.SUPABASE_ACCESS_TOKEN }}
      
      - name: Run migrations
        run: supabase db push
      
      - name: Deploy Edge Functions
        run: supabase functions deploy

  build-android:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-java@v3
        with:
          distribution: 'zulu'
          java-version: '17'
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          channel: 'stable'
          cache: true
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Run code generation
        run: flutter pub run build_runner build --delete-conflicting-outputs
      
      - name: Build APK
        run: flutter build apk --release
        env:
          SUPABASE_URL: ${{ secrets.SUPABASE_URL }}
          SUPABASE_ANON_KEY: ${{ secrets.SUPABASE_ANON_KEY }}
      
      - name: Upload APK
        uses: actions/upload-artifact@v3
        with:
          name: android-release
          path: build/app/outputs/flutter-apk/app-release.apk

  build-ios:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          channel: 'stable'
          cache: true
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Run code generation
        run: flutter pub run build_runner build --delete-conflicting-outputs
      
      - name: Build iOS
        run: flutter build ios --release --no-codesign
```

### 15.3 Supabase Production Checklist

```markdown
## Pre-Launch Checklist

### Database
- [ ] All migrations tested locally and on staging
- [ ] RLS policies enabled on all tables
- [ ] Indexes created for common queries
- [ ] Database backups configured (PITR enabled)
- [ ] Connection pooling configured (Supavisor)

### Authentication
- [ ] OAuth providers configured (Google, Apple)
- [ ] Email templates customized
- [ ] Password policies configured
- [ ] Rate limiting enabled

### Storage
- [ ] Buckets created with proper RLS
- [ ] Image optimization enabled
- [ ] CDN caching configured

### Edge Functions
- [ ] All functions deployed
- [ ] Environment variables set
- [ ] Error monitoring configured

### Security
- [ ] API keys rotated
- [ ] Service role key secured
- [ ] CORS configured properly
- [ ] Rate limiting enabled

### Monitoring
- [ ] Logs configured
- [ ] Alerts set up for errors
- [ ] Performance monitoring enabled
```

---

## 16. Development Workflow

### 16.1 Local Development Setup

```bash
# 1. Clone repository
git clone https://github.com/your-org/ultimate-hub.git
cd ultimate-hub

# 2. Install Flutter dependencies
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# 3. Start Supabase locally
supabase start

# 4. Apply migrations
supabase db reset  # This runs all migrations

# 5. Start PowerSync local (optional)
# Or use PowerSync cloud dev instance

# 6. Run the app
flutter run
```

### 16.2 Database Migration Workflow

```bash
# Create new migration
supabase migration new add_spirit_scores

# Edit the migration file
# supabase/migrations/20260102123456_add_spirit_scores.sql

# Test locally
supabase db reset

# Push to production (after PR merge)
supabase db push
```

### 16.3 Code Generation Commands

```bash
# Generate Freezed/JSON serialization code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode for development
flutter pub run build_runner watch --delete-conflicting-outputs

# Generate Riverpod providers
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## 17. Testing Strategy

### 17.1 Unit Tests

**test/features/games/game_repository_test.dart**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ultimate_hub/features/games/data/game_repository.dart';
import 'package:ultimate_hub/features/games/data/models/game.dart';

class MockPowerSyncDatabase extends Mock implements PowerSyncDatabase {}

void main() {
  late GameRepository repository;
  late MockPowerSyncDatabase mockDb;
  
  setUp(() {
    mockDb = MockPowerSyncDatabase();
    repository = GameRepository(database: mockDb);
  });
  
  group('GameRepository', () {
    test('createGame inserts game and returns it', () async {
      when(() => mockDb.execute(any(), any())).thenAnswer((_) async => {});
      
      final game = await repository.createGame(
        homeTeamName: 'Ring of Fire',
        awayTeamName: 'Truck Stop',
        createdBy: 'user-123',
      );
      
      expect(game.homeTeamName, 'Ring of Fire');
      expect(game.awayTeamName, 'Truck Stop');
      expect(game.status, GameStatus.setup);
      
      verify(() => mockDb.execute(any(), any())).called(1);
    });
    
    test('logPlay increments sequence number', () async {
      when(() => mockDb.execute(any(), any())).thenAnswer((_) async => {});
      
      final play = await repository.logPlay(
        gameId: 'game-123',
        type: PlayType.pass,
        teamSide: TeamSide.home,
        pointNumber: 1,
        sequenceNumber: 5,
        primaryPlayerId: 'player-1',
        secondaryPlayerId: 'player-2',
      );
      
      expect(play.sequenceNumber, 5);
      expect(play.type, PlayType.pass);
    });
  });
}
```

### 17.2 Widget Tests

**test/features/games/widgets/score_display_test.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ultimate_hub/features/games/data/models/game.dart';
import 'package:ultimate_hub/features/games/presentation/widgets/score_display.dart';

void main() {
  testWidgets('ScoreDisplay shows correct scores', (tester) async {
    final game = Game(
      id: '123',
      homeTeamName: 'Home',
      awayTeamName: 'Away',
      homeScore: 7,
      awayScore: 5,
      createdBy: 'user',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ScoreDisplay(game: game),
        ),
      ),
    );
    
    expect(find.text('7'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Away'), findsOneWidget);
  });
}
```

### 17.3 Integration Tests

**integration_test/game_tracking_test.dart**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ultimate_hub/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Game Tracking Flow', () {
    testWidgets('Complete game tracking flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      // Create new game
      await tester.tap(find.text('Start New Game'));
      await tester.pumpAndSettle();
      
      // Fill game setup
      await tester.enterText(
        find.byKey(const Key('home_team_input')),
        'Ring of Fire',
      );
      await tester.enterText(
        find.byKey(const Key('away_team_input')),
        'Truck Stop',
      );
      
      await tester.tap(find.text('Start Game'));
      await tester.pumpAndSettle();
      
      // Verify we're on tracker screen
      expect(find.text('0 - 0'), findsOneWidget);
      
      // Log a goal
      await tester.tap(find.byKey(const Key('player_1')));
      await tester.pumpAndSettle();
      
      await tester.tap(find.byKey(const Key('player_2')));
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('GOAL'));
      await tester.pumpAndSettle();
      
      // Verify score updated
      expect(find.text('1 - 0'), findsOneWidget);
    });
  });
}
```

---

## 18. Performance Optimization

### 18.1 Database Optimization

```sql
-- Partial indexes for active games
CREATE INDEX idx_games_active_partial 
  ON public.games(updated_at DESC)
  WHERE status IN ('active', 'halftime', 'soft_cap', 'hard_cap');

-- Covering index for game list queries
CREATE INDEX idx_games_list_covering
  ON public.games(created_by, updated_at DESC)
  INCLUDE (id, home_team_name, away_team_name, home_score, away_score, status);

-- Analyze tables after bulk inserts
ANALYZE public.plays;
ANALYZE public.games;
```

### 18.2 Flutter Optimizations

```dart
// Use const constructors
class ScoreDisplay extends StatelessWidget {
  const ScoreDisplay({super.key, required this.game});
  
  final Game game;
  
  @override
  Widget build(BuildContext context) {
    return const _ScoreLayout();  // Extract to const widget
  }
}

// Use ListView.builder for long lists
ListView.builder(
  itemCount: plays.length,
  itemBuilder: (context, index) => PlayTile(play: plays[index]),
)

// Cache expensive computations
@riverpod
Future<CareerStats> careerStats(CareerStatsRef ref, String userId) async {
  // This is automatically cached by Riverpod
  return await ref.read(statsRepositoryProvider).getCareerStats(userId);
}
```

### 18.3 Offline Performance

```dart
// Batch database operations
Future<void> logMultiplePlays(List<Play> plays) async {
  final batch = database.batch();
  for (final play in plays) {
    batch.insert('plays', play.toJson());
  }
  await batch.commit();
}

// Compress sync payloads
// PowerSync handles this automatically

// Limit initial sync scope
// Only sync games from last 30 days by default
```

---

## 19. Migration Path

### 19.1 From Local-Only to Supabase

If you've built Phase 1 with local-only storage:

```dart
// 1. Add Supabase dependencies to pubspec.yaml

// 2. Initialize Supabase alongside existing storage
Future<void> main() async {
  await SupabaseConfig.initialize();
  await LocalDatabase.initialize();  // Keep existing
  await SyncEngine.initialize();  // Add sync layer
  
  runApp(const App());
}

// 3. Create migration to upload existing data
Future<void> migrateToCloud(String userId) async {
  final localGames = await LocalDatabase.getAllGames();
  
  for (final game in localGames) {
    // Upload to Supabase
    await supabase.from('games').upsert({
      ...game.toJson(),
      'created_by': userId,
      'sync_version': 1,
    });
    
    // Upload plays
    final plays = await LocalDatabase.getPlays(game.id);
    await supabase.from('plays').upsert(
      plays.map((p) => p.toJson()).toList(),
    );
  }
  
  // Mark migration complete
  await preferences.setBool('migrated_to_cloud', true);
}
```

### 19.2 Future: Self-Hosted Option

If you need to self-host later:

```bash
# Supabase is open source - you can self-host
docker compose up -d  # Run Supabase stack

# Or use platforms like:
# - Railway (one-click Supabase deploy)
# - DigitalOcean (Supabase marketplace)
# - Your own Kubernetes cluster
```

The database is standard Postgres, so migration is straightforward:

```bash
# Export from Supabase
pg_dump -h db.your-project.supabase.co -U postgres > backup.sql

# Import to self-hosted
psql -h your-server.com -U postgres < backup.sql
```

---

## Summary

This document provides the complete technical specification for Ultimate Hub using Flutter + Supabase:

| Component | Technology | Purpose |
|-----------|------------|---------|
| Frontend | Flutter | Cross-platform mobile/web |
| State | Riverpod + Freezed | Reactive, type-safe state |
| Database | Supabase (Postgres) | Relational data store |
| Auth | Supabase Auth | Email + OAuth |
| Realtime | Supabase Realtime | Live updates for spectators |
| Offline | PowerSync + SQLite | Offline-first architecture |
| Storage | Supabase Storage | Logos, avatars |
| Functions | Supabase Edge Functions | Server-side logic |
| Push | Firebase Cloud Messaging | Notifications |

**Key advantages of this stack:**
- Relational database perfect for Ultimate's complex data relationships
- Full offline support for field conditions without internet
- Real-time subscriptions for spectator features
- Row-level security for multi-tenant data
- Exit strategy (it's just Postgres)
- Generous free tier for MVP

**Next steps:**
1. Set up Supabase project
2. Run initial migrations
3. Implement auth flow
4. Build game tracking with offline sync
5. Add real-time spectator view
6. Deploy and test

Ultimate Hub is positioned to become the definitive platform for Ultimate Frisbee. Execute with excellence.
