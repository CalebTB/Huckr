-- ============================================================================
-- Migration: Add Halftime Scores and Game Notes
-- ============================================================================
-- Adds support for automatic halftime score tracking and post-game notes
-- for simple mode game tracking
-- ============================================================================

-- Add halftime score fields to games table
ALTER TABLE games
ADD COLUMN halftime_home_score INTEGER,
ADD COLUMN halftime_away_score INTEGER,
ADD COLUMN game_notes TEXT;

-- Add comments for documentation
COMMENT ON COLUMN games.halftime_home_score IS 'Home team score at halftime (automatically captured)';
COMMENT ON COLUMN games.halftime_away_score IS 'Away team score at halftime (automatically captured)';
COMMENT ON COLUMN games.game_notes IS 'Post-game notes (injuries, notable plays, comments) - max 500 chars';
