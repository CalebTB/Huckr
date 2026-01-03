# Red Zone Tracking - Future Enhancement

## Overview

Optional feature for Advanced Mode to track where scoring throws originated from, providing meaningful strategic insights about offensive efficiency.

## Rationale (from Ultimate Frisbee Guru)

**Most valuable location-based stat** - Red zone conversion rates help players understand their offensive strategy and efficiency better than any other zone-based tracking.

### Why Red Zone Tracking Matters

**Offensive Efficiency Analysis:**
- Teams scoring from red zone = structured, methodical offense
- Teams scoring from midfield/deep = relying on athleticism and hucks
- Post-game insight: "We scored 70% from red zone in wins vs 40% in losses = forcing bad hucks when behind"

**Strategic Insights:**
- High red zone % = patient, disciplined offense
- High deep % = fast-break ultimate, big throw reliance
- Opponent scouting: "They scored 6/8 from red zone - need to force them to work disc upfield"

**Environmental Analysis:**
- Downwind = more deep goals expected
- Upwind = more red zone grinding expected

## Implementation Design

### Zone Definitions

**Three categorical zones based on throw origin:**

1. **Red Zone (0-20 yards from goal line)**
   - Short dishes, dump-swing goals
   - Structured possession offense
   - Label: "Red Zone" or "Short"

2. **Midfield (20-40 yards from goal line)**
   - Standard hucks, break throws
   - Most common scoring distance
   - Label: "Midfield" or "Medium"

3. **Deep (40+ yards from goal line)**
   - Full-field hucks, bombs
   - Athletic, high-risk plays
   - Label: "Deep" or "Huck"

### Smart Defaults

**Context-aware pre-selection to minimize user input:**

```dart
// Auto-select zone based on context
if (possessionStartedInRedZone) {
  defaultZone = 'red_zone';
} else if (possessionStartedPastMidfield) {
  defaultZone = 'midfield';
} else if (isDLineGoal) { // Turnover -> goal
  defaultZone = 'deep'; // Break opportunities often = hucks
} else {
  defaultZone = 'midfield'; // Safe default
}
```

User can quickly confirm or adjust with one tap.

### UI Flow

**After goal scored in Advanced Mode:**

```
┌─────────────────────────────────────┐
│  Goal: Player A                     │
│  Assist: Player B                   │
│                                     │
│  Scoring throw distance:            │
│  ○ Red Zone (0-20yds) - Short       │
│  ● Midfield (20-40yds) - Medium ⭐  │ ← Auto-selected
│  ○ Deep (40+yds) - Huck             │
│                                     │
│  [Confirm ✓]  [Skip →]              │
└─────────────────────────────────────┘
```

**Design notes:**
- Show as bottom sheet (not blocking dialog)
- Auto-dismiss after 3 seconds if no input (uses default)
- Haptic feedback on selection
- Skippable (sets zone to null)

### Data Storage

**In Play entity:**

```dart
class Play {
  // Existing fields...
  String? fieldZone; // 'red_zone', 'midfield', 'deep', or null
}
```

**Alternative field names considered:**
- `throwOriginZone` - more descriptive
- `scoringZone` - shorter
- `zone` - simplest (current)

### Post-Game Display

**Game Summary Screen:**

```
┌────────────── Goal Efficiency ──────────────┐
│                                              │
│  YOUR TEAM              OPPONENT             │
│  Red Zone:    8 (53%)   3 (25%)             │
│  Midfield:    5 (33%)   4 (33%)             │
│  Deep:        2 (14%)   5 (42%)             │
│                                              │
│  💡 Insight: You controlled possession and  │
│     scored methodically. They relied on     │
│     big throws.                             │
└──────────────────────────────────────────────┘
```

**Tournament Analytics (future):**
- Compare red zone % across games
- "You're 85% efficient in red zone - keep working the disc upfield!"
- Wind correlation: "Downwind games: 60% deep, Upwind games: 20% deep"

## Implementation Steps

### Phase 1: Basic Tracking
1. Add zone picker dialog (similar to removed GoalZonePicker but with correct zones)
2. Update `playLogProvider.recordGoal()` to accept zone parameter
3. Store in Play.fieldZone
4. Display in play-by-play feed: "Goal (Deep) - Player A from Player B"

### Phase 2: Smart Defaults
1. Track possession start location (requires field position tracking)
2. Implement context-aware zone pre-selection
3. Auto-dismiss dialog after 3s with default

### Phase 3: Analytics
1. Add zone breakdown to game summary
2. Calculate efficiency percentages
3. Compare team vs opponent
4. Add insights/recommendations

### Phase 4: Advanced Analytics
1. Tournament-level aggregation
2. Wind/weather correlation
3. O-line vs D-line comparison
4. Player-specific zone tendencies

## Alternative: Special Goal Types

**If Red Zone tracking proves too complex**, consider tracking these instead:

### Highlight-Reel Moments
- **Callahan Goal** - Interception in opponent's end zone (instant goal)
- **Layout Goal** - Diving catch in end zone
- **Bookends** - Same player gets assist and receives goal on next point

**Why these are valuable:**
- Easy to track (binary yes/no)
- Memorable for players ("You had 2 layout goals this tournament!")
- No need for zone estimation
- More engaging than zone data
- Great for video highlight reels

**Implementation:**
```dart
// Simple checkboxes after goal
☐ Layout catch
☐ Callahan (defensive score)
```

## Decision Point

**Before implementing, consider:**

1. **User value** - Will users actually use this feature?
2. **Input friction** - Does it slow down tracking too much?
3. **Data quality** - Will estimates be accurate enough to be meaningful?
4. **Complexity** - Is juice worth the squeeze?

**Recommendation from Guru:**
- Simple Mode: No zone tracking
- Advanced Mode: Red Zone tracking with smart defaults
- OR: Track special goals (Callahan, Layout) instead

## References

- Ultimate Frisbee Guru consultation (Agent ID: a959941)
- Discussion: Goal zone tracking value assessment
- Date: 2026-01-03
- Conclusion: Red zone tracking is the ONLY location stat that meaningfully helps understand offensive strategy
