# Supabase Database Setup

This directory contains SQL migrations for the Ultimate Hub Supabase database.

## Quick Start

### Option 1: Run via Supabase Dashboard (Recommended)

1. Go to your Supabase project: https://app.supabase.com
2. Navigate to **SQL Editor** in the left sidebar
3. Click **New Query**
4. Copy the contents of `migrations/001_create_live_game_tables.sql`
5. Paste into the SQL Editor
6. Click **Run** (or press `Cmd+Enter` / `Ctrl+Enter`)
7. Wait for "Success. No rows returned" message

### Option 2: Run via Supabase CLI

```bash
# Install Supabase CLI if you haven't
npm install -g supabase

# Link to your project
supabase link --project-ref your-project-ref

# Run migrations
supabase db push
```

## What Gets Created

### Tables

**`games`** - Core game entity
- 30+ columns for teams, scores, settings, timing, tracking, sync
- Stores game state (scheduled, in progress, completed, etc.)
- Tracks weather conditions and delays
- Offline sync metadata

**`game_points`** - Point-level aggregation
- Starting/receiving teams per point
- Line types (O-line vs D-line)
- Players on field
- Turnover statistics
- Point timing and scoring

**`plays`** - Individual play actions
- Play type (pull, catch, throw, turnover, goal, etc.)
- Player information
- Field position (normalized 0-1 coordinates)
- Target players for throws
- Timestamp for chronological order

### Indexes

Performance indexes for:
- Tournament/team lookups
- Game status queries
- Play queries by game/point
- Timestamp-based sorting

### Security

**Row-Level Security (RLS)** enabled on all tables:
- **Public read** - Anyone can view games (spectator mode)
- **Authenticated write** - Only authenticated users can create/update
- **Owner-only updates** - Users can only modify games they're tracking

### Realtime

All tables enabled for Realtime subscriptions:
- Subscribe to live game updates
- Watch plays as they're recorded
- Real-time spectator experience

## Verification

After running the migration, verify in Supabase Dashboard:

1. **Table Editor** → Should see `games`, `game_points`, `plays` tables
2. **Database** → Indexes → Should see all indexes created
3. **Authentication** → Policies → Should see RLS policies for each table
4. **Database** → Triggers → Should see `games_updated_at` trigger

## Troubleshooting

**Error: "extension uuid-ossp does not exist"**
- The migration will create it automatically
- If it fails, you may need to enable it manually in **Database → Extensions**

**Error: "permission denied for relation"**
- Ensure you're running the migration as a superuser (should be default)
- Check that RLS is enabled correctly

**Error: "publication supabase_realtime does not exist"**
- This is a Supabase-managed publication
- If it doesn't exist, Realtime isn't enabled on your project
- Contact Supabase support or check project settings

## Next Steps

After successful migration:

1. ✅ Tables created with proper schema
2. ✅ Indexes created for performance
3. ✅ RLS policies protecting data
4. ✅ Realtime enabled for live updates
5. 🔄 Create `.env` file with your Supabase credentials
6. 🔄 Implement data sources in Flutter app (Phase 5-6)
7. 🔄 Test offline-first sync behavior

## Schema Diagram

```
┌─────────────────────────────────────────────────────────┐
│                         games                            │
├─────────────────────────────────────────────────────────┤
│ id (UUID, PK)                                            │
│ tournament_id, pool_id, bracket_position                │
│ home_team_id, away_team_id, home_team_name, etc.       │
│ home_score, away_score                                   │
│ game_to_points, hard_cap_points, halftime_at            │
│ status, current_point, current_possession                │
│ started_at, ended_at, soft_cap_started_at, etc.         │
│ tracked_by_user_id, is_synced, last_synced_at          │
└─────────────────────────────────────────────────────────┘
                            │
                            │ game_id (FK)
                            ▼
┌─────────────────────────────────────────────────────────┐
│                      game_points                         │
├─────────────────────────────────────────────────────────┤
│ id (UUID, PK)                                            │
│ game_id (FK → games)                                     │
│ point_number                                             │
│ starting_team_id, receiving_team_id, scoring_team_id    │
│ home_line_type, away_line_type                          │
│ home_players_on_field[], away_players_on_field[]        │
│ total_turnovers, home_turnovers, away_turnovers         │
│ start_time, end_time                                     │
└─────────────────────────────────────────────────────────┘
                            │
                            │ point_id (FK)
                            ▼
┌─────────────────────────────────────────────────────────┐
│                         plays                            │
├─────────────────────────────────────────────────────────┤
│ id (UUID, PK)                                            │
│ game_id (FK → games)                                     │
│ point_id (FK → game_points)                              │
│ play_number                                              │
│ player_id, player_name, player_jersey_number, team_id   │
│ type (pull, catch, throw, turnover, goal, etc.)         │
│ field_x, field_y (normalized coordinates)               │
│ target_player_id, target_player_name                    │
│ turnover_type, notes                                     │
│ timestamp, stall_count                                   │
│ is_synced, synced_at                                     │
└─────────────────────────────────────────────────────────┘
```

## Support

If you encounter issues:
1. Check Supabase logs in Dashboard → Logs
2. Verify your Supabase project is active
3. Ensure you have the correct project ref in `.env`
4. Review the migration SQL for any syntax errors
