-- ============================================================================
-- Migration: Add Original Game To Points
-- ============================================================================
-- Adds originalGameToPoints field to track the initial game format.
-- This ensures halftime is calculated correctly even when caps change the target.
--
-- Example: Game starts as "game to 15" (halftime at 8). Soft cap hits and
-- game becomes "game to 12". Halftime should still be at 8, not 6.
-- ============================================================================

-- Add original_game_to_points column
ALTER TABLE games
ADD COLUMN original_game_to_points INTEGER;

-- For existing games, copy game_to_points to original_game_to_points
UPDATE games
SET original_game_to_points = game_to_points
WHERE original_game_to_points IS NULL;

-- Add comment for documentation
COMMENT ON COLUMN games.original_game_to_points IS 'Original game target before any cap adjustments. Used for halftime calculation. If NULL, same as game_to_points.';
