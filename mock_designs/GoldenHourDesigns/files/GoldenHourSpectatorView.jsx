import React, { useState } from 'react';

export default function GoldenHourSpectatorView() {
  const [isDark, setIsDark] = useState(true);
  const [activeTab, setActiveTab] = useState('leaders');
  
  const t = isDark ? {
    bg: '#0C0A05',
    surface: '#141008',
    card: '#1E1810',
    cardBorder: '#382C1A',
    text: '#FFFFFF',
    textSecondary: '#C4A878',
    textTertiary: '#8A7550',
    accent: '#F59E0B',
    accentLight: '#FBBF24',
    accentMuted: 'rgba(245,158,11,0.15)',
    gradient: 'linear-gradient(135deg, #FBBF24, #F59E0B)',
    success: '#22C55E',
    error: '#EF4444',
    blue: '#60A5FA',
    purple: '#A855F7',
    gold: '#FBBF24',
    silver: '#94A3B8',
    bronze: '#CD7F32',
  } : {
    bg: '#FFFDF5',
    surface: '#FFF9E8',
    card: '#FFFFFF',
    cardBorder: '#FFE8B8',
    text: '#1E1810',
    textSecondary: '#8A7550',
    textTertiary: '#C4A878',
    accent: '#D97706',
    accentLight: '#F59E0B',
    accentMuted: 'rgba(217,119,6,0.1)',
    gradient: 'linear-gradient(135deg, #FBBF24, #F59E0B)',
    success: '#22C55E',
    error: '#EF4444',
    blue: '#3B82F6',
    purple: '#9333EA',
    gold: '#D97706',
    silver: '#64748B',
    bronze: '#92400E',
  };

  const gameData = {
    home: { name: 'Ring of Fire', abbrev: 'ROF', score: 11, color: '#F59E0B' },
    away: { name: 'Sockeye', abbrev: 'SOC', score: 9, color: '#60A5FA' },
    timeLeft: '18:42',
    half: '2nd Half',
    gameType: 'Pool Play',
    tournament: 'Club Nationals',
    possession: 'home',
  };

  const efficiency = {
    home: { oLineHold: 82, dLineBreak: 25 },
    away: { oLineHold: 75, dLineBreak: 18 },
  };

  const comparison = {
    turnovers: { home: 4, away: 7 },
    blocks: { home: 6, away: 4 },
    completions: { home: 98, away: 88 },
  };

  const statLeaders = {
    goals: [
      { team: 'home', number: '7', name: 'Smith', value: 4 },
      { team: 'away', number: '21', name: 'Chen', value: 3 },
      { team: 'home', number: '23', name: 'Johnson', value: 2 },
    ],
    assists: [
      { team: 'home', number: '11', name: 'Williams', value: 5 },
      { team: 'home', number: '5', name: 'Davis', value: 3 },
      { team: 'away', number: '8', name: 'Park', value: 3 },
    ],
    blocks: [
      { team: 'away', number: '15', name: 'Martinez', value: 3 },
      { team: 'home', number: '8', name: 'Miller', value: 2 },
      { team: 'home', number: '3', name: 'Moore', value: 2 },
    ],
    completions: [
      { team: 'home', number: '11', name: 'Williams', value: 28 },
      { team: 'away', number: '4', name: 'Kim', value: 24 },
      { team: 'home', number: '5', name: 'Davis', value: 21 },
    ],
  };

  const teamStats = {
    home: [
      { number: '7', name: 'Smith', goals: 4, assists: 1, blocks: 1, turns: 0, comp: 12, pts: 8 },
      { number: '23', name: 'Johnson', goals: 2, assists: 2, blocks: 0, turns: 1, comp: 8, pts: 7 },
      { number: '11', name: 'Williams', goals: 1, assists: 5, blocks: 0, turns: 0, comp: 28, pts: 9 },
      { number: '5', name: 'Davis', goals: 1, assists: 3, blocks: 1, turns: 1, comp: 21, pts: 8 },
      { number: '8', name: 'Miller', goals: 2, assists: 0, blocks: 2, turns: 0, comp: 6, pts: 6 },
    ],
    away: [
      { number: '21', name: 'Chen', goals: 3, assists: 1, blocks: 0, turns: 1, comp: 15, pts: 7 },
      { number: '8', name: 'Park', goals: 2, assists: 3, blocks: 1, turns: 0, comp: 18, pts: 8 },
      { number: '4', name: 'Kim', goals: 1, assists: 2, blocks: 0, turns: 1, comp: 24, pts: 8 },
      { number: '15', name: 'Martinez', goals: 1, assists: 1, blocks: 3, turns: 0, comp: 8, pts: 6 },
      { number: '33', name: 'Lee', goals: 1, assists: 1, blocks: 1, turns: 1, comp: 11, pts: 7 },
    ],
  };

  const recentPlays = [
    { time: '18:42', text: 'ROF scores! #7 Smith goal, assist #11 Williams', type: 'goal', team: 'home' },
    { time: '19:15', text: 'Timeout - Sockeye', type: 'timeout', team: 'away' },
    { time: '20:03', text: 'Block by #8 Miller', type: 'block', team: 'home' },
    { time: '20:28', text: 'Throwaway #12 Garcia', type: 'turnover', team: 'away' },
    { time: '21:45', text: 'SOC scores! #21 Chen goal, assist #8 Park', type: 'goal', team: 'away' },
  ];

  const getMedalColor = (index) => {
    if (index === 0) return t.gold;
    if (index === 1) return t.silver;
    if (index === 2) return t.bronze;
    return t.textTertiary;
  };

  const ComparisonBar = ({ label, homeVal, awayVal, lowerIsBetter = false }) => {
    const total = homeVal + awayVal;
    const homePercent = total > 0 ? (homeVal / total) * 100 : 50;
    const homeWinning = lowerIsBetter ? homeVal < awayVal : homeVal > awayVal;
    const awayWinning = lowerIsBetter ? awayVal < homeVal : awayVal > homeVal;
    
    return (
      <div style={{ marginBottom: 10 }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 4 }}>
          <span style={{ fontSize: 14, fontWeight: 700, color: homeWinning ? t.accent : t.textSecondary, fontVariantNumeric: 'tabular-nums' }}>
            {homeVal}
          </span>
          <span style={{ fontSize: 11, color: t.textSecondary, fontWeight: 500 }}>{label}</span>
          <span style={{ fontSize: 14, fontWeight: 700, color: awayWinning ? t.text : t.textSecondary, fontVariantNumeric: 'tabular-nums' }}>
            {awayVal}
          </span>
        </div>
        <div style={{ display: 'flex', height: 6, borderRadius: 3, overflow: 'hidden', gap: 2 }}>
          <div style={{ 
            width: `${homePercent}%`, 
            background: homeWinning ? gameData.home.color : `${gameData.home.color}50`,
            borderRadius: 3,
          }} />
          <div style={{ 
            width: `${100 - homePercent}%`, 
            background: awayWinning ? gameData.away.color : `${gameData.away.color}50`,
            borderRadius: 3,
          }} />
        </div>
      </div>
    );
  };

  const StatLeaderCard = ({ category, leaders, icon }) => (
    <div style={{
      background: t.card,
      border: `1px solid ${t.cardBorder}`,
      borderRadius: 14,
      padding: 14,
      marginBottom: 10,
    }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 8, marginBottom: 12 }}>
        <span style={{ fontSize: 16 }}>{icon}</span>
        <span style={{ fontSize: 12, fontWeight: 700, color: t.accent, textTransform: 'uppercase', letterSpacing: 1 }}>
          {category}
        </span>
      </div>
      {leaders.map((player, i) => (
        <div 
          key={i}
          style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            padding: '8px 0',
            borderTop: i > 0 ? `1px solid ${t.cardBorder}` : 'none',
          }}
        >
          <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
            <span style={{
              width: 20, height: 20, borderRadius: '50%',
              background: getMedalColor(i),
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 10, fontWeight: 700, color: i < 3 ? '#000' : t.text,
            }}>
              {i + 1}
            </span>
            <div style={{
              width: 6, height: 6, borderRadius: '50%',
              background: player.team === 'home' ? gameData.home.color : gameData.away.color,
            }} />
            <span style={{ fontSize: 13, fontWeight: 600, color: t.text }}>
              #{player.number}
            </span>
            <span style={{ fontSize: 12, color: t.textSecondary }}>
              {player.name}
            </span>
          </div>
          <span style={{ fontSize: 18, fontWeight: 700, color: t.accent }}>
            {player.value}
          </span>
        </div>
      ))}
    </div>
  );

  return (
    <div style={{ minHeight: '100vh', background: isDark ? '#0A0A0A' : '#F5F5F0', padding: 20, fontFamily: 'system-ui, -apple-system, sans-serif' }}>
      {/* Toggle */}
      <div style={{ display: 'flex', justifyContent: 'center', gap: 8, marginBottom: 24 }}>
        {['Dark', 'Light'].map(mode => (
          <button key={mode} onClick={() => setIsDark(mode === 'Dark')}
            style={{ padding: '10px 24px', borderRadius: 100, border: 'none', cursor: 'pointer',
              background: (mode === 'Dark' ? isDark : !isDark) ? t.gradient : 'transparent',
              color: (mode === 'Dark' ? isDark : !isDark) ? '#000' : '#737373',
              fontWeight: 600, fontSize: 14,
              boxShadow: (mode === 'Dark' ? isDark : !isDark) ? '0 4px 20px rgba(245,158,11,0.4)' : 'none',
            }}>
            {mode}
          </button>
        ))}
      </div>

      {/* Phone */}
      <div style={{ width: 375, height: 812, margin: '0 auto', background: t.bg, borderRadius: 44, 
        border: `1px solid ${t.cardBorder}`, overflow: 'hidden', position: 'relative',
        boxShadow: isDark ? '0 25px 50px -12px rgba(0,0,0,0.8), 0 0 40px rgba(245,158,11,0.15)' : '0 25px 50px -12px rgba(0,0,0,0.15)' }}>
        
        {/* Status Bar */}
        <div style={{ height: 44, display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '0 28px' }}>
          <span style={{ color: t.accent, fontSize: 14, fontWeight: 600 }}>9:41</span>
          <div style={{ display: 'flex', gap: 6 }}>
            <svg width="18" height="12" fill={t.accent}><rect x="0" y="3" width="4" height="9" rx="1"/><rect x="5" y="1.5" width="4" height="10.5" rx="1"/><rect x="10" y="0" width="4" height="12" rx="1"/></svg>
            <svg width="25" height="12" fill={t.accent}><rect x="0" y="0" width="22" height="12" rx="3" fill="none" stroke={t.accent}/><rect x="2" y="2" width="17" height="8" rx="1.5"/></svg>
          </div>
        </div>

        {/* Content */}
        <div style={{ height: 'calc(100% - 44px)', overflowY: 'auto' }}>
          {/* Header */}
          <div style={{ padding: '8px 20px 0' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 8 }}>
              <span style={{ fontSize: 11, color: t.textSecondary, textTransform: 'uppercase', letterSpacing: 0.5 }}>
                {gameData.tournament} · {gameData.gameType}
              </span>
              <div style={{ display: 'flex', alignItems: 'center', gap: 4 }}>
                <span style={{ width: 6, height: 6, borderRadius: '50%', background: t.error, animation: 'pulse 1.5s infinite' }} />
                <span style={{ fontSize: 10, fontWeight: 600, color: t.error }}>LIVE</span>
              </div>
            </div>
          </div>

          {/* Scoreboard */}
          <div style={{
            margin: '0 16px 12px',
            background: t.card,
            border: `1px solid ${t.cardBorder}`,
            borderRadius: 16,
            padding: 16,
          }}>
            {/* Teams and Score */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              {/* Home Team */}
              <div style={{ flex: 1, textAlign: 'center' }}>
                <div style={{
                  width: 48, height: 48, borderRadius: 12,
                  background: `${gameData.home.color}20`,
                  border: `2px solid ${gameData.home.color}`,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  margin: '0 auto 8px',
                  boxShadow: `0 0 20px ${gameData.home.color}40`,
                }}>
                  <span style={{ fontSize: 14, fontWeight: 800, color: gameData.home.color }}>
                    {gameData.home.abbrev}
                  </span>
                </div>
                <p style={{ margin: 0, fontSize: 11, fontWeight: 600, color: t.text }}>{gameData.home.name}</p>
                {gameData.possession === 'home' && (
                  <span style={{ fontSize: 9, color: t.success, fontWeight: 600 }}>● POSSESSION</span>
                )}
              </div>

              {/* Score */}
              <div style={{ padding: '0 16px', textAlign: 'center' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                  <span style={{ 
                    fontSize: 44, fontWeight: 800, color: t.accent,
                    fontVariantNumeric: 'tabular-nums',
                    textShadow: `0 0 30px ${t.accent}60`,
                  }}>
                    {gameData.home.score}
                  </span>
                  <span style={{ fontSize: 24, color: t.textTertiary }}>-</span>
                  <span style={{ 
                    fontSize: 44, fontWeight: 800, color: t.text,
                    fontVariantNumeric: 'tabular-nums',
                  }}>
                    {gameData.away.score}
                  </span>
                </div>
              </div>

              {/* Away Team */}
              <div style={{ flex: 1, textAlign: 'center' }}>
                <div style={{
                  width: 48, height: 48, borderRadius: 12,
                  background: `${gameData.away.color}20`,
                  border: `2px solid ${gameData.away.color}`,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  margin: '0 auto 8px',
                }}>
                  <span style={{ fontSize: 14, fontWeight: 800, color: gameData.away.color }}>
                    {gameData.away.abbrev}
                  </span>
                </div>
                <p style={{ margin: 0, fontSize: 11, fontWeight: 600, color: t.text }}>{gameData.away.name}</p>
                {gameData.possession === 'away' && (
                  <span style={{ fontSize: 9, color: t.success, fontWeight: 600 }}>● POSSESSION</span>
                )}
              </div>
            </div>

            {/* Game Info */}
            <div style={{
              display: 'flex', justifyContent: 'center', alignItems: 'center', gap: 16,
              marginTop: 14, paddingTop: 14, borderTop: `1px solid ${t.cardBorder}`,
            }}>
              <div style={{ textAlign: 'center' }}>
                <p style={{ margin: 0, fontSize: 20, fontWeight: 700, color: t.accent, fontVariantNumeric: 'tabular-nums' }}>
                  {gameData.timeLeft}
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 10, color: t.textSecondary }}>Time Left</p>
              </div>
              <div style={{ width: 1, height: 32, background: t.cardBorder }} />
              <div style={{ textAlign: 'center' }}>
                <p style={{ margin: 0, fontSize: 20, fontWeight: 700, color: t.text }}>
                  {gameData.half}
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 10, color: t.textSecondary }}>Period</p>
              </div>
            </div>

            {/* Efficiency Stats */}
            <div style={{ marginTop: 14, paddingTop: 14, borderTop: `1px solid ${t.cardBorder}` }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 10 }}>
                <span style={{ fontSize: 10, color: t.textSecondary, textTransform: 'uppercase', letterSpacing: 0.5 }}>
                  Efficiency
                </span>
                <div style={{ display: 'flex', gap: 12 }}>
                  <span style={{ fontSize: 10, fontWeight: 600, color: gameData.home.color }}>{gameData.home.abbrev}</span>
                  <span style={{ fontSize: 10, fontWeight: 600, color: gameData.away.color }}>{gameData.away.abbrev}</span>
                </div>
              </div>
              
              <div style={{ 
                display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                padding: '8px 0',
              }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                  <span style={{ fontSize: 12, color: t.textSecondary }}>O-Line</span>
                  <span style={{ fontSize: 9, color: t.textTertiary }}>(hold %)</span>
                </div>
                <div style={{ display: 'flex', gap: 12 }}>
                  <span style={{ 
                    fontSize: 16, fontWeight: 700, 
                    color: efficiency.home.oLineHold >= efficiency.away.oLineHold ? t.success : t.textSecondary,
                    fontVariantNumeric: 'tabular-nums',
                    minWidth: 44, textAlign: 'right',
                  }}>
                    {efficiency.home.oLineHold}%
                  </span>
                  <span style={{ 
                    fontSize: 16, fontWeight: 700, 
                    color: efficiency.away.oLineHold >= efficiency.home.oLineHold ? t.success : t.textSecondary,
                    fontVariantNumeric: 'tabular-nums',
                    minWidth: 44, textAlign: 'right',
                  }}>
                    {efficiency.away.oLineHold}%
                  </span>
                </div>
              </div>
              
              <div style={{ 
                display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                padding: '8px 0',
                borderTop: `1px solid ${t.cardBorder}`,
              }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                  <span style={{ fontSize: 12, color: t.textSecondary }}>D-Line</span>
                  <span style={{ fontSize: 9, color: t.textTertiary }}>(break %)</span>
                </div>
                <div style={{ display: 'flex', gap: 12 }}>
                  <span style={{ 
                    fontSize: 16, fontWeight: 700, 
                    color: efficiency.home.dLineBreak >= efficiency.away.dLineBreak ? t.blue : t.textSecondary,
                    fontVariantNumeric: 'tabular-nums',
                    minWidth: 44, textAlign: 'right',
                  }}>
                    {efficiency.home.dLineBreak}%
                  </span>
                  <span style={{ 
                    fontSize: 16, fontWeight: 700, 
                    color: efficiency.away.dLineBreak >= efficiency.home.dLineBreak ? t.blue : t.textSecondary,
                    fontVariantNumeric: 'tabular-nums',
                    minWidth: 44, textAlign: 'right',
                  }}>
                    {efficiency.away.dLineBreak}%
                  </span>
                </div>
              </div>
            </div>

            {/* Comparison Bars */}
            <div style={{ marginTop: 14, paddingTop: 14, borderTop: `1px solid ${t.cardBorder}` }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
                <span style={{ fontSize: 10, color: t.textSecondary, textTransform: 'uppercase', letterSpacing: 0.5 }}>
                  Comparison
                </span>
                <div style={{ display: 'flex', gap: 8 }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 4 }}>
                    <div style={{ width: 8, height: 8, borderRadius: 2, background: gameData.home.color }} />
                    <span style={{ fontSize: 9, color: t.textSecondary }}>{gameData.home.abbrev}</span>
                  </div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 4 }}>
                    <div style={{ width: 8, height: 8, borderRadius: 2, background: gameData.away.color }} />
                    <span style={{ fontSize: 9, color: t.textSecondary }}>{gameData.away.abbrev}</span>
                  </div>
                </div>
              </div>
              
              <ComparisonBar label="Turnovers" homeVal={comparison.turnovers.home} awayVal={comparison.turnovers.away} lowerIsBetter={true} />
              <ComparisonBar label="Blocks" homeVal={comparison.blocks.home} awayVal={comparison.blocks.away} />
              <ComparisonBar label="Completions" homeVal={comparison.completions.home} awayVal={comparison.completions.away} />
            </div>
          </div>

          {/* Tab Navigation */}
          <div style={{ 
            display: 'flex', margin: '0 16px 12px', 
            background: t.card, borderRadius: 10, padding: 3,
            border: `1px solid ${t.cardBorder}`,
          }}>
            {[
              { key: 'leaders', label: 'Leaders' },
              { key: 'home', label: gameData.home.abbrev },
              { key: 'away', label: gameData.away.abbrev },
              { key: 'plays', label: 'Plays' },
            ].map(tab => (
              <button
                key={tab.key}
                onClick={() => setActiveTab(tab.key)}
                style={{
                  flex: 1, padding: '10px 8px', borderRadius: 8, border: 'none',
                  background: activeTab === tab.key ? t.gradient : 'transparent',
                  color: activeTab === tab.key ? '#000' : t.textSecondary,
                  fontWeight: 600, fontSize: 12, cursor: 'pointer',
                }}
              >
                {tab.label}
              </button>
            ))}
          </div>

          {/* Tab Content */}
          <div style={{ padding: '0 16px 100px' }}>
            {/* Leaders Tab */}
            {activeTab === 'leaders' && (
              <>
                <StatLeaderCard category="Goals" leaders={statLeaders.goals} icon="🥅" />
                <StatLeaderCard category="Assists" leaders={statLeaders.assists} icon="🎯" />
                <StatLeaderCard category="Blocks" leaders={statLeaders.blocks} icon="🛡️" />
                <StatLeaderCard category="Completions" leaders={statLeaders.completions} icon="💨" />
              </>
            )}

            {/* Team Stats Tabs */}
            {(activeTab === 'home' || activeTab === 'away') && (
              <div style={{
                background: t.card,
                border: `1px solid ${t.cardBorder}`,
                borderRadius: 14,
                overflow: 'hidden',
              }}>
                <div style={{
                  display: 'grid',
                  gridTemplateColumns: '60px 1fr repeat(6, 36px)',
                  padding: '12px 10px',
                  background: t.accentMuted,
                  borderBottom: `1px solid ${t.cardBorder}`,
                }}>
                  <span style={{ fontSize: 9, fontWeight: 600, color: t.textSecondary }}>#</span>
                  <span style={{ fontSize: 9, fontWeight: 600, color: t.textSecondary }}>PLAYER</span>
                  <span style={{ fontSize: 9, fontWeight: 600, color: t.textSecondary, textAlign: 'center' }}>G</span>
                  <span style={{ fontSize: 9, fontWeight: 600, color: t.textSecondary, textAlign: 'center' }}>A</span>
                  <span style={{ fontSize: 9, fontWeight: 600, color: t.textSecondary, textAlign: 'center' }}>D</span>
                  <span style={{ fontSize: 9, fontWeight: 600, color: t.textSecondary, textAlign: 'center' }}>T</span>
                  <span style={{ fontSize: 9, fontWeight: 600, color: t.textSecondary, textAlign: 'center' }}>C</span>
                  <span style={{ fontSize: 9, fontWeight: 600, color: t.textSecondary, textAlign: 'center' }}>PT</span>
                </div>

                {teamStats[activeTab].map((player, i) => (
                  <div
                    key={i}
                    style={{
                      display: 'grid',
                      gridTemplateColumns: '60px 1fr repeat(6, 36px)',
                      padding: '10px',
                      borderBottom: i < teamStats[activeTab].length - 1 ? `1px solid ${t.cardBorder}` : 'none',
                      alignItems: 'center',
                    }}
                  >
                    <span style={{ fontSize: 14, fontWeight: 700, color: t.accent }}>#{player.number}</span>
                    <span style={{ fontSize: 12, color: t.textSecondary }}>{player.name}</span>
                    <span style={{ fontSize: 13, fontWeight: 600, color: player.goals > 0 ? t.success : t.textTertiary, textAlign: 'center' }}>
                      {player.goals}
                    </span>
                    <span style={{ fontSize: 13, fontWeight: 600, color: player.assists > 0 ? t.blue : t.textTertiary, textAlign: 'center' }}>
                      {player.assists}
                    </span>
                    <span style={{ fontSize: 13, fontWeight: 600, color: player.blocks > 0 ? t.purple : t.textTertiary, textAlign: 'center' }}>
                      {player.blocks}
                    </span>
                    <span style={{ fontSize: 13, fontWeight: 600, color: player.turns > 0 ? t.error : t.textTertiary, textAlign: 'center' }}>
                      {player.turns}
                    </span>
                    <span style={{ fontSize: 13, fontWeight: 500, color: t.textSecondary, textAlign: 'center' }}>
                      {player.comp}
                    </span>
                    <span style={{ fontSize: 13, fontWeight: 500, color: t.textSecondary, textAlign: 'center' }}>
                      {player.pts}
                    </span>
                  </div>
                ))}

                <div style={{
                  display: 'grid',
                  gridTemplateColumns: '60px 1fr repeat(6, 36px)',
                  padding: '12px 10px',
                  background: t.accentMuted,
                  borderTop: `1px solid ${t.cardBorder}`,
                }}>
                  <span style={{ fontSize: 11, fontWeight: 700, color: t.accent }}>TOTAL</span>
                  <span></span>
                  <span style={{ fontSize: 13, fontWeight: 700, color: t.text, textAlign: 'center' }}>
                    {teamStats[activeTab].reduce((sum, p) => sum + p.goals, 0)}
                  </span>
                  <span style={{ fontSize: 13, fontWeight: 700, color: t.text, textAlign: 'center' }}>
                    {teamStats[activeTab].reduce((sum, p) => sum + p.assists, 0)}
                  </span>
                  <span style={{ fontSize: 13, fontWeight: 700, color: t.text, textAlign: 'center' }}>
                    {teamStats[activeTab].reduce((sum, p) => sum + p.blocks, 0)}
                  </span>
                  <span style={{ fontSize: 13, fontWeight: 700, color: t.text, textAlign: 'center' }}>
                    {teamStats[activeTab].reduce((sum, p) => sum + p.turns, 0)}
                  </span>
                  <span style={{ fontSize: 13, fontWeight: 700, color: t.text, textAlign: 'center' }}>
                    {teamStats[activeTab].reduce((sum, p) => sum + p.comp, 0)}
                  </span>
                  <span></span>
                </div>
              </div>
            )}

            {/* Recent Plays Tab */}
            {activeTab === 'plays' && (
              <div style={{
                background: t.card,
                border: `1px solid ${t.cardBorder}`,
                borderRadius: 14,
                overflow: 'hidden',
              }}>
                {recentPlays.map((play, i) => (
                  <div
                    key={i}
                    style={{
                      padding: '12px 14px',
                      borderBottom: i < recentPlays.length - 1 ? `1px solid ${t.cardBorder}` : 'none',
                      display: 'flex',
                      alignItems: 'flex-start',
                      gap: 12,
                    }}
                  >
                    <div style={{
                      width: 8, height: 8, borderRadius: '50%', marginTop: 4,
                      background: play.team === 'home' ? gameData.home.color : gameData.away.color,
                    }} />
                    <div style={{ flex: 1 }}>
                      <p style={{
                        margin: 0, fontSize: 13,
                        color: play.type === 'goal' ? t.success : play.type === 'turnover' ? t.error : play.type === 'block' ? t.blue : t.text,
                        fontWeight: play.type === 'goal' ? 600 : 400,
                      }}>
                        {play.text}
                      </p>
                      <p style={{ margin: '4px 0 0', fontSize: 10, color: t.textTertiary }}>
                        {play.time} remaining
                      </p>
                    </div>
                  </div>
                ))}
                
                <div style={{ padding: '12px', textAlign: 'center' }}>
                  <button style={{
                    padding: '10px 20px', borderRadius: 8,
                    background: t.accentMuted, border: 'none',
                    color: t.accent, fontSize: 12, fontWeight: 600, cursor: 'pointer',
                  }}>
                    Load More
                  </button>
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Floating Share Button */}
        <div style={{
          position: 'absolute', bottom: 28, right: 20,
        }}>
          <button style={{
            width: 50, height: 50, borderRadius: '50%',
            background: t.gradient, border: 'none',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            cursor: 'pointer',
            boxShadow: '0 4px 20px rgba(245,158,11,0.5)',
          }}>
            <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
              <path d="M18 8C19.6569 8 21 6.65685 21 5C21 3.34315 19.6569 2 18 2C16.3431 2 15 3.34315 15 5C15 5.12 15.01 5.24 15.03 5.35L7.09 9.31C6.58 8.56 5.74 8 4.75 8C3.23 8 2 9.23 2 10.75C2 12.27 3.23 13.5 4.75 13.5C5.74 13.5 6.58 12.94 7.09 12.19L15.03 16.15C15.01 16.26 15 16.38 15 16.5C15 18.16 16.34 19.5 18 19.5C19.66 19.5 21 18.16 21 16.5C21 14.84 19.66 13.5 18 13.5C17.01 13.5 16.17 14.06 15.66 14.81L7.72 10.85C7.74 10.74 7.75 10.62 7.75 10.5C7.75 10.38 7.74 10.26 7.72 10.15L15.66 6.19C16.17 6.94 17.01 7.5 18 7.5" stroke="#000" strokeWidth="2" strokeLinecap="round"/>
            </svg>
          </button>
        </div>
      </div>
      
      <p style={{ textAlign: 'center', marginTop: 24, fontSize: 13, color: '#C4A878' }}>
        <strong style={{ color: '#F59E0B' }}>Golden Hour Spectator View</strong> · Warm sunset aesthetic
      </p>

      <style>{`
        @keyframes pulse {
          0%, 100% { opacity: 1; }
          50% { opacity: 0.4; }
        }
      `}</style>
    </div>
  );
}
