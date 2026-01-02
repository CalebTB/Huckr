import React, { useState } from 'react';

export default function GoldenHourTeamsScreen() {
  const [isDark, setIsDark] = useState(true);
  const [activeTeam, setActiveTeam] = useState(0);
  const [activeTab, setActiveTab] = useState('roster');
  const [drawerOpen, setDrawerOpen] = useState(false);
  
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
    coach: '#FBBF24',
    captain: '#F59E0B',
    player: '#C4A878',
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
    coach: '#D97706',
    captain: '#B45309',
    player: '#8A7550',
  };

  const roleConfig = {
    coach: { color: t.coach, icon: '📋', label: 'Coach', priority: 1 },
    captain: { color: t.captain, icon: '⭐', label: 'Captain', priority: 2 },
    player: { color: t.player, icon: '👤', label: 'Player', priority: 3 },
  };

  const teams = [
    {
      id: 1,
      name: 'Ring of Fire',
      abbrev: 'ROF',
      color: '#F59E0B',
      division: "Men's Club",
      season: '2024',
      role: 'captain',
      record: { wins: 8, losses: 4 },
      roster: [
        { number: '7', name: 'Smith', position: 'Cutter', captain: true },
        { number: '23', name: 'Johnson', position: 'Cutter', captain: false },
        { number: '11', name: 'Williams', position: 'Handler', captain: true },
        { number: '5', name: 'Davis', position: 'Handler', captain: false },
        { number: '8', name: 'Miller', position: 'Cutter', captain: false },
        { number: '15', name: 'Wilson', position: 'Hybrid', captain: false },
        { number: '3', name: 'Moore', position: 'Cutter', captain: false },
      ],
      recentGames: [
        { opponent: 'Truck Stop', result: 'W', score: '15-11', date: 'Dec 27' },
        { opponent: 'PoNY', result: 'L', score: '12-15', date: 'Dec 26' },
        { opponent: 'Chain Lightning', result: 'W', score: '15-13', date: 'Dec 20' },
      ],
      seasonStats: { pointsFor: 156, pointsAgainst: 132, breaks: 24, holds: 48 }
    },
    {
      id: 2,
      name: 'Durham Haze',
      abbrev: 'DHZ',
      color: '#FBBF24',
      division: 'Mixed Club',
      season: '2024',
      role: 'player',
      record: { wins: 5, losses: 2 },
      roster: [
        { number: '1', name: 'Chen', position: 'Handler', captain: true },
        { number: '22', name: 'Park', position: 'Cutter', captain: false },
        { number: '9', name: 'Kim', position: 'Handler', captain: true },
        { number: '17', name: 'Martinez', position: 'Cutter', captain: false },
      ],
      recentGames: [
        { opponent: 'Toro', result: 'W', score: '15-12', date: 'Dec 21' },
        { opponent: 'Mixtape', result: 'W', score: '14-13', date: 'Dec 20' },
      ],
      seasonStats: { pointsFor: 98, pointsAgainst: 87, breaks: 15, holds: 32 }
    },
    {
      id: 3,
      name: 'Triangle Youth',
      abbrev: 'TYU',
      color: '#D97706',
      division: 'U20 Mixed',
      season: '2024',
      role: 'coach',
      record: { wins: 6, losses: 1 },
      roster: [
        { number: '2', name: 'Adams', position: 'Handler', captain: true },
        { number: '14', name: 'Brooks', position: 'Cutter', captain: false },
        { number: '7', name: 'Clark', position: 'Handler', captain: false },
      ],
      recentGames: [
        { opponent: 'Raleigh Rising', result: 'W', score: '13-8', date: 'Dec 22' },
        { opponent: 'Charlotte Jr', result: 'W', score: '15-10', date: 'Dec 21' },
      ],
      seasonStats: { pointsFor: 89, pointsAgainst: 61, breaks: 18, holds: 28 }
    },
  ];

  const sortedTeams = [...teams].sort((a, b) => 
    roleConfig[a.role].priority - roleConfig[b.role].priority
  );

  const currentTeam = teams[activeTeam];
  const currentRole = roleConfig[currentTeam.role];

  const NavIcon = ({ name, active }) => {
    const color = active ? t.accent : t.textTertiary;
    const icons = {
      home: <path d="M3 9L12 2L21 9V20C21 21.1 20.1 22 19 22H5C3.9 22 3 21.1 3 20V9Z" stroke={color} strokeWidth="2" fill="none"/>,
      games: <><circle cx="12" cy="12" r="10" stroke={color} strokeWidth="2" fill="none"/><path d="M12 8V12L15 15" stroke={color} strokeWidth="2" strokeLinecap="round"/></>,
      teams: <><path d="M17 21V19C17 16.79 15.21 15 13 15H5C2.79 15 1 16.79 1 19V21" stroke={color} strokeWidth="2" fill={active ? color : 'none'}/><circle cx="9" cy="7" r="4" stroke={color} strokeWidth="2" fill={active ? color : 'none'}/></>,
      stats: <path d="M18 20V10M12 20V4M6 20V14" stroke={color} strokeWidth="2" strokeLinecap="round"/>,
      profile: <><circle cx="12" cy="8" r="4" stroke={color} strokeWidth="2" fill="none"/><path d="M20 21C20 16.58 16.42 13 12 13C7.58 13 4 16.58 4 21" stroke={color} strokeWidth="2"/></>,
    };
    return <svg width="22" height="22" viewBox="0 0 24 24" fill="none">{icons[name]}</svg>;
  };

  const selectTeam = (index) => {
    setActiveTeam(index);
    setActiveTab('roster');
    setDrawerOpen(false);
  };

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

        {/* Drawer Overlay */}
        {drawerOpen && (
          <div 
            onClick={() => setDrawerOpen(false)}
            style={{
              position: 'absolute', top: 0, left: 0, right: 0, bottom: 0,
              background: 'rgba(0,0,0,0.6)',
              zIndex: 10,
            }}
          />
        )}

        {/* Drawer */}
        <div style={{
          position: 'absolute',
          top: 0, left: 0, bottom: 0,
          width: 280,
          background: t.bg,
          borderRight: `1px solid ${t.cardBorder}`,
          zIndex: 20,
          transform: drawerOpen ? 'translateX(0)' : 'translateX(-100%)',
          transition: 'transform 0.3s ease',
          display: 'flex',
          flexDirection: 'column',
        }}>
          {/* Drawer Header */}
          <div style={{ padding: '60px 20px 20px', borderBottom: `1px solid ${t.cardBorder}` }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <h2 style={{ margin: 0, fontSize: 20, fontWeight: 700, color: t.text }}>My Teams</h2>
              <button 
                onClick={() => setDrawerOpen(false)}
                style={{
                  width: 32, height: 32, borderRadius: 8,
                  background: t.accentMuted, border: 'none',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  cursor: 'pointer',
                }}
              >
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                  <path d="M18 6L6 18M6 6L18 18" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                </svg>
              </button>
            </div>
            <p style={{ margin: '8px 0 0', fontSize: 13, color: t.textSecondary }}>
              {teams.length} teams
            </p>
          </div>

          {/* Team List */}
          <div style={{ flex: 1, overflowY: 'auto', padding: '12px 0' }}>
            {Object.entries(roleConfig).map(([role, config]) => {
              const roleTeams = sortedTeams.filter(team => team.role === role);
              if (roleTeams.length === 0) return null;
              
              return (
                <div key={role} style={{ marginBottom: 16 }}>
                  <div style={{ 
                    display: 'flex', alignItems: 'center', gap: 8,
                    padding: '8px 20px',
                  }}>
                    <span style={{ fontSize: 14 }}>{config.icon}</span>
                    <span style={{ 
                      fontSize: 11, fontWeight: 600, color: config.color,
                      textTransform: 'uppercase', letterSpacing: 1,
                    }}>
                      {config.label === 'Coach' ? 'Coaching' : config.label === 'Captain' ? 'Captain' : 'Playing'}
                    </span>
                  </div>
                  {roleTeams.map((team) => {
                    const originalIndex = teams.findIndex(t => t.id === team.id);
                    return (
                      <div
                        key={team.id}
                        onClick={() => selectTeam(originalIndex)}
                        style={{
                          display: 'flex', alignItems: 'center', gap: 12,
                          padding: '12px 20px',
                          background: activeTeam === originalIndex ? t.accentMuted : 'transparent',
                          cursor: 'pointer',
                          borderLeft: activeTeam === originalIndex ? `3px solid ${t.accent}` : '3px solid transparent',
                        }}
                      >
                        <div style={{
                          width: 40, height: 40, borderRadius: 10,
                          background: `${team.color}20`,
                          border: `2px solid ${team.color}`,
                          display: 'flex', alignItems: 'center', justifyContent: 'center',
                        }}>
                          <span style={{ fontSize: 11, fontWeight: 800, color: team.color }}>
                            {team.abbrev}
                          </span>
                        </div>
                        <div style={{ flex: 1 }}>
                          <p style={{ margin: 0, fontSize: 14, fontWeight: 600, color: t.text }}>
                            {team.name}
                          </p>
                          <p style={{ margin: '2px 0 0', fontSize: 11, color: t.textSecondary }}>
                            {team.division}
                          </p>
                        </div>
                        <span style={{ fontSize: 12, color: t.textSecondary }}>
                          {team.record.wins}-{team.record.losses}
                        </span>
                      </div>
                    );
                  })}
                </div>
              );
            })}
          </div>

          {/* Drawer Footer */}
          <div style={{ padding: '16px 20px', borderTop: `1px solid ${t.cardBorder}` }}>
            <button style={{
              width: '100%', padding: '12px', borderRadius: 10,
              border: `1px solid ${t.cardBorder}`, background: t.card,
              color: t.text, fontSize: 13, fontWeight: 600, cursor: 'pointer',
              display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8,
            }}>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                <path d="M12 5V19M5 12H19" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
              </svg>
              Join or Create Team
            </button>
          </div>
        </div>

        {/* Content */}
        <div style={{ height: 'calc(100% - 127px)', overflowY: 'auto' }}>
          {/* Header */}
          <div style={{ padding: '16px 24px 0' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                <button 
                  onClick={() => setDrawerOpen(true)}
                  style={{ 
                    width: 40, height: 40, borderRadius: 12, border: `1px solid ${t.cardBorder}`,
                    background: t.card, display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer'
                  }}
                >
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                    <path d="M3 6H21M3 12H21M3 18H21" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                  </svg>
                </button>
                <div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                    <h1 style={{ margin: 0, fontSize: 22, fontWeight: 700, color: t.text, letterSpacing: -0.5 }}>
                      {currentTeam.name}
                    </h1>
                  </div>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginTop: 2 }}>
                    <span style={{ fontSize: 12 }}>{currentRole.icon}</span>
                    <span style={{ fontSize: 12, color: currentRole.color, fontWeight: 600 }}>
                      {currentRole.label}
                    </span>
                    <span style={{ fontSize: 12, color: t.textTertiary }}>•</span>
                    <span style={{ fontSize: 12, color: t.textSecondary }}>{currentTeam.division}</span>
                  </div>
                </div>
              </div>
              
              <div style={{
                width: 44, height: 44, borderRadius: 12,
                background: `${currentTeam.color}20`,
                border: `2px solid ${currentTeam.color}`,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                boxShadow: `0 0 20px ${currentTeam.color}40`,
              }}>
                <span style={{ fontSize: 12, fontWeight: 800, color: currentTeam.color }}>
                  {currentTeam.abbrev}
                </span>
              </div>
            </div>
          </div>

          {/* Record & Stats Card */}
          <div style={{
            margin: '0 16px 12px',
            background: t.card,
            border: `1px solid ${t.cardBorder}`,
            borderRadius: 16,
            padding: 16,
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
              <div>
                <p style={{ margin: 0, fontSize: 11, color: t.textSecondary, textTransform: 'uppercase', letterSpacing: 0.5 }}>
                  {currentTeam.season} Season Record
                </p>
                <p style={{ margin: '6px 0 0', fontSize: 32, fontWeight: 700 }}>
                  <span style={{ color: t.success }}>{currentTeam.record.wins}</span>
                  <span style={{ color: t.textTertiary }}> - </span>
                  <span style={{ color: t.error }}>{currentTeam.record.losses}</span>
                </p>
              </div>
              <div style={{ 
                width: 60, height: 60, borderRadius: 30,
                background: t.accentMuted,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <span style={{ fontSize: 16, fontWeight: 700, color: t.accent }}>
                  {Math.round((currentTeam.record.wins / (currentTeam.record.wins + currentTeam.record.losses)) * 100)}%
                </span>
              </div>
            </div>

            <div style={{ 
              display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: 8,
              paddingTop: 16, borderTop: `1px solid ${t.cardBorder}`,
            }}>
              <div style={{ textAlign: 'center' }}>
                <p style={{ margin: 0, fontSize: 18, fontWeight: 700, color: t.accent }}>
                  {currentTeam.seasonStats.pointsFor}
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 10, color: t.textSecondary }}>Pts For</p>
              </div>
              <div style={{ textAlign: 'center' }}>
                <p style={{ margin: 0, fontSize: 18, fontWeight: 700, color: t.text }}>
                  {currentTeam.seasonStats.pointsAgainst}
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 10, color: t.textSecondary }}>Pts Against</p>
              </div>
              <div style={{ textAlign: 'center' }}>
                <p style={{ margin: 0, fontSize: 18, fontWeight: 700, color: t.success }}>
                  {currentTeam.seasonStats.holds}
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 10, color: t.textSecondary }}>Holds</p>
              </div>
              <div style={{ textAlign: 'center' }}>
                <p style={{ margin: 0, fontSize: 18, fontWeight: 700, color: t.blue }}>
                  {currentTeam.seasonStats.breaks}
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 10, color: t.textSecondary }}>Breaks</p>
              </div>
            </div>
          </div>

          {/* Tab Navigation */}
          <div style={{ 
            display: 'flex', margin: '0 16px 12px', 
            background: t.card, borderRadius: 10, padding: 3,
            border: `1px solid ${t.cardBorder}`,
          }}>
            {[
              { key: 'roster', label: 'Roster' },
              { key: 'games', label: 'Games' },
              { key: 'settings', label: 'Settings' },
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
          <div style={{ padding: '0 16px 24px' }}>
            {/* Roster Tab */}
            {activeTab === 'roster' && (
              <div style={{
                background: t.card,
                border: `1px solid ${t.cardBorder}`,
                borderRadius: 14,
                overflow: 'hidden',
              }}>
                <div style={{
                  display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                  padding: '12px 14px',
                  background: t.accentMuted,
                  borderBottom: `1px solid ${t.cardBorder}`,
                }}>
                  <span style={{ fontSize: 11, fontWeight: 600, color: t.textSecondary, textTransform: 'uppercase', letterSpacing: 1 }}>
                    {currentTeam.roster.length} Players
                  </span>
                  {(currentTeam.role === 'captain' || currentTeam.role === 'coach') && (
                    <button style={{
                      padding: '6px 12px', borderRadius: 6,
                      background: t.gradient, border: 'none',
                      color: '#000', fontSize: 11, fontWeight: 600, cursor: 'pointer',
                    }}>
                      + Add Player
                    </button>
                  )}
                </div>

                {currentTeam.roster.map((player, i) => (
                  <div
                    key={i}
                    style={{
                      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                      padding: '12px 14px',
                      borderBottom: i < currentTeam.roster.length - 1 ? `1px solid ${t.cardBorder}` : 'none',
                    }}
                  >
                    <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                      <div style={{
                        width: 40, height: 40, borderRadius: 10,
                        background: t.accentMuted,
                        display: 'flex', alignItems: 'center', justifyContent: 'center',
                      }}>
                        <span style={{ fontSize: 16, fontWeight: 700, color: t.accent }}>
                          {player.number}
                        </span>
                      </div>
                      <div>
                        <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                          <span style={{ fontSize: 14, fontWeight: 600, color: t.text }}>
                            {player.name}
                          </span>
                          {player.captain && (
                            <span style={{ 
                              fontSize: 8, fontWeight: 700, color: '#000',
                              background: t.gradient, padding: '2px 5px', borderRadius: 4,
                            }}>
                              C
                            </span>
                          )}
                        </div>
                        <span style={{ fontSize: 12, color: t.textSecondary }}>{player.position}</span>
                      </div>
                    </div>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                      <path d="M9 18L15 12L9 6" stroke={t.textTertiary} strokeWidth="2" strokeLinecap="round"/>
                    </svg>
                  </div>
                ))}
              </div>
            )}

            {/* Games Tab */}
            {activeTab === 'games' && (
              <div>
                <p style={{ 
                  margin: '0 0 12px', fontSize: 11, fontWeight: 600, color: t.textSecondary,
                  textTransform: 'uppercase', letterSpacing: 1,
                }}>
                  Recent Games
                </p>
                
                {currentTeam.recentGames.map((game, i) => (
                  <div
                    key={i}
                    style={{
                      background: t.card,
                      border: `1px solid ${t.cardBorder}`,
                      borderRadius: 14,
                      padding: 14,
                      marginBottom: 10,
                    }}
                  >
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 }}>
                      <span style={{ fontSize: 11, color: t.textTertiary }}>{game.date}</span>
                      <span style={{ 
                        fontSize: 10, fontWeight: 600, 
                        color: game.result === 'W' ? t.success : t.error,
                        background: game.result === 'W' ? `${t.success}18` : `${t.error}18`,
                        padding: '3px 8px', borderRadius: 5,
                      }}>
                        {game.result}
                      </span>
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                      <div>
                        <p style={{ margin: 0, fontSize: 14, fontWeight: 600, color: t.text }}>
                          vs {game.opponent}
                        </p>
                      </div>
                      <span style={{ 
                        fontSize: 18, fontWeight: 700, color: t.accent,
                        fontVariantNumeric: 'tabular-nums',
                      }}>
                        {game.score}
                      </span>
                    </div>
                  </div>
                ))}

                <button style={{
                  width: '100%', padding: '14px', borderRadius: 12,
                  border: `1px solid ${t.cardBorder}`, background: t.card,
                  color: t.textSecondary, fontSize: 13, fontWeight: 600, cursor: 'pointer',
                  marginTop: 4,
                }}>
                  View All Games
                </button>
              </div>
            )}

            {/* Settings Tab */}
            {activeTab === 'settings' && (
              <div style={{
                background: t.card,
                border: `1px solid ${t.cardBorder}`,
                borderRadius: 14,
                overflow: 'hidden',
              }}>
                {[
                  { icon: '✏️', label: 'Edit Team Info', desc: 'Name, colors, division' },
                  { icon: '📋', label: 'Manage Lines', desc: 'O-Line, D-Line presets' },
                  { icon: '📊', label: 'Export Stats', desc: 'Download season data' },
                  { icon: '🔗', label: 'Share Team', desc: 'Invite players to join' },
                  { icon: '🔔', label: 'Notifications', desc: 'Game reminders' },
                ].map((item, i) => (
                  <div
                    key={i}
                    style={{
                      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                      padding: '14px',
                      borderBottom: `1px solid ${t.cardBorder}`,
                      cursor: 'pointer',
                    }}
                  >
                    <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                      <span style={{ fontSize: 20 }}>{item.icon}</span>
                      <div>
                        <p style={{ margin: 0, fontSize: 14, fontWeight: 500, color: t.text }}>
                          {item.label}
                        </p>
                        <p style={{ margin: '2px 0 0', fontSize: 12, color: t.textSecondary }}>
                          {item.desc}
                        </p>
                      </div>
                    </div>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                      <path d="M9 18L15 12L9 6" stroke={t.textTertiary} strokeWidth="2" strokeLinecap="round"/>
                    </svg>
                  </div>
                ))}

                <div style={{ padding: '14px' }}>
                  <button style={{
                    width: '100%', padding: '12px', borderRadius: 10,
                    border: `1px solid ${t.error}40`, background: `${t.error}10`,
                    color: t.error, fontSize: 13, fontWeight: 600, cursor: 'pointer',
                  }}>
                    Leave Team
                  </button>
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Bottom Nav */}
        <div style={{ 
          position: 'absolute', bottom: 0, left: 0, right: 0, height: 83, 
          background: t.bg, borderTop: `1px solid ${t.cardBorder}`, 
          display: 'flex', justifyContent: 'space-around', alignItems: 'flex-start', paddingTop: 10 
        }}>
          {['home', 'games', 'teams', 'stats', 'profile'].map((n) => (
            <div key={n} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 3, cursor: 'pointer' }}>
              <NavIcon name={n} active={n === 'teams'} />
              <span style={{ fontSize: 10, fontWeight: n === 'teams' ? 600 : 500, color: n === 'teams' ? t.accent : t.textTertiary, textTransform: 'capitalize' }}>{n}</span>
            </div>
          ))}
        </div>
        <div style={{ position: 'absolute', bottom: 8, left: '50%', transform: 'translateX(-50%)', width: 134, height: 5, background: t.accent, borderRadius: 3, opacity: 0.3 }} />
      </div>
      
      <p style={{ textAlign: 'center', marginTop: 24, fontSize: 13, color: '#C4A878' }}>
        <strong style={{ color: '#F59E0B' }}>Golden Hour Teams Screen</strong> · Warm sunset aesthetic
      </p>
    </div>
  );
}
