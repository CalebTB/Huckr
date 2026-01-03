-- ============================================================================
-- Supabase Migration: Live Game Tracking Tables
-- ============================================================================
-- This migration creates the database schema for Ultimate Hub's Phase 1
-- live game tracking feature with offline-first sync support.
--
-- Tables:
--   - games: Core game entity with teams, scores, settings, and timing
--   - plays: Individual play actions (pull, catch, throw, turnover, goal, etc.)
--   - game_points: Point-level aggregation (starting teams, line types, turnovers)
--
-- Features:
--   - Row-Level Security (RLS) for multi-user access control
--   - Realtime subscriptions for spectator mode
--   - Indexes for query performance
--   - Automatic updated_at timestamps
-- ============================================================================

-- Enable UUID extension for primary keys
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================================================
-- TABLE: games
-- ============================================================================
-- Core game entity tracking teams, scores, game settings, and status
CREATE TABLE games (
  -- Primary key
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

  -- Tournament/Pool context (Phase 2+)
  tournament_id UUID,
  pool_id TEXT,
  bracket_position TEXT,

  -- Teams
  home_team_id UUID NOT NULL,
  away_team_id UUID NOT NULL,
  home_team_name TEXT NOT NULL,
  away_team_name TEXT NOT NULL,
  home_team_logo TEXT,
  away_team_logo TEXT,

  -- Score
  home_score INTEGER DEFAULT 0,
  away_score INTEGER DEFAULT 0,

  -- Game settings
  game_to_points INTEGER DEFAULT 15,
  hard_cap_points INTEGER DEFAULT 17,
  halftime_at INTEGER DEFAULT 8,
  soft_cap_minutes INTEGER DEFAULT 75,
  hard_cap_minutes INTEGER DEFAULT 90,

  -- Status
  status TEXT NOT NULL DEFAULT 'scheduled'
    CHECK (status IN ('scheduled', 'warmup', 'inProgress', 'halftime', 'softCap', 'hardCap', 'delayed', 'completed', 'cancelled')),
  current_point INTEGER DEFAULT 1,
  current_possession UUID,

  -- Timing
  scheduled_at TIMESTAMPTZ,
  started_at TIMESTAMPTZ,
  halftime_started_at TIMESTAMPTZ,
  soft_cap_started_at TIMESTAMPTZ,
  hard_cap_started_at TIMESTAMPTZ,
  ended_at TIMESTAMPTZ,

  -- Delays
  is_delayed BOOLEAN DEFAULT false,
  delay_reason TEXT
    CHECK (delay_reason IS NULL OR delay_reason IN ('weather', 'injury', 'technical', 'other')),
  delay_notes TEXT,
  delay_started_at TIMESTAMPTZ,

  -- Weather conditions
  wind_speed TEXT,
  wind_direction TEXT,
  weather_notes TEXT,

  -- Tracking metadata
  is_being_tracked BOOLEAN DEFAULT false,
  tracked_by_user_id UUID,
  tracked_by_user_name TEXT,

  -- Sync metadata (for offline-first architecture)
  is_synced BOOLEAN DEFAULT false,
  last_synced_at TIMESTAMPTZ,

  -- Timestamps
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- TABLE: game_points
-- ============================================================================
-- Point-level aggregation tracking starting teams, line types, and stats
CREATE TABLE game_points (
  -- Primary key
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

  -- Foreign key to game
  game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,

  -- Point metadata
  point_number INTEGER NOT NULL,

  -- Teams
  starting_team_id UUID NOT NULL,
  receiving_team_id UUID NOT NULL,
  scoring_team_id UUID,

  -- Line types (offense or defense)
  home_line_type TEXT NOT NULL
    CHECK (home_line_type IN ('offense', 'defense')),
  away_line_type TEXT NOT NULL
    CHECK (away_line_type IN ('offense', 'defense')),

  -- Players on field (array of UUIDs)
  home_players_on_field UUID[],
  away_players_on_field UUID[],

  -- Turnover stats
  total_turnovers INTEGER DEFAULT 0,
  home_turnovers INTEGER DEFAULT 0,
  away_turnovers INTEGER DEFAULT 0,

  -- Timing
  start_time TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  end_time TIMESTAMPTZ,

  -- Score at start of point
  home_score_at_start INTEGER NOT NULL,
  away_score_at_start INTEGER NOT NULL,

  -- Sync metadata
  is_synced BOOLEAN DEFAULT false,

  -- Constraints
  CONSTRAINT unique_game_point UNIQUE(game_id, point_number)
);

-- ============================================================================
-- TABLE: plays
-- ============================================================================
-- Individual play actions with player, type, and field position tracking
CREATE TABLE plays (
  -- Primary key
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

  -- Foreign keys
  game_id UUID NOT NULL REFERENCES games(id) ON DELETE CASCADE,
  point_id UUID NOT NULL REFERENCES game_points(id) ON DELETE CASCADE,

  -- Play metadata
  play_number INTEGER NOT NULL,

  -- Player info
  player_id UUID,
  player_name TEXT,
  player_jersey_number INTEGER,
  team_id UUID NOT NULL,

  -- Action details
  type TEXT NOT NULL
    CHECK (type IN ('pull', 'catch', 'throw', 'drop', 'throwaway', 'stall', 'outOfBounds', 'block', 'interception', 'goal', 'callahan', 'timeout', 'injury', 'substitution')),
  notes TEXT,

  -- Field position (normalized 0-1 coordinates)
  field_x DECIMAL(4,3)
    CHECK (field_x IS NULL OR (field_x >= 0 AND field_x <= 1)),
  field_y DECIMAL(4,3)
    CHECK (field_y IS NULL OR (field_y >= 0 AND field_y <= 1)),

  -- For completed throws
  target_player_id UUID,
  target_player_name TEXT,

  -- For turnovers
  turnover_type TEXT,

  -- Timing
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  stall_count INTEGER,

  -- Sync metadata
  is_synced BOOLEAN DEFAULT false,
  synced_at TIMESTAMPTZ
);

-- ============================================================================
-- INDEXES
-- ============================================================================
-- Performance indexes for common queries

-- Games indexes
CREATE INDEX idx_games_tournament ON games(tournament_id);
CREATE INDEX idx_games_home_team ON games(home_team_id);
CREATE INDEX idx_games_away_team ON games(away_team_id);
CREATE INDEX idx_games_status ON games(status);
CREATE INDEX idx_games_tracked_by ON games(tracked_by_user_id);
CREATE INDEX idx_games_scheduled_at ON games(scheduled_at);

-- Game points indexes
CREATE INDEX idx_game_points_game ON game_points(game_id);
CREATE INDEX idx_game_points_point_number ON game_points(game_id, point_number);

-- Plays indexes
CREATE INDEX idx_plays_game ON plays(game_id);
CREATE INDEX idx_plays_point ON plays(point_id);
CREATE INDEX idx_plays_player ON plays(player_id);
CREATE INDEX idx_plays_timestamp ON plays(timestamp);
CREATE INDEX idx_plays_game_timestamp ON plays(game_id, timestamp);

-- ============================================================================
-- TRIGGERS
-- ============================================================================
-- Automatic updated_at timestamp

-- Function to update updated_at column
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for games table
CREATE TRIGGER games_updated_at
  BEFORE UPDATE ON games
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

-- ============================================================================
-- ROW-LEVEL SECURITY (RLS)
-- ============================================================================

-- Enable RLS on all tables
ALTER TABLE games ENABLE ROW LEVEL SECURITY;
ALTER TABLE game_points ENABLE ROW LEVEL SECURITY;
ALTER TABLE plays ENABLE ROW LEVEL SECURITY;

-- ----------------------------------------------------------------------------
-- GAMES RLS POLICIES
-- ----------------------------------------------------------------------------

-- Public read access for all games (spectator mode)
CREATE POLICY "Games are viewable by everyone"
  ON games FOR SELECT
  USING (true);

-- Authenticated users can create games
CREATE POLICY "Authenticated users can create games"
  ON games FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

-- Users can update games they're tracking
CREATE POLICY "Users can update games they're tracking"
  ON games FOR UPDATE
  USING (tracked_by_user_id = auth.uid());

-- Users can delete games they created (tracked)
CREATE POLICY "Users can delete games they're tracking"
  ON games FOR DELETE
  USING (tracked_by_user_id = auth.uid());

-- ----------------------------------------------------------------------------
-- GAME POINTS RLS POLICIES
-- ----------------------------------------------------------------------------

-- Anyone can view game points (public spectator mode)
CREATE POLICY "Game points are viewable by everyone"
  ON game_points FOR SELECT
  USING (true);

-- Authenticated users can create game points
CREATE POLICY "Authenticated users can create game points"
  ON game_points FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

-- Users can update points for games they're tracking
CREATE POLICY "Users can update points for their games"
  ON game_points FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM games
      WHERE games.id = game_points.game_id
      AND games.tracked_by_user_id = auth.uid()
    )
  );

-- Users can delete points for games they're tracking
CREATE POLICY "Users can delete points for their games"
  ON game_points FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM games
      WHERE games.id = game_points.game_id
      AND games.tracked_by_user_id = auth.uid()
    )
  );

-- ----------------------------------------------------------------------------
-- PLAYS RLS POLICIES
-- ----------------------------------------------------------------------------

-- Anyone can view plays (public spectator mode)
CREATE POLICY "Plays are viewable by everyone"
  ON plays FOR SELECT
  USING (true);

-- Authenticated users can create plays
CREATE POLICY "Authenticated users can create plays"
  ON plays FOR INSERT
  WITH CHECK (auth.role() = 'authenticated');

-- Users can update plays for games they're tracking
CREATE POLICY "Users can update plays for their games"
  ON plays FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM games
      WHERE games.id = plays.game_id
      AND games.tracked_by_user_id = auth.uid()
    )
  );

-- Users can delete plays for games they're tracking
CREATE POLICY "Users can delete plays for their games"
  ON plays FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM games
      WHERE games.id = plays.game_id
      AND games.tracked_by_user_id = auth.uid()
    )
  );

-- ============================================================================
-- REALTIME SUBSCRIPTIONS
-- ============================================================================
-- Enable Realtime for spectator mode

-- Enable Realtime publication for all tables
ALTER PUBLICATION supabase_realtime ADD TABLE games;
ALTER PUBLICATION supabase_realtime ADD TABLE game_points;
ALTER PUBLICATION supabase_realtime ADD TABLE plays;

-- ============================================================================
-- MIGRATION COMPLETE
-- ============================================================================
-- You can now:
-- 1. Create games with offline-first sync
-- 2. Record plays in real-time
-- 3. Track game points and statistics
-- 4. Subscribe to live updates for spectator mode
-- 5. Query game history and analytics
--
-- Next steps:
-- - Implement data sources in Flutter app
-- - Test offline-first sync behavior
-- - Enable Supabase Auth for user tracking (Phase 2)
-- ============================================================================
