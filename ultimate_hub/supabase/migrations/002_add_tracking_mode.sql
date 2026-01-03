-- Add tracking mode column to games table
-- Simple mode (true) = quick entry with goals/assists only
-- Advanced mode (false) = full stats with pulls, field position, etc.

ALTER TABLE games
ADD COLUMN is_simple_tracking BOOLEAN DEFAULT true NOT NULL;

-- Add comment for documentation
COMMENT ON COLUMN games.is_simple_tracking IS 'Tracking mode: true = simple (goals/assists), false = advanced (full stats)';
