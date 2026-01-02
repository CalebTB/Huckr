import React, { useState } from 'react';

// 🌅 Golden Hour Theme - Stats Screen
// Warm sunset & amber glow aesthetic

export default function GoldenHourStatsScreen() {
  const [isDark, setIsDark] = useState(true);
  const [activeTeam, setActiveTeam] = useState(null);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const [activeTab, setActiveTab] = useState('overview');
  
  // Golden Hour Theme Colors
  const t = isDark ? {
    bg: '#0C0A05',
    surface: '#141008',
    card: '#1E1810',
    border: '#382C1A',
    text: '#FFFFFF',
    muted: '#C4A878',
    dim: '#8A7550',
    accent: '#F59E0B',
    accentLight: '#FBBF24',
    accentMuted: 'rgba(245,158,11,0.15)',
    gradient: 'linear-gradient(135deg, #FBBF24, #F59E0B)',
    win: '#22C55E',
    lose: '#EF4444',
    blue: '#3B82F6',
    purple: '#A855F7',
    cyan: '#06B6D4',
  } : {
    bg: '#FFFDF5',
    surface: '#FFF9E8',
    card: '#FFFFFF',
    border: '#FFE8B8',
    text: '#1E1810',
    muted: '#8A7550',
    dim: '#C4A878',
    accent: '#D97706',
    accentLight: '#F59E0B',
    accentMuted: 'rgba(217,119,6,0.1)',
    gradient: 'linear-gradient(135deg, #FBBF24, #F59E0B)',
    win: '#22C55E',
    lose: '#EF4444',
    blue: '#3B82F6',
    purple: '#A855F7',
    cyan: '#0891B2',
  };

  const teams = [
    { id: 1, name: 'Ring of Fire', abbrev: 'ROF', color: '#EF4444', division: "Men's Club" },
    { id: 2, name: 'Durham Haze', abbrev: 'DHZ', color: '#8B5CF6', division: 'Mixed Club' },
    { id: 3, name: 'Triangle Youth', abbrev: 'TYU', color: '#22C55E', division: 'U20 Mixed' },
  ];

  const teamStats = {
    1: {
      games: 12, points: 48, goals: 18, assists: 24, catches: 156, completions: 89,
      drops: 3, throwaways: 5, stalls: 0, blocks: 12, callahans: 1,
      oPoints: 28, dPoints: 20, holds: 24, breaks: 8,
      pullsThrown: 15, pullHangTime: 3.2, pullsOB: 2,
    },
    2: {
      games: 7, points: 22, goals: 8, assists: 11, catches: 78, completions: 45,
      drops: 2, throwaways: 3, stalls: 0, blocks: 6, callahans: 0,
      oPoints: 14, dPoints: 8, holds: 12, breaks: 3,
      pullsThrown: 6, pullHangTime: 2.9, pullsOB: 1,
    },
    3: {
      games: 7, points: 0, goals: 0, assists: 0, catches: 0, completions: 0,
      drops: 0, throwaways: 0, stalls: 0, blocks: 0, callahans: 0,
      oPoints: 0, dPoints: 0, holds: 0, breaks: 0,
      pullsThrown: 0, pullHangTime: 0, pullsOB: 0,
      isCoach: true,
    },
  };

  const connectionStats = {
    1: {
      thrownTo: [
        { number: '7', name: 'Smith', throws: 28, completions: 27, goals: 8, drops: 1 },
        { number: '23', name: 'Johnson', throws: 19, completions: 18, goals: 4, drops: 1 },
        { number: '8', name: 'Miller', throws: 15, completions: 14, goals: 3, drops: 0 },
        { number: '15', name: 'Wilson', throws: 12, completions: 12, goals: 2, drops: 0 },
        { number: '3', name: 'Moore', throws: 9, completions: 8, goals: 1, drops: 1 },
      ],
      caughtFrom: [
        { number: '11', name: 'Williams', catches: 42, goals: 6, drops: 1 },
        { number: '5', name: 'Davis', catches: 38, goals: 5, drops: 0 },
        { number: '21', name: 'Taylor', catches: 28, goals: 3, drops: 1 },
        { number: '15', name: 'Wilson', catches: 22, goals: 2, drops: 0 },
        { number: '3', name: 'Moore', catches: 14, goals: 1, drops: 1 },
      ],
      goalConnections: [
        { thrower: { number: '11', name: 'Williams' }, scorer: 'You', count: 6 },
        { thrower: { number: '5', name: 'Davis' }, scorer: 'You', count: 5 },
        { thrower: 'You', scorer: { number: '7', name: 'Smith' }, count: 8 },
        { thrower: 'You', scorer: { number: '23', name: 'Johnson' }, count: 4 },
        { thrower: 'You', scorer: { number: '8', name: 'Miller' }, count: 3 },
      ],
    },
    2: {
      thrownTo: [
        { number: '1', name: 'Chen', throws: 18, completions: 17, goals: 3, drops: 0 },
        { number: '22', name: 'Park', throws: 12, completions: 11, goals: 2, drops: 1 },
        { number: '17', name: 'Martinez', throws: 8, completions: 8, goals: 2, drops: 0 },
      ],
      caughtFrom: [
        { number: '9', name: 'Kim', catches: 32, goals: 4, drops: 1 },
        { number: '1', name: 'Chen', catches: 24, goals: 2, drops: 0 },
        { number: '12', name: 'Garcia', catches: 14, goals: 1, drops: 1 },
      ],
      goalConnections: [
        { thrower: { number: '9', name: 'Kim' }, scorer: 'You', count: 4 },
        { thrower: 'You', scorer: { number: '1', name: 'Chen' }, count: 3 },
        { thrower: { number: '1', name: 'Chen' }, scorer: 'You', count: 2 },
      ],
    },
    3: { thrownTo: [], caughtFrom: [], goalConnections: [] },
  };

  const aggregateConnections = () => {
    const allThrownTo = {};
    const allCaughtFrom = {};
    
    Object.entries(connectionStats).forEach(([teamId, stats]) => {
      if (teamStats[teamId].isCoach) return;
      
      stats.thrownTo.forEach(p => {
        const key = `${teamId}-${p.number}`;
        if (!allThrownTo[key]) {
          allThrownTo[key] = { ...p, team: teams.find(t => t.id === parseInt(teamId)) };
        }
      });
      
      stats.caughtFrom.forEach(p => {
        const key = `${teamId}-${p.number}`;
        if (!allCaughtFrom[key]) {
          allCaughtFrom[key] = { ...p, team: teams.find(t => t.id === parseInt(teamId)) };
        }
      });
    });
    
    return {
      thrownTo: Object.values(allThrownTo).sort((a, b) => b.throws - a.throws),
      caughtFrom: Object.values(allCaughtFrom).sort((a, b) => b.catches - a.catches),
      goalConnections: Object.values(connectionStats)
        .flatMap((s, i) => s.goalConnections.map(g => ({ ...g, team: teams[i] })))
        .sort((a, b) => b.count - a.count)
        .slice(0, 8),
    };
  };

  const aggregateStats = {
    games: Object.values(teamStats).reduce((sum, s) => sum + (s.isCoach ? 0 : s.games), 0),
    points: Object.values(teamStats).reduce((sum, s) => sum + s.points, 0),
    goals: Object.values(teamStats).reduce((sum, s) => sum + s.goals, 0),
    assists: Object.values(teamStats).reduce((sum, s) => sum + s.assists, 0),
    catches: Object.values(teamStats).reduce((sum, s) => sum + s.catches, 0),
    completions: Object.values(teamStats).reduce((sum, s) => sum + s.completions, 0),
    drops: Object.values(teamStats).reduce((sum, s) => sum + s.drops, 0),
    throwaways: Object.values(teamStats).reduce((sum, s) => sum + s.throwaways, 0),
    stalls: Object.values(teamStats).reduce((sum, s) => sum + s.stalls, 0),
    blocks: Object.values(teamStats).reduce((sum, s) => sum + s.blocks, 0),
    callahans: Object.values(teamStats).reduce((sum, s) => sum + s.callahans, 0),
    oPoints: Object.values(teamStats).reduce((sum, s) => sum + s.oPoints, 0),
    dPoints: Object.values(teamStats).reduce((sum, s) => sum + s.dPoints, 0),
    holds: Object.values(teamStats).reduce((sum, s) => sum + s.holds, 0),
    breaks: Object.values(teamStats).reduce((sum, s) => sum + s.breaks, 0),
    pullsThrown: Object.values(teamStats).reduce((sum, s) => sum + s.pullsThrown, 0),
    pullHangTime: 3.1,
    pullsOB: Object.values(teamStats).reduce((sum, s) => sum + s.pullsOB, 0),
  };

  const currentStats = activeTeam ? teamStats[activeTeam] : aggregateStats;
  const currentConnections = activeTeam ? connectionStats[activeTeam] : aggregateConnections();
  const currentTeam = activeTeam ? teams.find(tm => tm.id === activeTeam) : null;

  const catchRate = currentStats.catches > 0 ? ((currentStats.catches - currentStats.drops) / currentStats.catches * 100).toFixed(1) : 0;
  const completionRate = currentStats.completions > 0 ? ((currentStats.completions - currentStats.throwaways) / currentStats.completions * 100).toFixed(1) : 0;
  const pullOBRate = currentStats.pullsThrown > 0 ? ((currentStats.pullsThrown - currentStats.pullsOB) / currentStats.pullsThrown * 100).toFixed(0) : 0;

  const NavIcon = ({ name, active }) => {
    const color = active ? t.accent : t.dim;
    const icons = {
      home: <path d="M3 9L12 2L21 9V20C21 21.1 20.1 22 19 22H5C3.9 22 3 21.1 3 20V9Z" stroke={color} strokeWidth="2" fill="none"/>,
      games: <><circle cx="12" cy="12" r="10" stroke={color} strokeWidth="2" fill="none"/><path d="M12 8V12L15 15" stroke={color} strokeWidth="2" strokeLinecap="round"/></>,
      teams: <><path d="M17 21V19C17 16.79 15.21 15 13 15H5C2.79 15 1 16.79 1 19V21" stroke={color} strokeWidth="2" fill="none"/><circle cx="9" cy="7" r="4" stroke={color} strokeWidth="2" fill="none"/></>,
      stats: <path d="M18 20V10M12 20V4M6 20V14" stroke={color} strokeWidth="2.5" strokeLinecap="round"/>,
      profile: <><circle cx="12" cy="8" r="4" stroke={color} strokeWidth="2" fill="none"/><path d="M20 21C20 16.58 16.42 13 12 13C7.58 13 4 16.58 4 21" stroke={color} strokeWidth="2"/></>,
    };
    return <svg width="22" height="22" viewBox="0 0 24 24" fill="none">{icons[name]}</svg>;
  };

  const StatCard = ({ label, value, subvalue, color, icon }) => (
    <div style={{
      background: t.card,
      border: `1px solid ${t.border}`,
      borderRadius: 14,
      padding: 14,
      textAlign: 'center',
      boxShadow: isDark ? `0 0 20px ${t.accent}10` : 'none',
    }}>
      {icon && <span style={{ fontSize: 20, marginBottom: 4, display: 'block' }}>{icon}</span>}
      <p style={{ 
        margin: 0, fontSize: 28, fontWeight: 700, 
        color: color || t.accent,
        fontVariantNumeric: 'tabular-nums',
        textShadow: isDark ? `0 0 20px ${color || t.accent}40` : 'none',
      }}>
        {value}
      </p>
      <p style={{ margin: '4px 0 0', fontSize: 11, color: t.muted }}>{label}</p>
      {subvalue && (
        <p style={{ margin: '2px 0 0', fontSize: 10, color: t.dim }}>{subvalue}</p>
      )}
    </div>
  );

  const selectTeam = (teamId) => {
    setActiveTeam(teamId);
    setDrawerOpen(false);
  };

  const ProgressBar = ({ value, max, color }) => (
    <div style={{ 
      width: '100%', height: 4, background: t.border, borderRadius: 2,
      marginTop: 6, overflow: 'hidden',
    }}>
      <div style={{ 
        width: `${(value / max) * 100}%`, 
        height: '100%', 
        background: color || t.gradient,
        borderRadius: 2,
        transition: 'width 0.3s ease',
        boxShadow: `0 0 10px ${color || t.accent}60`,
      }} />
    </div>
  );

  return (
    <div style={{ minHeight: '100vh', background: isDark ? '#080604' : '#FAF8F5', padding: 20, fontFamily: 'system-ui, -apple-system, sans-serif' }}>
      {/* Mode Toggle */}
      <div style={{ display: 'flex', justifyContent: 'center', gap: 8, marginBottom: 24 }}>
        {['Dark', 'Light'].map(mode => (
          <button key={mode} onClick={() => setIsDark(mode === 'Dark')}
            style={{ 
              padding: '10px 24px', borderRadius: 100, border: 'none', cursor: 'pointer',
              background: (mode === 'Dark' ? isDark : !isDark) ? t.gradient : 'transparent',
              color: (mode === 'Dark' ? isDark : !isDark) ? '#000' : t.dim,
              fontWeight: 600, fontSize: 14,
              boxShadow: (mode === 'Dark' ? isDark : !isDark) ? '0 4px 20px rgba(245,158,11,0.4)' : 'none',
            }}>
            {mode}
          </button>
        ))}
      </div>

      {/* Phone Frame */}
      <div style={{ 
        width: 375, height: 812, margin: '0 auto', background: t.bg, borderRadius: 44, 
        border: `1px solid ${t.border}`, overflow: 'hidden', position: 'relative',
        boxShadow: isDark 
          ? '0 25px 50px -12px rgba(0,0,0,0.8), 0 0 60px rgba(245,158,11,0.15)' 
          : '0 25px 50px -12px rgba(0,0,0,0.15)',
      }}>
        
        {/* Status Bar */}
        <div style={{ height: 44, display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '0 28px' }}>
          <span style={{ color: t.text, fontSize: 14, fontWeight: 600 }}>9:41</span>
          <div style={{ display: 'flex', gap: 6 }}>
            <svg width="18" height="12" fill={t.accent}><rect x="0" y="3" width="4" height="9" rx="1"/><rect x="5" y="1.5" width="4" height="10.5" rx="1"/><rect x="10" y="0" width="4" height="12" rx="1"/></svg>
            <svg width="16" height="12" fill={t.accent}><path d="M8 2C10 2 11.8 2.8 13 4L14.5 2.5C12.8 0.8 10.5 0 8 0C5.5 0 3.2 0.8 1.5 2.5L3 4C4.2 2.8 6 2 8 2ZM5 6.5L8 10L11 6.5C10 5.5 9 5 8 5C7 5 6 5.5 5 6.5Z"/></svg>
            <svg width="25" height="12" fill={t.accent}><rect x="0" y="0" width="22" height="12" rx="3" fill="none" stroke={t.accent}/><rect x="2" y="2" width="17" height="8" rx="1.5"/><path d="M23 4V8C24 7.5 24.5 6.8 24.5 6C24.5 5.2 24 4.5 23 4Z"/></svg>
          </div>
        </div>

        {/* Drawer Overlay */}
        {drawerOpen && (
          <div 
            onClick={() => setDrawerOpen(false)}
            style={{
              position: 'absolute', top: 0, left: 0, right: 0, bottom: 0,
              background: 'rgba(0,0,0,0.7)',
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
          boxShadow: drawerOpen ? '10px 0 40px rgba(0,0,0,0.3)' : 'none',
        }}>
          {/* Drawer Header */}
          <div style={{ padding: '60px 20px 20px', borderBottom: `1px solid ${t.border}` }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <h2 style={{ margin: 0, fontSize: 20, fontWeight: 700, color: t.text }}>View Stats</h2>
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
            <p style={{ margin: '8px 0 0', fontSize: 13, color: t.muted }}>
              Select a team or view all
            </p>
          </div>

          {/* Team Options */}
          <div style={{ flex: 1, overflowY: 'auto', padding: '12px 0' }}>
            {/* All Teams Option */}
            <div
              onClick={() => selectTeam(null)}
              style={{
                display: 'flex', alignItems: 'center', gap: 12,
                padding: '14px 20px',
                background: activeTeam === null ? t.accentMuted : 'transparent',
                cursor: 'pointer',
                borderLeft: activeTeam === null ? `3px solid ${t.accent}` : '3px solid transparent',
              }}
            >
              <div style={{
                width: 40, height: 40, borderRadius: 10,
                background: t.gradient,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                boxShadow: '0 4px 15px rgba(245,158,11,0.4)',
              }}>
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                  <path d="M18 20V10M12 20V4M6 20V14" stroke="#000" strokeWidth="2.5" strokeLinecap="round"/>
                </svg>
              </div>
              <div style={{ flex: 1 }}>
                <p style={{ margin: 0, fontSize: 15, fontWeight: 600, color: t.text }}>
                  All Teams
                </p>
                <p style={{ margin: '2px 0 0', fontSize: 12, color: t.muted }}>
                  Combined stats
                </p>
              </div>
              {activeTeam === null && (
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                  <path d="M5 12L10 17L20 7" stroke={t.win} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"/>
                </svg>
              )}
            </div>

            <div style={{ 
              padding: '12px 20px 8px',
              fontSize: 11, fontWeight: 600, color: t.muted,
              textTransform: 'uppercase', letterSpacing: 1,
            }}>
              By Team
            </div>

            {/* Team Options */}
            {teams.map((team) => (
              <div
                key={team.id}
                onClick={() => selectTeam(team.id)}
                style={{
                  display: 'flex', alignItems: 'center', gap: 12,
                  padding: '12px 20px',
                  background: activeTeam === team.id ? t.accentMuted : 'transparent',
                  cursor: 'pointer',
                  borderLeft: activeTeam === team.id ? `3px solid ${team.color}` : '3px solid transparent',
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
                {activeTeam === team.id && (
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                    <path d="M5 12L10 17L20 7" stroke={t.win} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"/>
                  </svg>
                )}
              </div>
            ))}
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
                <path d="M21 15V19C21 20.1 20.1 21 19 21H5C3.9 21 3 20.1 3 19V15" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                <path d="M7 10L12 15L17 10" stroke={t.accent} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                <path d="M12 15V3" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
              </svg>
              Export Stats
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
                    width: 40, height: 40, borderRadius: 12, border: `1px solid ${t.border}`,
                    background: t.card, display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer'
                  }}
                >
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                    <path d="M3 6H21M3 12H21M3 18H21" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                  </svg>
                </button>
                <div>
                  <h1 style={{ 
                    margin: 0, fontSize: 22, fontWeight: 700, color: t.text, letterSpacing: -0.5,
                    textShadow: isDark ? '0 0 30px rgba(245,158,11,0.3)' : 'none',
                  }}>
                    {currentTeam ? currentTeam.name : 'My Stats'}
                  </h1>
                  <p style={{ margin: '2px 0 0', fontSize: 12, color: t.muted }}>
                    {currentTeam ? currentTeam.division : 'All Teams · 2024 Season'}
                  </p>
                </div>
              </div>
              
              {currentTeam ? (
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
              ) : (
                <div style={{
                  width: 44, height: 44, borderRadius: 12,
                  background: t.gradient,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  boxShadow: '0 4px 20px rgba(245,158,11,0.4)',
                }}>
                  <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
                    <path d="M18 20V10M12 20V4M6 20V14" stroke="#000" strokeWidth="2.5" strokeLinecap="round"/>
                  </svg>
                </div>
              )}
            </div>
          </div>

          {/* Games Summary */}
          <div style={{
            margin: '0 16px 12px',
            background: t.card,
            border: `1px solid ${t.border}`,
            borderRadius: 16,
            padding: 16,
            boxShadow: isDark ? '0 0 30px rgba(245,158,11,0.1)' : 'none',
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <div>
                <p style={{ margin: 0, fontSize: 11, color: t.muted, textTransform: 'uppercase', letterSpacing: 0.5 }}>
                  Games Played
                </p>
                <p style={{ 
                  margin: '6px 0 0', fontSize: 36, fontWeight: 700, color: t.accent,
                  textShadow: isDark ? '0 0 30px rgba(245,158,11,0.5)' : 'none',
                }}>
                  {currentStats.games}
                </p>
              </div>
              <div style={{ display: 'flex', gap: 16 }}>
                <div style={{ textAlign: 'center' }}>
                  <p style={{ margin: 0, fontSize: 24, fontWeight: 700, color: t.text }}>
                    {currentStats.points}
                  </p>
                  <p style={{ margin: '2px 0 0', fontSize: 10, color: t.muted }}>Points</p>
                </div>
                <div style={{ width: 1, background: t.border }} />
                <div style={{ textAlign: 'center' }}>
                  <p style={{ margin: 0, fontSize: 24, fontWeight: 700, color: t.win }}>
                    {currentStats.oPoints}
                  </p>
                  <p style={{ margin: '2px 0 0', fontSize: 10, color: t.muted }}>O-Pts</p>
                </div>
                <div style={{ textAlign: 'center' }}>
                  <p style={{ margin: 0, fontSize: 24, fontWeight: 700, color: t.blue }}>
                    {currentStats.dPoints}
                  </p>
                  <p style={{ margin: '2px 0 0', fontSize: 10, color: t.muted }}>D-Pts</p>
                </div>
              </div>
            </div>
          </div>

          {/* Tab Navigation */}
          <div style={{ 
            display: 'flex', margin: '0 16px 12px', 
            background: t.card, borderRadius: 10, padding: 3,
            border: `1px solid ${t.border}`,
            gap: 2,
          }}>
            {[
              { key: 'overview', label: 'Overview' },
              { key: 'connections', label: 'Connections' },
              { key: 'defense', label: 'Defense' },
            ].map(tab => (
              <button
                key={tab.key}
                onClick={() => setActiveTab(tab.key)}
                style={{
                  flex: 1, padding: '10px 6px', borderRadius: 8, border: 'none',
                  background: activeTab === tab.key ? t.gradient : 'transparent',
                  color: activeTab === tab.key ? '#000' : t.muted,
                  fontWeight: 600, fontSize: 11, cursor: 'pointer',
                  boxShadow: activeTab === tab.key ? '0 4px 15px rgba(245,158,11,0.3)' : 'none',
                }}
              >
                {tab.label}
              </button>
            ))}
          </div>

          {/* Tab Content */}
          <div style={{ padding: '0 16px 24px' }}>
            {/* Overview Tab */}
            {activeTab === 'overview' && (
              <>
                {/* Scoring */}
                <p style={{ 
                  margin: '0 0 10px', fontSize: 11, fontWeight: 600, color: t.accent,
                  textTransform: 'uppercase', letterSpacing: 1,
                  textShadow: isDark ? '0 0 15px rgba(245,158,11,0.5)' : 'none',
                }}>
                  Scoring
                </p>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 10, marginBottom: 20 }}>
                  <StatCard label="Goals" value={currentStats.goals} color={t.win} icon="🥅" />
                  <StatCard label="Assists" value={currentStats.assists} color={t.blue} icon="🎯" />
                  <StatCard 
                    label="Callahans" 
                    value={currentStats.callahans} 
                    color={currentStats.callahans > 0 ? t.purple : t.dim} 
                    icon="⚡" 
                  />
                </div>

                {/* Disc Skills */}
                <p style={{ 
                  margin: '0 0 10px', fontSize: 11, fontWeight: 600, color: t.accent,
                  textTransform: 'uppercase', letterSpacing: 1,
                }}>
                  Disc Skills
                </p>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)', gap: 10, marginBottom: 20 }}>
                  <StatCard 
                    label="Catches" 
                    value={currentStats.catches} 
                    subvalue={`${catchRate}% success`}
                    color={t.text} 
                  />
                  <StatCard 
                    label="Completions" 
                    value={currentStats.completions} 
                    subvalue={`${completionRate}% success`}
                    color={t.text} 
                  />
                </div>

                {/* Turnovers */}
                <p style={{ 
                  margin: '0 0 10px', fontSize: 11, fontWeight: 600, color: t.muted,
                  textTransform: 'uppercase', letterSpacing: 1,
                }}>
                  Turnovers
                </p>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 10, marginBottom: 20 }}>
                  <StatCard label="Drops" value={currentStats.drops} color={currentStats.drops > 0 ? t.lose : t.dim} />
                  <StatCard label="Throwaways" value={currentStats.throwaways} color={currentStats.throwaways > 0 ? t.lose : t.dim} />
                  <StatCard label="Stalls" value={currentStats.stalls} color={currentStats.stalls > 0 ? t.lose : t.dim} />
                </div>

                {/* Defense */}
                <p style={{ 
                  margin: '0 0 10px', fontSize: 11, fontWeight: 600, color: t.accent,
                  textTransform: 'uppercase', letterSpacing: 1,
                }}>
                  Defense
                </p>
                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(2, 1fr)', gap: 10 }}>
                  <StatCard label="Blocks" value={currentStats.blocks} color={t.blue} icon="🛡️" />
                  <StatCard label="Breaks" value={currentStats.breaks} color={t.cyan} icon="💥" />
                </div>
              </>
            )}

            {/* Connections Tab */}
            {activeTab === 'connections' && (
              <>
                {/* Thrown To */}
                <div style={{
                  background: t.card,
                  border: `1px solid ${t.border}`,
                  borderRadius: 14,
                  overflow: 'hidden',
                  marginBottom: 16,
                  boxShadow: isDark ? '0 0 20px rgba(245,158,11,0.1)' : 'none',
                }}>
                  <div style={{
                    padding: '12px 14px',
                    background: t.accentMuted,
                    borderBottom: `1px solid ${t.border}`,
                    display: 'flex', alignItems: 'center', gap: 8,
                  }}>
                    <span style={{ fontSize: 16 }}>🎯</span>
                    <span style={{ fontSize: 12, fontWeight: 700, color: t.accent, textTransform: 'uppercase', letterSpacing: 1 }}>
                      You Threw To
                    </span>
                  </div>
                  
                  {currentConnections.thrownTo.length === 0 ? (
                    <p style={{ padding: 20, margin: 0, fontSize: 13, color: t.muted, textAlign: 'center' }}>
                      No throwing data yet
                    </p>
                  ) : (
                    currentConnections.thrownTo.slice(0, 5).map((player, i) => {
                      const maxThrows = currentConnections.thrownTo[0].throws;
                      const compRate = ((player.completions / player.throws) * 100).toFixed(0);
                      return (
                        <div
                          key={i}
                          style={{
                            padding: '12px 14px',
                            borderBottom: i < Math.min(currentConnections.thrownTo.length - 1, 4) ? `1px solid ${t.border}` : 'none',
                          }}
                        >
                          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                              <div style={{
                                width: 36, height: 36, borderRadius: 8,
                                background: player.team ? `${player.team.color}20` : t.accentMuted,
                                border: `2px solid ${player.team?.color || t.accent}`,
                                display: 'flex', alignItems: 'center', justifyContent: 'center',
                              }}>
                                <span style={{ fontSize: 12, fontWeight: 700, color: player.team?.color || t.text }}>
                                  {player.number}
                                </span>
                              </div>
                              <div>
                                <p style={{ margin: 0, fontSize: 14, fontWeight: 600, color: t.text }}>
                                  {player.name}
                                </p>
                                <p style={{ margin: '2px 0 0', fontSize: 11, color: t.muted }}>
                                  {player.throws} throws · {compRate}% comp
                                </p>
                              </div>
                            </div>
                            <div style={{ textAlign: 'right' }}>
                              <p style={{ margin: 0, fontSize: 18, fontWeight: 700, color: t.win }}>
                                {player.goals}
                              </p>
                              <p style={{ margin: '2px 0 0', fontSize: 10, color: t.muted }}>goals</p>
                            </div>
                          </div>
                          <ProgressBar value={player.throws} max={maxThrows} color={t.accent} />
                        </div>
                      );
                    })
                  )}
                </div>

                {/* Caught From */}
                <div style={{
                  background: t.card,
                  border: `1px solid ${t.border}`,
                  borderRadius: 14,
                  overflow: 'hidden',
                  marginBottom: 16,
                }}>
                  <div style={{
                    padding: '12px 14px',
                    background: `${t.cyan}15`,
                    borderBottom: `1px solid ${t.border}`,
                    display: 'flex', alignItems: 'center', gap: 8,
                  }}>
                    <span style={{ fontSize: 16 }}>🙌</span>
                    <span style={{ fontSize: 12, fontWeight: 700, color: t.cyan, textTransform: 'uppercase', letterSpacing: 1 }}>
                      You Caught From
                    </span>
                  </div>
                  
                  {currentConnections.caughtFrom.length === 0 ? (
                    <p style={{ padding: 20, margin: 0, fontSize: 13, color: t.muted, textAlign: 'center' }}>
                      No catching data yet
                    </p>
                  ) : (
                    currentConnections.caughtFrom.slice(0, 5).map((player, i) => {
                      const maxCatches = currentConnections.caughtFrom[0].catches;
                      return (
                        <div
                          key={i}
                          style={{
                            padding: '12px 14px',
                            borderBottom: i < Math.min(currentConnections.caughtFrom.length - 1, 4) ? `1px solid ${t.border}` : 'none',
                          }}
                        >
                          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                            <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                              <div style={{
                                width: 36, height: 36, borderRadius: 8,
                                background: player.team ? `${player.team.color}20` : t.accentMuted,
                                border: `2px solid ${player.team?.color || t.accent}`,
                                display: 'flex', alignItems: 'center', justifyContent: 'center',
                              }}>
                                <span style={{ fontSize: 12, fontWeight: 700, color: player.team?.color || t.text }}>
                                  {player.number}
                                </span>
                              </div>
                              <div>
                                <p style={{ margin: 0, fontSize: 14, fontWeight: 600, color: t.text }}>
                                  {player.name}
                                </p>
                                <p style={{ margin: '2px 0 0', fontSize: 11, color: t.muted }}>
                                  {player.catches} catches · {player.drops} drops
                                </p>
                              </div>
                            </div>
                            <div style={{ textAlign: 'right' }}>
                              <p style={{ margin: 0, fontSize: 18, fontWeight: 700, color: t.win }}>
                                {player.goals}
                              </p>
                              <p style={{ margin: '2px 0 0', fontSize: 10, color: t.muted }}>goals</p>
                            </div>
                          </div>
                          <ProgressBar value={player.catches} max={maxCatches} color={t.cyan} />
                        </div>
                      );
                    })
                  )}
                </div>

                {/* Goal Connections */}
                <div style={{
                  background: t.card,
                  border: `1px solid ${t.border}`,
                  borderRadius: 14,
                  overflow: 'hidden',
                }}>
                  <div style={{
                    padding: '12px 14px',
                    background: `${t.win}15`,
                    borderBottom: `1px solid ${t.border}`,
                    display: 'flex', alignItems: 'center', gap: 8,
                  }}>
                    <span style={{ fontSize: 16 }}>🥅</span>
                    <span style={{ fontSize: 12, fontWeight: 700, color: t.win, textTransform: 'uppercase', letterSpacing: 1 }}>
                      Goal Connections
                    </span>
                  </div>
                  
                  {currentConnections.goalConnections.length === 0 ? (
                    <p style={{ padding: 20, margin: 0, fontSize: 13, color: t.muted, textAlign: 'center' }}>
                      No goal connections yet
                    </p>
                  ) : (
                    currentConnections.goalConnections.slice(0, 6).map((conn, i) => {
                      const throwerText = conn.thrower === 'You' ? 'You' : `#${conn.thrower.number}`;
                      const scorerText = conn.scorer === 'You' ? 'You' : `#${conn.scorer.number}`;
                      
                      return (
                        <div
                          key={i}
                          style={{
                            display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                            padding: '12px 14px',
                            borderBottom: i < Math.min(currentConnections.goalConnections.length - 1, 5) ? `1px solid ${t.border}` : 'none',
                          }}
                        >
                          <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                            <div style={{
                              padding: '4px 8px', borderRadius: 6,
                              background: conn.thrower === 'You' ? t.gradient : t.accentMuted,
                            }}>
                              <span style={{ 
                                fontSize: 12, fontWeight: 700, 
                                color: conn.thrower === 'You' ? '#000' : t.text 
                              }}>
                                {throwerText}
                              </span>
                            </div>
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none">
                              <path d="M5 12H19M19 12L13 6M19 12L13 18" stroke={t.accent} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"/>
                            </svg>
                            <div style={{
                              padding: '4px 8px', borderRadius: 6,
                              background: conn.scorer === 'You' ? `${t.win}` : t.accentMuted,
                            }}>
                              <span style={{ 
                                fontSize: 12, fontWeight: 700, 
                                color: conn.scorer === 'You' ? '#FFF' : t.text 
                              }}>
                                {scorerText}
                              </span>
                            </div>
                          </div>
                          <div style={{
                            padding: '4px 10px', borderRadius: 8,
                            background: `${t.win}20`,
                          }}>
                            <span style={{ fontSize: 14, fontWeight: 700, color: t.win }}>
                              {conn.count}
                            </span>
                          </div>
                        </div>
                      );
                    })
                  )}
                </div>
              </>
            )}

            {/* Defense Tab */}
            {activeTab === 'defense' && (
              <>
                {/* Defensive Plays */}
                <div style={{
                  background: t.card,
                  border: `1px solid ${t.border}`,
                  borderRadius: 14,
                  overflow: 'hidden',
                  marginBottom: 16,
                }}>
                  <div style={{
                    padding: '12px 14px',
                    background: t.accentMuted,
                    borderBottom: `1px solid ${t.border}`,
                  }}>
                    <span style={{ fontSize: 11, fontWeight: 600, color: t.accent, textTransform: 'uppercase', letterSpacing: 1 }}>
                      Defensive Plays
                    </span>
                  </div>
                  
                  {[
                    { label: 'Blocks', value: currentStats.blocks, color: t.blue, icon: '🛡️' },
                    { label: 'Callahans', value: currentStats.callahans, color: t.purple, icon: '⚡' },
                  ].map((stat, i) => (
                    <div
                      key={i}
                      style={{
                        display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                        padding: '14px',
                        borderBottom: i < 1 ? `1px solid ${t.border}` : 'none',
                      }}
                    >
                      <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                        <span style={{ fontSize: 18 }}>{stat.icon}</span>
                        <span style={{ fontSize: 14, color: t.text }}>{stat.label}</span>
                      </div>
                      <span style={{ 
                        fontSize: 24, fontWeight: 700, color: stat.color,
                        textShadow: isDark ? `0 0 20px ${stat.color}40` : 'none',
                      }}>
                        {stat.value}
                      </span>
                    </div>
                  ))}
                </div>

                {/* D-Line Performance */}
                <div style={{
                  background: t.card,
                  border: `1px solid ${t.border}`,
                  borderRadius: 14,
                  overflow: 'hidden',
                  marginBottom: 16,
                }}>
                  <div style={{
                    padding: '12px 14px',
                    background: t.accentMuted,
                    borderBottom: `1px solid ${t.border}`,
                  }}>
                    <span style={{ fontSize: 11, fontWeight: 600, color: t.accent, textTransform: 'uppercase', letterSpacing: 1 }}>
                      D-Line Performance
                    </span>
                  </div>
                  
                  {[
                    { label: 'D-Points Played', value: currentStats.dPoints },
                    { label: 'Breaks', value: currentStats.breaks, color: t.cyan },
                    { label: 'Break %', value: currentStats.dPoints > 0 ? `${Math.round(currentStats.breaks / currentStats.dPoints * 100)}%` : '0%', color: t.cyan },
                  ].map((stat, i) => (
                    <div
                      key={i}
                      style={{
                        display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                        padding: '14px',
                        borderBottom: i < 2 ? `1px solid ${t.border}` : 'none',
                      }}
                    >
                      <span style={{ fontSize: 14, color: t.text }}>{stat.label}</span>
                      <span style={{ fontSize: 20, fontWeight: 700, color: stat.color || t.accent }}>
                        {stat.value}
                      </span>
                    </div>
                  ))}
                </div>

                {/* Pulls */}
                <div style={{
                  background: t.card,
                  border: `1px solid ${t.border}`,
                  borderRadius: 14,
                  overflow: 'hidden',
                }}>
                  <div style={{
                    padding: '12px 14px',
                    background: t.accentMuted,
                    borderBottom: `1px solid ${t.border}`,
                  }}>
                    <span style={{ fontSize: 11, fontWeight: 600, color: t.accent, textTransform: 'uppercase', letterSpacing: 1 }}>
                      Pulls
                    </span>
                  </div>
                  
                  {[
                    { label: 'Pulls Thrown', value: currentStats.pullsThrown },
                    { label: 'Avg Hang Time', value: `${currentStats.pullHangTime.toFixed(1)}s`, color: t.accentLight },
                    { label: 'In Bounds', value: `${pullOBRate}%`, color: t.win },
                    { label: 'Out of Bounds', value: currentStats.pullsOB, color: currentStats.pullsOB > 0 ? t.lose : t.dim },
                  ].map((stat, i) => (
                    <div
                      key={i}
                      style={{
                        display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                        padding: '14px',
                        borderBottom: i < 3 ? `1px solid ${t.border}` : 'none',
                      }}
                    >
                      <span style={{ fontSize: 14, color: t.text }}>{stat.label}</span>
                      <span style={{ fontSize: 20, fontWeight: 700, color: stat.color || t.accent }}>
                        {stat.value}
                      </span>
                    </div>
                  ))}
                </div>
              </>
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
              <NavIcon name={n} active={n === 'stats'} />
              <span style={{ 
                fontSize: 10, fontWeight: n === 'stats' ? 600 : 500, 
                color: n === 'stats' ? t.accent : t.dim, 
                textTransform: 'capitalize',
                textShadow: n === 'stats' && isDark ? '0 0 10px rgba(245,158,11,0.5)' : 'none',
              }}>
                {n}
              </span>
            </div>
          ))}
        </div>
        <div style={{ 
          position: 'absolute', bottom: 8, left: '50%', transform: 'translateX(-50%)', 
          width: 134, height: 5, 
          background: t.gradient, 
          borderRadius: 3, 
          opacity: 0.6,
          boxShadow: '0 0 10px rgba(245,158,11,0.5)',
        }} />
      </div>
      
      <p style={{ textAlign: 'center', marginTop: 24, fontSize: 13, color: t.muted }}>
        <strong style={{ color: t.accent }}>🌅 Golden Hour Stats</strong> · Warm amber glow · Connections tab · Defense tracking
      </p>
    </div>
  );
}
