-- ============================================================================
-- Migration: Dynamic Halftime Calculation
-- ============================================================================
-- Changes halftime_at from a required field to an optional override field.
-- Halftime is now calculated dynamically as (game_to_points / 2) rounded up.
-- ============================================================================

-- Rename the existing halftime_at column to halftime_at_override
ALTER TABLE games
RENAME COLUMN halftime_at TO halftime_at_override;

-- Make it nullable (it's already an integer, just remove NOT NULL if it exists)
ALTER TABLE games
ALTER COLUMN halftime_at_override DROP NOT NULL;

-- Update existing games to NULL (so they use the dynamic calculation)
UPDATE games
SET halftime_at_override = NULL
WHERE halftime_at_override = CEIL(game_to_points::NUMERIC / 2);

-- Add comment explaining the new logic
COMMENT ON COLUMN games.halftime_at_override IS 'Optional override for halftime point. If NULL, halftime is calculated as CEIL(game_to_points / 2). Examples: Game to 15 → 8, Game to 13 → 7, Game to 11 → 6';
