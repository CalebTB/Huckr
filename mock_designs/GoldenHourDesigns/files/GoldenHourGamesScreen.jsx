import React, { useState } from 'react';

export default function GoldenHourGamesScreen() {
  const [isDark, setIsDark] = useState(true);
  const [activeFilter, setActiveFilter] = useState('all');
  
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
    live: '#EF4444',
    upcoming: '#F59E0B',
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
    live: '#EF4444',
    upcoming: '#D97706',
  };

  const games = [
    { id: 1, status: 'live', date: 'NOW', type: 'Pool Play', home: 'Ring of Fire', away: 'Sockeye', hs: 8, as: 7, isTracking: true },
    { id: 2, status: 'upcoming', date: 'Today 3:00 PM', type: 'Pool Play', home: 'Ring of Fire', away: 'Rhino Slam', hs: null, as: null },
    { id: 3, status: 'upcoming', date: 'Tomorrow 9:00 AM', type: 'Bracket', home: 'Ring of Fire', away: 'TBD', hs: null, as: null },
    { id: 4, status: 'completed', date: 'Dec 27', type: 'Pool Play', home: 'Ring of Fire', away: 'Truck Stop', hs: 15, as: 11, win: true },
    { id: 5, status: 'completed', date: 'Dec 26', type: 'Scrimmage', home: 'Ring of Fire', away: 'PoNY', hs: 12, as: 15, win: false },
    { id: 6, status: 'completed', date: 'Dec 20', type: 'League', home: 'Ring of Fire', away: 'Chain Lightning', hs: 15, as: 13, win: true },
    { id: 7, status: 'completed', date: 'Dec 18', type: 'Scrimmage', home: 'Ring of Fire', away: 'Johnny Bravo', hs: 11, as: 15, win: false },
  ];

  const filteredGames = activeFilter === 'all' 
    ? games 
    : games.filter(g => g.status === activeFilter);

  const filters = [
    { key: 'all', label: 'All' },
    { key: 'live', label: 'Live', count: games.filter(g => g.status === 'live').length },
    { key: 'upcoming', label: 'Upcoming', count: games.filter(g => g.status === 'upcoming').length },
    { key: 'completed', label: 'Completed', count: games.filter(g => g.status === 'completed').length },
  ];

  const NavIcon = ({ name, active }) => {
    const color = active ? t.accent : t.textTertiary;
    const icons = {
      home: <path d="M3 9L12 2L21 9V20C21 21.1 20.1 22 19 22H5C3.9 22 3 21.1 3 20V9Z" stroke={color} strokeWidth="2" fill="none"/>,
      games: <><circle cx="12" cy="12" r="10" stroke={color} strokeWidth="2" fill={active ? color : 'none'}/><path d="M12 8V12L15 15" stroke={active ? t.bg : color} strokeWidth="2" strokeLinecap="round"/></>,
      teams: <><path d="M17 21V19C17 16.79 15.21 15 13 15H5C2.79 15 1 16.79 1 19V21" stroke={color} strokeWidth="2"/><circle cx="9" cy="7" r="4" stroke={color} strokeWidth="2" fill="none"/></>,
      stats: <path d="M18 20V10M12 20V4M6 20V14" stroke={color} strokeWidth="2" strokeLinecap="round"/>,
      profile: <><circle cx="12" cy="8" r="4" stroke={color} strokeWidth="2" fill="none"/><path d="M20 21C20 16.58 16.42 13 12 13C7.58 13 4 16.58 4 21" stroke={color} strokeWidth="2"/></>,
    };
    return <svg width="22" height="22" viewBox="0 0 24 24" fill="none">{icons[name]}</svg>;
  };

  return (
    <div style={{ minHeight: '100vh', background: isDark ? '#0C0A05' : '#FFF9E8', padding: 20, fontFamily: 'system-ui, -apple-system, sans-serif' }}>
      {/* Toggle */}
      <div style={{ display: 'flex', justifyContent: 'center', gap: 8, marginBottom: 16 }}>
        {['Dark', 'Light'].map(mode => (
          <button key={mode} onClick={() => setIsDark(mode === 'Dark')}
            style={{ padding: '10px 24px', borderRadius: 100, border: 'none', cursor: 'pointer',
              background: (mode === 'Dark' ? isDark : !isDark) ? t.gradient : 'transparent',
              color: (mode === 'Dark' ? isDark : !isDark) ? '#000' : '#8A7550',
              fontWeight: 600, fontSize: 14,
              boxShadow: (mode === 'Dark' ? isDark : !isDark) ? '0 4px 20px rgba(245,158,11,0.4)' : 'none',
            }}>
            {mode}
          </button>
        ))}
      </div>

      <p style={{ textAlign: 'center', color: t.accent, fontWeight: 600, marginBottom: 24, fontSize: 14 }}>
        🌅 Golden Hour Theme — Games Screen
      </p>

      {/* Phone */}
      <div style={{ width: 375, height: 812, margin: '0 auto', background: t.bg, borderRadius: 44, 
        border: `1px solid ${t.cardBorder}`, overflow: 'hidden', position: 'relative',
        boxShadow: isDark ? '0 25px 50px -12px rgba(0,0,0,0.8), 0 0 40px rgba(245,158,11,0.15)' : '0 25px 50px -12px rgba(0,0,0,0.15)' }}>
        
        {/* Status Bar */}
        <div style={{ height: 44, display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '0 28px' }}>
          <span style={{ color: t.text, fontSize: 14, fontWeight: 600 }}>9:41</span>
          <div style={{ display: 'flex', gap: 6 }}>
            <svg width="18" height="12" fill={t.accent}><rect x="0" y="3" width="4" height="9" rx="1"/><rect x="5" y="1.5" width="4" height="10.5" rx="1"/><rect x="10" y="0" width="4" height="12" rx="1"/></svg>
            <svg width="16" height="12" fill={t.accent}><path d="M8 2C10 2 11.8 2.8 13 4L14.5 2.5C12.8 0.8 10.5 0 8 0C5.5 0 3.2 0.8 1.5 2.5L3 4C4.2 2.8 6 2 8 2ZM5 6.5L8 10L11 6.5C10 5.5 9 5 8 5C7 5 6 5.5 5 6.5Z"/></svg>
            <svg width="25" height="12" fill={t.accent}><rect x="0" y="0" width="22" height="12" rx="3" fill="none" stroke={t.accent}/><rect x="2" y="2" width="17" height="8" rx="1.5"/><path d="M23 4V8C24 7.5 24.5 6.8 24.5 6C24.5 5.2 24 4.5 23 4Z"/></svg>
          </div>
        </div>

        {/* Content */}
        <div style={{ height: 'calc(100% - 127px)', overflowY: 'auto' }}>
          {/* Header */}
          <div style={{ padding: '16px 24px 0' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 20 }}>
              <h1 style={{ margin: 0, fontSize: 28, fontWeight: 700, color: t.text, letterSpacing: -0.5 }}>Games</h1>
              <button style={{ 
                width: 40, height: 40, borderRadius: 12, border: `1px solid ${t.cardBorder}`,
                background: t.card, display: 'flex', alignItems: 'center', justifyContent: 'center', cursor: 'pointer'
              }}>
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                  <path d="M12 5V19M5 12H19" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                </svg>
              </button>
            </div>

            {/* Filter Pills */}
            <div style={{ display: 'flex', gap: 8, marginBottom: 20, overflowX: 'auto', paddingBottom: 4 }}>
              {filters.map(f => (
                <button
                  key={f.key}
                  onClick={() => setActiveFilter(f.key)}
                  style={{
                    padding: '8px 16px',
                    borderRadius: 100,
                    border: activeFilter === f.key ? 'none' : `1px solid ${t.cardBorder}`,
                    background: activeFilter === f.key ? t.gradient : 'transparent',
                    color: activeFilter === f.key ? '#000' : t.textSecondary,
                    fontWeight: 600,
                    fontSize: 13,
                    cursor: 'pointer',
                    display: 'flex',
                    alignItems: 'center',
                    gap: 6,
                    whiteSpace: 'nowrap',
                    boxShadow: activeFilter === f.key ? '0 4px 15px rgba(245,158,11,0.3)' : 'none',
                  }}
                >
                  {f.label}
                  {f.count > 0 && (
                    <span style={{
                      background: activeFilter === f.key ? 'rgba(0,0,0,0.2)' : (f.key === 'live' ? t.live : t.accentMuted),
                      color: activeFilter === f.key ? '#000' : (f.key === 'live' ? '#FFF' : t.textSecondary),
                      padding: '2px 6px',
                      borderRadius: 10,
                      fontSize: 11,
                      fontWeight: 700,
                    }}>
                      {f.count}
                    </span>
                  )}
                </button>
              ))}
            </div>
          </div>

          {/* Games List */}
          <div style={{ padding: '0 24px' }}>
            {filteredGames.map((game, index) => (
              <div key={game.id}>
                {/* Section Header */}
                {(index === 0 || filteredGames[index - 1].status !== game.status) && activeFilter === 'all' && (
                  <p style={{ 
                    fontSize: 11, fontWeight: 600, color: t.textSecondary, 
                    textTransform: 'uppercase', letterSpacing: 1.5, 
                    margin: index === 0 ? '0 0 12px' : '20px 0 12px'
                  }}>
                    {game.status === 'live' ? '🔴 Live Now' : game.status === 'upcoming' ? 'Upcoming' : 'Completed'}
                  </p>
                )}

                {/* Game Card */}
                <div style={{ 
                  background: t.card, 
                  border: `1px solid ${game.status === 'live' ? `${t.live}40` : t.cardBorder}`,
                  borderRadius: 16, 
                  padding: 16, 
                  marginBottom: 10,
                  cursor: 'pointer',
                  position: 'relative',
                  overflow: 'hidden',
                  boxShadow: game.status === 'live' ? '0 0 20px rgba(239,68,68,0.15)' : 'none',
                }}>
                  {/* Live indicator bar */}
                  {game.status === 'live' && (
                    <div style={{
                      position: 'absolute',
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 3,
                      background: `linear-gradient(90deg, ${t.live}, ${t.live}80)`,
                    }} />
                  )}

                  {/* Top row */}
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                      {game.status === 'live' && (
                        <span style={{
                          display: 'flex', alignItems: 'center', gap: 4,
                          fontSize: 10, fontWeight: 700, color: t.live,
                          background: `${t.live}18`, padding: '3px 8px', borderRadius: 5,
                        }}>
                          <span style={{ width: 6, height: 6, borderRadius: '50%', background: t.live, animation: 'pulse 1.5s infinite' }} />
                          LIVE
                        </span>
                      )}
                      <span style={{ fontSize: 10, color: t.textTertiary, textTransform: 'uppercase', letterSpacing: 0.5 }}>
                        {game.date} · {game.type}
                      </span>
                    </div>
                    
                    {game.status === 'completed' && (
                      <span style={{ 
                        fontSize: 10, fontWeight: 600, 
                        color: game.win ? t.success : t.error, 
                        background: game.win ? `${t.success}18` : `${t.error}18`, 
                        padding: '3px 8px', borderRadius: 5 
                      }}>
                        {game.win ? 'W' : 'L'}
                      </span>
                    )}

                    {game.status === 'upcoming' && (
                      <span style={{ 
                        fontSize: 10, fontWeight: 600, color: t.accent,
                        background: t.accentMuted, padding: '3px 8px', borderRadius: 5 
                      }}>
                        SCHEDULED
                      </span>
                    )}
                  </div>

                  {/* Teams and Score */}
                  <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                    <div style={{ flex: 1 }}>
                      <p style={{ margin: 0, fontSize: 15, fontWeight: 600, color: t.text }}>{game.home}</p>
                      {game.isTracking && (
                        <span style={{ fontSize: 10, color: t.accent }}>You're tracking</span>
                      )}
                    </div>
                    
                    {game.hs !== null ? (
                      <div style={{ display: 'flex', alignItems: 'center', gap: 8, padding: '0 16px' }}>
                        <span style={{ 
                          fontSize: 24, fontWeight: 700, 
                          color: game.status === 'completed' ? (game.win ? t.accent : t.textSecondary) : t.accent,
                          fontVariantNumeric: 'tabular-nums' 
                        }}>
                          {game.hs}
                        </span>
                        <span style={{ color: t.textTertiary, fontSize: 16 }}>-</span>
                        <span style={{ 
                          fontSize: 24, fontWeight: 700, 
                          color: game.status === 'completed' ? (game.win ? t.textSecondary : t.text) : t.text,
                          fontVariantNumeric: 'tabular-nums' 
                        }}>
                          {game.as}
                        </span>
                      </div>
                    ) : (
                      <div style={{ padding: '8px 16px', fontSize: 14, color: t.textTertiary }}>
                        vs
                      </div>
                    )}
                    
                    <div style={{ flex: 1, textAlign: 'right' }}>
                      <p style={{ margin: 0, fontSize: 15, fontWeight: 500, color: t.textSecondary }}>{game.away}</p>
                    </div>
                  </div>

                  {/* Live game actions */}
                  {game.status === 'live' && (
                    <div style={{ 
                      display: 'flex', gap: 8, marginTop: 14, paddingTop: 14,
                      borderTop: `1px solid ${t.cardBorder}`
                    }}>
                      <button style={{
                        flex: 1, padding: '10px 16px', borderRadius: 10,
                        border: 'none', background: t.gradient, color: '#000',
                        fontWeight: 600, fontSize: 13, cursor: 'pointer',
                        display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 6,
                        boxShadow: '0 4px 15px rgba(245,158,11,0.3)',
                      }}>
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="#000">
                          <path d="M8 5V19L19 12L8 5Z"/>
                        </svg>
                        Continue Tracking
                      </button>
                      <button style={{
                        padding: '10px 16px', borderRadius: 10,
                        border: `1px solid ${t.cardBorder}`, background: 'transparent',
                        fontWeight: 600, fontSize: 13, cursor: 'pointer', color: t.textSecondary
                      }}>
                        View
                      </button>
                    </div>
                  )}

                  {/* Upcoming game actions */}
                  {game.status === 'upcoming' && (
                    <div style={{ 
                      display: 'flex', gap: 8, marginTop: 14, paddingTop: 14,
                      borderTop: `1px solid ${t.cardBorder}`
                    }}>
                      <button style={{
                        flex: 1, padding: '10px 16px', borderRadius: 10,
                        border: 'none', background: t.gradient, color: '#000',
                        fontWeight: 600, fontSize: 13, cursor: 'pointer',
                        boxShadow: '0 4px 15px rgba(245,158,11,0.3)',
                      }}>
                        Start Tracking
                      </button>
                      <button style={{
                        padding: '10px 16px', borderRadius: 10,
                        border: `1px solid ${t.cardBorder}`, background: 'transparent',
                        fontWeight: 600, fontSize: 13, cursor: 'pointer', color: t.textSecondary
                      }}>
                        Edit
                      </button>
                    </div>
                  )}
                </div>
              </div>
            ))}

            {/* Stats Summary */}
            {activeFilter === 'completed' && filteredGames.length > 0 && (
              <div style={{ 
                background: t.card, border: `1px solid ${t.cardBorder}`,
                borderRadius: 16, padding: 16, marginTop: 8, marginBottom: 20
              }}>
                <p style={{ margin: '0 0 12px', fontSize: 11, fontWeight: 600, color: t.textSecondary, textTransform: 'uppercase', letterSpacing: 1.5 }}>
                  Season Record
                </p>
                <div style={{ display: 'flex', justifyContent: 'space-around', textAlign: 'center' }}>
                  <div>
                    <p style={{ margin: 0, fontSize: 28, fontWeight: 700, color: t.success }}>{games.filter(g => g.win).length}</p>
                    <p style={{ margin: '2px 0 0', fontSize: 12, color: t.textSecondary }}>Wins</p>
                  </div>
                  <div style={{ width: 1, background: t.cardBorder }} />
                  <div>
                    <p style={{ margin: 0, fontSize: 28, fontWeight: 700, color: t.error }}>{games.filter(g => g.win === false).length}</p>
                    <p style={{ margin: '2px 0 0', fontSize: 12, color: t.textSecondary }}>Losses</p>
                  </div>
                  <div style={{ width: 1, background: t.cardBorder }} />
                  <div>
                    <p style={{ margin: 0, fontSize: 28, fontWeight: 700, color: t.accent }}>
                      {Math.round((games.filter(g => g.win).length / games.filter(g => g.status === 'completed').length) * 100)}%
                    </p>
                    <p style={{ margin: '2px 0 0', fontSize: 12, color: t.textSecondary }}>Win Rate</p>
                  </div>
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
              <NavIcon name={n} active={n === 'games'} />
              <span style={{ fontSize: 10, fontWeight: n === 'games' ? 600 : 500, color: n === 'games' ? t.accent : t.textTertiary, textTransform: 'capitalize' }}>{n}</span>
            </div>
          ))}
        </div>
        <div style={{ position: 'absolute', bottom: 8, left: '50%', transform: 'translateX(-50%)', width: 134, height: 5, background: t.gradient, borderRadius: 3, opacity: 0.6 }} />
      </div>
      
      <p style={{ textAlign: 'center', marginTop: 24, fontSize: 13, color: '#8A7550' }}>
        <strong style={{ color: '#C4A878' }}>Golden Hour</strong> · Games Screen · Warm Amber Accents
      </p>

      <style>{`
        @keyframes pulse {
          0%, 100% { opacity: 1; }
          50% { opacity: 0.5; }
        }
      `}</style>
    </div>
  );
}
