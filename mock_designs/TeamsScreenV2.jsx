import React, { useState } from 'react';

export default function TeamsScreen() {
  const [isDark, setIsDark] = useState(true);
  const [activeTeam, setActiveTeam] = useState(0);
  const [activeTab, setActiveTab] = useState('roster');
  const [drawerOpen, setDrawerOpen] = useState(false);
  
  const t = isDark ? {
    bg: '#000000',
    card: '#111111',
    border: '#1F1F1F',
    text: '#FFFFFF',
    muted: '#737373',
    dim: '#525252',
    accent: '#FFFFFF',
    accentBg: 'rgba(255,255,255,0.08)',
    win: '#22C55E',
    lose: '#EF4444',
    orange: '#F97316',
    blue: '#3B82F6',
    purple: '#A855F7',
    yellow: '#EAB308',
    coach: '#F59E0B',
    captain: '#3B82F6',
    player: '#737373',
  } : {
    bg: '#FFFFFF',
    card: '#FFFFFF',
    border: '#E5E5E5',
    text: '#000000',
    muted: '#737373',
    dim: '#A3A3A3',
    accent: '#000000',
    accentBg: 'rgba(0,0,0,0.04)',
    win: '#22C55E',
    lose: '#EF4444',
    orange: '#F97316',
    blue: '#3B82F6',
    purple: '#A855F7',
    yellow: '#EAB308',
    coach: '#F59E0B',
    captain: '#3B82F6',
    player: '#737373',
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
      color: '#EF4444',
      division: 'Men\'s Club',
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
        { number: '21', name: 'Taylor', position: 'Handler', captain: false },
        { number: '10', name: 'Anderson', position: 'Cutter', captain: false },
        { number: '44', name: 'Thomas', position: 'Hybrid', captain: false },
      ],
      recentGames: [
        { opponent: 'Truck Stop', result: 'W', score: '15-11', date: 'Dec 27' },
        { opponent: 'PoNY', result: 'L', score: '12-15', date: 'Dec 26' },
        { opponent: 'Chain Lightning', result: 'W', score: '15-13', date: 'Dec 20' },
      ],
      seasonStats: {
        pointsFor: 156,
        pointsAgainst: 132,
        breaks: 24,
        holds: 48,
      }
    },
    {
      id: 2,
      name: 'Durham Haze',
      abbrev: 'DHZ',
      color: '#8B5CF6',
      division: 'Mixed Club',
      season: '2024',
      role: 'player',
      record: { wins: 5, losses: 2 },
      roster: [
        { number: '1', name: 'Chen', position: 'Handler', captain: true },
        { number: '22', name: 'Park', position: 'Cutter', captain: false },
        { number: '9', name: 'Kim', position: 'Handler', captain: true },
        { number: '17', name: 'Martinez', position: 'Cutter', captain: false },
        { number: '33', name: 'Lee', position: 'Hybrid', captain: false },
        { number: '12', name: 'Garcia', position: 'Cutter', captain: false },
      ],
      recentGames: [
        { opponent: 'Toro', result: 'W', score: '15-12', date: 'Dec 21' },
        { opponent: 'Mixtape', result: 'W', score: '14-13', date: 'Dec 20' },
        { opponent: 'AMP', result: 'L', score: '11-15', date: 'Dec 19' },
      ],
      seasonStats: {
        pointsFor: 98,
        pointsAgainst: 87,
        breaks: 15,
        holds: 32,
      }
    },
    {
      id: 3,
      name: 'Triangle Youth',
      abbrev: 'TYU',
      color: '#22C55E',
      division: 'U20 Mixed',
      season: '2024',
      role: 'coach',
      record: { wins: 6, losses: 1 },
      roster: [
        { number: '2', name: 'Adams', position: 'Handler', captain: true },
        { number: '14', name: 'Brooks', position: 'Cutter', captain: false },
        { number: '7', name: 'Clark', position: 'Handler', captain: false },
        { number: '19', name: 'Evans', position: 'Cutter', captain: false },
        { number: '11', name: 'Foster', position: 'Hybrid', captain: true },
      ],
      recentGames: [
        { opponent: 'Raleigh Rising', result: 'W', score: '13-8', date: 'Dec 22' },
        { opponent: 'Charlotte Jr', result: 'W', score: '15-10', date: 'Dec 21' },
      ],
      seasonStats: {
        pointsFor: 89,
        pointsAgainst: 61,
        breaks: 18,
        holds: 28,
      }
    },
  ];

  // Sort teams by role priority (coach first, then captain, then player)
  const sortedTeams = [...teams].sort((a, b) => 
    roleConfig[a.role].priority - roleConfig[b.role].priority
  );

  const currentTeam = teams[activeTeam];
  const currentRole = roleConfig[currentTeam.role];

  const NavIcon = ({ name, active }) => {
    const color = active ? t.text : t.dim;
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
    <div style={{ minHeight: '100vh', background: isDark ? '#0A0A0A' : '#F0F0F0', padding: 20, fontFamily: 'system-ui, -apple-system, sans-serif' }}>
      {/* Toggle */}
      <div style={{ display: 'flex', justifyContent: 'center', gap: 8, marginBottom: 24 }}>
        {['Dark', 'Light'].map(mode => (
          <button key={mode} onClick={() => setIsDark(mode === 'Dark')}
            style={{ padding: '10px 24px', borderRadius: 100, border: 'none', cursor: 'pointer',
              background: (mode === 'Dark' ? isDark : !isDark) ? (isDark ? '#FFF' : '#000') : 'transparent',
              color: (mode === 'Dark' ? isDark : !isDark) ? (isDark ? '#000' : '#FFF') : '#737373',
              fontWeight: 600, fontSize: 14 }}>
            {mode}
          </button>
        ))}
      </div>

      {/* Phone */}
      <div style={{ width: 375, height: 812, margin: '0 auto', background: t.bg, borderRadius: 44, 
        border: `1px solid ${t.border}`, overflow: 'hidden', position: 'relative',
        boxShadow: isDark ? '0 25px 50px -12px rgba(0,0,0,0.8)' : '0 25px 50px -12px rgba(0,0,0,0.15)' }}>
        
        {/* Status Bar */}
        <div style={{ height: 44, display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '0 28px' }}>
          <span style={{ color: t.text, fontSize: 14, fontWeight: 600 }}>9:41</span>
          <div style={{ display: 'flex', gap: 6 }}>
            <svg width="18" height="12" fill={t.text}><rect x="0" y="3" width="4" height="9" rx="1"/><rect x="5" y="1.5" width="4" height="10.5" rx="1"/><rect x="10" y="0" width="4" height="12" rx="1"/></svg>
            <svg width="16" height="12" fill={t.text}><path d="M8 2C10 2 11.8 2.8 13 4L14.5 2.5C12.8 0.8 10.5 0 8 0C5.5 0 3.2 0.8 1.5 2.5L3 4C4.2 2.8 6 2 8 2ZM5 6.5L8 10L11 6.5C10 5.5 9 5 8 5C7 5 6 5.5 5 6.5Z"/></svg>
            <svg width="25" height="12" fill={t.text}><rect x="0" y="0" width="22" height="12" rx="3" fill="none" stroke={t.text}/><rect x="2" y="2" width="17" height="8" rx="1.5"/><path d="M23 4V8C24 7.5 24.5 6.8 24.5 6C24.5 5.2 24 4.5 23 4Z"/></svg>
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
          borderRight: `1px solid ${t.border}`,
          zIndex: 20,
          transform: drawerOpen ? 'translateX(0)' : 'translateX(-100%)',
          transition: 'transform 0.3s ease',
          display: 'flex',
          flexDirection: 'column',
        }}>
          {/* Drawer Header */}
          <div style={{ padding: '60px 20px 20px', borderBottom: `1px solid ${t.border}` }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <h2 style={{ margin: 0, fontSize: 20, fontWeight: 700, color: t.text }}>My Teams</h2>
              <button 
                onClick={() => setDrawerOpen(false)}
                style={{
                  width: 32, height: 32, borderRadius: 8,
                  background: t.accentBg, border: 'none',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  cursor: 'pointer',
                }}
              >
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                  <path d="M18 6L6 18M6 6L18 18" stroke={t.text} strokeWidth="2" strokeLinecap="round"/>
                </svg>
              </button>
            </div>
            <p style={{ margin: '8px 0 0', fontSize: 13, color: t.muted }}>
              {teams.length} teams
            </p>
          </div>

          {/* Role Sections */}
          <div style={{ flex: 1, overflowY: 'auto', padding: '12px 0' }}>
            {/* Coach Section */}
            {sortedTeams.filter(team => team.role === 'coach').length > 0 && (
              <div style={{ marginBottom: 16 }}>
                <div style={{ 
                  display: 'flex', alignItems: 'center', gap: 8,
                  padding: '8px 20px',
                }}>
                  <span style={{ fontSize: 14 }}>{roleConfig.coach.icon}</span>
                  <span style={{ 
                    fontSize: 11, fontWeight: 600, color: roleConfig.coach.color,
                    textTransform: 'uppercase', letterSpacing: 1,
                  }}>
                    Coaching
                  </span>
                </div>
                {sortedTeams.filter(team => team.role === 'coach').map((team) => {
                  const originalIndex = teams.findIndex(t => t.id === team.id);
                  return (
                    <div
                      key={team.id}
                      onClick={() => selectTeam(originalIndex)}
                      style={{
                        display: 'flex', alignItems: 'center', gap: 12,
                        padding: '12px 20px',
                        background: activeTeam === originalIndex ? t.accentBg : 'transparent',
                        cursor: 'pointer',
                        borderLeft: activeTeam === originalIndex ? `3px solid ${team.color}` : '3px solid transparent',
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
                        <p style={{ margin: '2px 0 0', fontSize: 11, color: t.muted }}>
                          {team.division}
                        </p>
                      </div>
                      <span style={{ fontSize: 12, color: t.muted }}>
                        {team.record.wins}-{team.record.losses}
                      </span>
                    </div>
                  );
                })}
              </div>
            )}

            {/* Captain Section */}
            {sortedTeams.filter(team => team.role === 'captain').length > 0 && (
              <div style={{ marginBottom: 16 }}>
                <div style={{ 
                  display: 'flex', alignItems: 'center', gap: 8,
                  padding: '8px 20px',
                }}>
                  <span style={{ fontSize: 14 }}>{roleConfig.captain.icon}</span>
                  <span style={{ 
                    fontSize: 11, fontWeight: 600, color: roleConfig.captain.color,
                    textTransform: 'uppercase', letterSpacing: 1,
                  }}>
                    Captain
                  </span>
                </div>
                {sortedTeams.filter(team => team.role === 'captain').map((team) => {
                  const originalIndex = teams.findIndex(t => t.id === team.id);
                  return (
                    <div
                      key={team.id}
                      onClick={() => selectTeam(originalIndex)}
                      style={{
                        display: 'flex', alignItems: 'center', gap: 12,
                        padding: '12px 20px',
                        background: activeTeam === originalIndex ? t.accentBg : 'transparent',
                        cursor: 'pointer',
                        borderLeft: activeTeam === originalIndex ? `3px solid ${team.color}` : '3px solid transparent',
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
                        <p style={{ margin: '2px 0 0', fontSize: 11, color: t.muted }}>
                          {team.division}
                        </p>
                      </div>
                      <span style={{ fontSize: 12, color: t.muted }}>
                        {team.record.wins}-{team.record.losses}
                      </span>
                    </div>
                  );
                })}
              </div>
            )}

            {/* Player Section */}
            {sortedTeams.filter(team => team.role === 'player').length > 0 && (
              <div style={{ marginBottom: 16 }}>
                <div style={{ 
                  display: 'flex', alignItems: 'center', gap: 8,
                  padding: '8px 20px',
                }}>
                  <span style={{ fontSize: 14 }}>{roleConfig.player.icon}</span>
                  <span style={{ 
                    fontSize: 11, fontWeight: 600, color: roleConfig.player.color,
                    textTransform: 'uppercase', letterSpacing: 1,
                  }}>
                    Playing
                  </span>
                </div>
                {sortedTeams.filter(team => team.role === 'player').map((team) => {
                  const originalIndex = teams.findIndex(t => t.id === team.id);
                  return (
                    <div
                      key={team.id}
                      onClick={() => selectTeam(originalIndex)}
                      style={{
                        display: 'flex', alignItems: 'center', gap: 12,
                        padding: '12px 20px',
                        background: activeTeam === originalIndex ? t.accentBg : 'transparent',
                        cursor: 'pointer',
                        borderLeft: activeTeam === originalIndex ? `3px solid ${team.color}` : '3px solid transparent',
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
                        <p style={{ margin: '2px 0 0', fontSize: 11, color: t.muted }}>
                          {team.division}
                        </p>
                      </div>
                      <span style={{ fontSize: 12, color: t.muted }}>
                        {team.record.wins}-{team.record.losses}
                      </span>
                    </div>
                  );
                })}
              </div>
            )}
          </div>

          {/* Drawer Footer */}
          <div style={{ padding: '16px 20px', borderTop: `1px solid ${t.border}` }}>
            <button style={{
              width: '100%', padding: '12px', borderRadius: 10,
              border: `1px solid ${t.border}`, background: t.card,
              color: t.text, fontSize: 13, fontWeight: 600, cursor: 'pointer',
              display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8,
            }}>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                <path d="M12 5V19M5 12H19" stroke={t.text} strokeWidth="2" strokeLinecap="round"/>
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
              {/* Hamburger + Team Name */}
              <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                <button 
                  onClick={() => setDrawerOpen(true)}
                  style={{ 
                    width: 40, height: 40, borderRadius: 12, border: `1px solid ${t.border}`,
                    background: t.card, display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer'
                  }}
                >
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                    <path d="M3 6H21M3 12H21M3 18H21" stroke={t.text} strokeWidth="2" strokeLinecap="round"/>
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
                    <span style={{ fontSize: 12, color: t.dim }}>•</span>
                    <span style={{ fontSize: 12, color: t.muted }}>{currentTeam.division}</span>
                  </div>
                </div>
              </div>
              
              {/* Team Color Badge */}
              <div style={{
                width: 44, height: 44, borderRadius: 12,
                background: `${currentTeam.color}20`,
                border: `2px solid ${currentTeam.color}`,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
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
            border: `1px solid ${t.border}`,
            borderRadius: 16,
            padding: 16,
          }}>
            {/* Record Row */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 16 }}>
              <div>
                <p style={{ margin: 0, fontSize: 11, color: t.muted, textTransform: 'uppercase', letterSpacing: 0.5 }}>
                  {currentTeam.season} Season Record
                </p>
                <p style={{ margin: '6px 0 0', fontSize: 32, fontWeight: 700 }}>
                  <span style={{ color: t.win }}>{currentTeam.record.wins}</span>
                  <span style={{ color: t.dim }}> - </span>
                  <span style={{ color: t.lose }}>{currentTeam.record.losses}</span>
                </p>
              </div>
              <div style={{ 
                width: 60, height: 60, borderRadius: 30,
                background: t.accentBg,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <span style={{ fontSize: 16, fontWeight: 700, color: t.text }}>
                  {Math.round((currentTeam.record.wins / (currentTeam.record.wins + currentTeam.record.losses)) * 100)}%
                </span>
              </div>
            </div>

            {/* Stats Grid */}
            <div style={{ 
              display: 'grid', gridTemplateColumns: 'repeat(4, 1fr)', gap: 8,
              paddingTop: 16, borderTop: `1px solid ${t.border}`,
            }}>
              <div style={{ textAlign: 'center' }}>
                <p style={{ margin: 0, fontSize: 18, fontWeight: 700, color: t.text }}>
                  {currentTeam.seasonStats.pointsFor}
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 10, color: t.muted }}>Pts For</p>
              </div>
              <div style={{ textAlign: 'center' }}>
                <p style={{ margin: 0, fontSize: 18, fontWeight: 700, color: t.text }}>
                  {currentTeam.seasonStats.pointsAgainst}
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 10, color: t.muted }}>Pts Against</p>
              </div>
              <div style={{ textAlign: 'center' }}>
                <p style={{ margin: 0, fontSize: 18, fontWeight: 700, color: t.win }}>
                  {currentTeam.seasonStats.holds}
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 10, color: t.muted }}>Holds</p>
              </div>
              <div style={{ textAlign: 'center' }}>
                <p style={{ margin: 0, fontSize: 18, fontWeight: 700, color: t.blue }}>
                  {currentTeam.seasonStats.breaks}
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 10, color: t.muted }}>Breaks</p>
              </div>
            </div>
          </div>

          {/* Tab Navigation */}
          <div style={{ 
            display: 'flex', margin: '0 16px 12px', 
            background: t.card, borderRadius: 10, padding: 3,
            border: `1px solid ${t.border}`,
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
                  background: activeTab === tab.key ? t.accent : 'transparent',
                  color: activeTab === tab.key ? t.bg : t.muted,
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
                border: `1px solid ${t.border}`,
                borderRadius: 14,
                overflow: 'hidden',
              }}>
                {/* Header */}
                <div style={{
                  display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                  padding: '12px 14px',
                  background: t.accentBg,
                  borderBottom: `1px solid ${t.border}`,
                }}>
                  <span style={{ fontSize: 11, fontWeight: 600, color: t.muted, textTransform: 'uppercase', letterSpacing: 1 }}>
                    {currentTeam.roster.length} Players
                  </span>
                  {(currentTeam.role === 'captain' || currentTeam.role === 'coach') && (
                    <button style={{
                      padding: '6px 12px', borderRadius: 6,
                      background: `${currentTeam.color}20`, border: 'none',
                      color: currentTeam.color, fontSize: 11, fontWeight: 600, cursor: 'pointer',
                    }}>
                      + Add Player
                    </button>
                  )}
                </div>

                {/* Players */}
                {currentTeam.roster.map((player, i) => (
                  <div
                    key={i}
                    style={{
                      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                      padding: '12px 14px',
                      borderBottom: i < currentTeam.roster.length - 1 ? `1px solid ${t.border}` : 'none',
                    }}
                  >
                    <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                      <div style={{
                        width: 40, height: 40, borderRadius: 10,
                        background: t.accentBg,
                        display: 'flex', alignItems: 'center', justifyContent: 'center',
                      }}>
                        <span style={{ fontSize: 16, fontWeight: 700, color: t.text }}>
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
                              fontSize: 8, fontWeight: 700, color: currentTeam.color,
                              background: `${currentTeam.color}20`, padding: '2px 5px', borderRadius: 4,
                            }}>
                              C
                            </span>
                          )}
                        </div>
                        <span style={{ fontSize: 12, color: t.muted }}>{player.position}</span>
                      </div>
                    </div>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                      <path d="M9 18L15 12L9 6" stroke={t.dim} strokeWidth="2" strokeLinecap="round"/>
                    </svg>
                  </div>
                ))}
              </div>
            )}

            {/* Games Tab */}
            {activeTab === 'games' && (
              <div>
                <p style={{ 
                  margin: '0 0 12px', fontSize: 11, fontWeight: 600, color: t.muted,
                  textTransform: 'uppercase', letterSpacing: 1,
                }}>
                  Recent Games
                </p>
                
                {currentTeam.recentGames.map((game, i) => (
                  <div
                    key={i}
                    style={{
                      background: t.card,
                      border: `1px solid ${t.border}`,
                      borderRadius: 14,
                      padding: 14,
                      marginBottom: 10,
                    }}
                  >
                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 }}>
                      <span style={{ fontSize: 11, color: t.dim }}>{game.date}</span>
                      <span style={{ 
                        fontSize: 10, fontWeight: 600, 
                        color: game.result === 'W' ? t.win : t.lose,
                        background: game.result === 'W' ? `${t.win}18` : `${t.lose}18`,
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
                        fontSize: 18, fontWeight: 700, color: t.text,
                        fontVariantNumeric: 'tabular-nums',
                      }}>
                        {game.score}
                      </span>
                    </div>
                  </div>
                ))}

                <button style={{
                  width: '100%', padding: '14px', borderRadius: 12,
                  border: `1px solid ${t.border}`, background: t.card,
                  color: t.muted, fontSize: 13, fontWeight: 600, cursor: 'pointer',
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
                border: `1px solid ${t.border}`,
                borderRadius: 14,
                overflow: 'hidden',
              }}>
                {/* Show different options based on role */}
                {currentTeam.role === 'coach' && (
                  <>
                    {[
                      { icon: '✏️', label: 'Edit Team Info', desc: 'Name, colors, division' },
                      { icon: '📋', label: 'Manage Lines', desc: 'O-Line, D-Line presets' },
                      { icon: '👥', label: 'Manage Roster', desc: 'Add, remove, edit players' },
                      { icon: '📊', label: 'Export Stats', desc: 'Download season data' },
                      { icon: '🔗', label: 'Share Team', desc: 'Invite players to join' },
                      { icon: '🔔', label: 'Notifications', desc: 'Game reminders' },
                    ].map((item, i) => (
                      <div
                        key={i}
                        style={{
                          display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                          padding: '14px',
                          borderBottom: `1px solid ${t.border}`,
                          cursor: 'pointer',
                        }}
                      >
                        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                          <span style={{ fontSize: 20 }}>{item.icon}</span>
                          <div>
                            <p style={{ margin: 0, fontSize: 14, fontWeight: 500, color: t.text }}>
                              {item.label}
                            </p>
                            <p style={{ margin: '2px 0 0', fontSize: 12, color: t.muted }}>
                              {item.desc}
                            </p>
                          </div>
                        </div>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                          <path d="M9 18L15 12L9 6" stroke={t.dim} strokeWidth="2" strokeLinecap="round"/>
                        </svg>
                      </div>
                    ))}
                  </>
                )}

                {currentTeam.role === 'captain' && (
                  <>
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
                          borderBottom: `1px solid ${t.border}`,
                          cursor: 'pointer',
                        }}
                      >
                        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                          <span style={{ fontSize: 20 }}>{item.icon}</span>
                          <div>
                            <p style={{ margin: 0, fontSize: 14, fontWeight: 500, color: t.text }}>
                              {item.label}
                            </p>
                            <p style={{ margin: '2px 0 0', fontSize: 12, color: t.muted }}>
                              {item.desc}
                            </p>
                          </div>
                        </div>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                          <path d="M9 18L15 12L9 6" stroke={t.dim} strokeWidth="2" strokeLinecap="round"/>
                        </svg>
                      </div>
                    ))}
                  </>
                )}

                {currentTeam.role === 'player' && (
                  <>
                    {[
                      { icon: '📊', label: 'My Stats', desc: 'View your season stats' },
                      { icon: '🔔', label: 'Notifications', desc: 'Game reminders' },
                    ].map((item, i) => (
                      <div
                        key={i}
                        style={{
                          display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                          padding: '14px',
                          borderBottom: `1px solid ${t.border}`,
                          cursor: 'pointer',
                        }}
                      >
                        <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                          <span style={{ fontSize: 20 }}>{item.icon}</span>
                          <div>
                            <p style={{ margin: 0, fontSize: 14, fontWeight: 500, color: t.text }}>
                              {item.label}
                            </p>
                            <p style={{ margin: '2px 0 0', fontSize: 12, color: t.muted }}>
                              {item.desc}
                            </p>
                          </div>
                        </div>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                          <path d="M9 18L15 12L9 6" stroke={t.dim} strokeWidth="2" strokeLinecap="round"/>
                        </svg>
                      </div>
                    ))}
                  </>
                )}

                <div style={{ padding: '14px' }}>
                  <button style={{
                    width: '100%', padding: '12px', borderRadius: 10,
                    border: `1px solid ${t.lose}40`, background: `${t.lose}10`,
                    color: t.lose, fontSize: 13, fontWeight: 600, cursor: 'pointer',
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
          background: t.bg, borderTop: `1px solid ${t.border}`, 
          display: 'flex', justifyContent: 'space-around', alignItems: 'flex-start', paddingTop: 10 
        }}>
          {['home', 'games', 'teams', 'stats', 'profile'].map((n) => (
            <div key={n} style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 3, cursor: 'pointer' }}>
              <NavIcon name={n} active={n === 'teams'} />
              <span style={{ fontSize: 10, fontWeight: n === 'teams' ? 600 : 500, color: n === 'teams' ? t.text : t.dim, textTransform: 'capitalize' }}>{n}</span>
            </div>
          ))}
        </div>
        <div style={{ position: 'absolute', bottom: 8, left: '50%', transform: 'translateX(-50%)', width: 134, height: 5, background: t.text, borderRadius: 3, opacity: 0.2 }} />
      </div>
      
      <p style={{ textAlign: 'center', marginTop: 24, fontSize: 13, color: '#737373' }}>
        <strong>Teams Screen v2</strong> · Hamburger drawer · Role-based views · Coach/Captain/Player
      </p>
    </div>
  );
}
