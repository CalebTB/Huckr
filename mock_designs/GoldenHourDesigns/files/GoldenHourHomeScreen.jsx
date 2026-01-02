import React, { useState } from 'react';

const GoldenHourHomeScreen = () => {
  const [isDarkMode, setIsDarkMode] = useState(true);
  
  const theme = {
    dark: {
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
    },
    light: {
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
    }
  };
  
  const t = isDarkMode ? theme.dark : theme.light;

  return (
    <div className="min-h-screen p-5" style={{ backgroundColor: isDarkMode ? '#0C0A05' : '#FFF9E8', fontFamily: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif' }}>
      {/* Mode Toggle */}
      <div className="flex justify-center gap-3 mb-6">
        <button
          onClick={() => setIsDarkMode(true)}
          className="px-6 py-2.5 rounded-full font-semibold text-sm transition-all"
          style={{
            background: isDarkMode ? t.gradient : 'transparent',
            color: isDarkMode ? '#000000' : '#8A7550',
            boxShadow: isDarkMode ? '0 4px 20px rgba(245,158,11,0.4)' : 'none',
          }}
        >
          Dark Mode
        </button>
        <button
          onClick={() => setIsDarkMode(false)}
          className="px-6 py-2.5 rounded-full font-semibold text-sm transition-all"
          style={{
            background: !isDarkMode ? t.gradient : 'transparent',
            color: !isDarkMode ? '#000000' : '#8A7550',
            boxShadow: !isDarkMode ? '0 4px 20px rgba(245,158,11,0.4)' : 'none',
          }}
        >
          Light Mode
        </button>
      </div>

      {/* Theme Label */}
      <p className="text-center text-sm mb-6 font-bold" style={{ color: t.accent }}>
        🌅 Golden Hour Theme — Warm sunset & amber glow
      </p>

      {/* Phone Frame */}
      <div 
        className="mx-auto relative overflow-hidden"
        style={{
          width: '375px',
          height: '812px',
          backgroundColor: t.bg,
          borderRadius: '44px',
          border: `1px solid ${t.cardBorder}`,
          boxShadow: isDarkMode 
            ? '0 25px 50px -12px rgba(0,0,0,0.8), 0 0 40px rgba(245,158,11,0.15)' 
            : '0 25px 50px -12px rgba(0,0,0,0.15)',
        }}
      >
        {/* Status Bar */}
        <div className="h-11 flex justify-between items-center px-7">
          <span style={{ color: t.text, fontSize: '14px', fontWeight: '600' }}>9:41</span>
          <div className="flex gap-1.5 items-center">
            <svg width="18" height="12" viewBox="0 0 18 12" fill={t.accent}>
              <path d="M1 4.5C1 3.67 1.67 3 2.5 3H3.5C4.33 3 5 3.67 5 4.5V10.5C5 11.33 4.33 12 3.5 12H2.5C1.67 12 1 11.33 1 10.5V4.5Z"/>
              <path d="M6.5 3C6.5 2.17 7.17 1.5 8 1.5H9C9.83 1.5 10.5 2.17 10.5 3V10.5C10.5 11.33 9.83 12 9 12H8C7.17 12 6.5 11.33 6.5 10.5V3Z"/>
              <path d="M12 1.5C12 0.67 12.67 0 13.5 0H14.5C15.33 0 16 0.67 16 1.5V10.5C16 11.33 15.33 12 14.5 12H13.5C12.67 12 12 11.33 12 10.5V1.5Z"/>
            </svg>
            <svg width="17" height="12" viewBox="0 0 17 12" fill={t.accent}>
              <path d="M8.5 2.5C10.5 2.5 12.3 3.3 13.6 4.6L15 3.2C13.3 1.5 11 0.5 8.5 0.5C6 0.5 3.7 1.5 2 3.2L3.4 4.6C4.7 3.3 6.5 2.5 8.5 2.5Z"/>
              <path d="M5.1 6.4L8.5 9.8L11.9 6.4C10.9 5.4 9.7 4.9 8.5 4.9C7.3 4.9 6.1 5.4 5.1 6.4Z"/>
            </svg>
            <svg width="25" height="12" viewBox="0 0 25 12" fill={t.accent}>
              <rect x="0.5" y="0.5" width="21" height="11" rx="2.5" stroke={t.accent} fill="none"/>
              <rect x="2" y="2" width="17" height="8" rx="1" fill={t.accent}/>
              <path d="M23 4V8C23.8 7.7 24.5 6.9 24.5 6C24.5 5.1 23.8 4.3 23 4Z"/>
            </svg>
          </div>
        </div>

        {/* Scrollable Content */}
        <div className="px-6 overflow-y-auto" style={{ height: 'calc(100% - 44px - 83px)' }}>
          {/* Header */}
          <div className="mt-5 mb-8">
            <div className="flex items-center gap-4">
              <div 
                className="w-12 h-12 rounded-xl flex items-center justify-center"
                style={{ 
                  background: t.gradient,
                  boxShadow: '0 4px 20px rgba(245,158,11,0.4)',
                }}
              >
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none">
                  <circle cx="12" cy="12" r="9" stroke="#000000" strokeWidth="2.5"/>
                  <path d="M12 3C12 3 12 12 12 12" stroke="#000000" strokeWidth="2.5"/>
                  <path d="M12 12L19 5" stroke="#000000" strokeWidth="2.5" strokeLinecap="round"/>
                  <path d="M12 12L5 5" stroke="#000000" strokeWidth="2.5" strokeLinecap="round"/>
                </svg>
              </div>
              <div>
                <h1 className="text-2xl font-bold tracking-tight" style={{ color: t.text, margin: 0 }}>
                  Ultimate Hub
                </h1>
                <p className="text-sm" style={{ color: t.textSecondary, margin: 0, letterSpacing: '0.5px' }}>
                  Track · Compete · Win
                </p>
              </div>
            </div>
          </div>

          {/* Quick Actions Label */}
          <p className="text-xs font-semibold uppercase tracking-wider mb-4" style={{ color: t.textSecondary, letterSpacing: '1.5px' }}>
            Quick Actions
          </p>

          {/* Start New Game - Primary */}
          <div 
            className="rounded-2xl p-5 mb-3 cursor-pointer hover:scale-[1.02] transition-transform"
            style={{ 
              background: t.gradient,
              boxShadow: '0 4px 20px rgba(245,158,11,0.4)',
            }}
          >
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-4">
                <div 
                  className="w-12 h-12 rounded-xl flex items-center justify-center"
                  style={{ backgroundColor: 'rgba(0,0,0,0.2)' }}
                >
                  <svg width="24" height="24" viewBox="0 0 24 24" fill="#000000">
                    <path d="M8 5V19L19 12L8 5Z"/>
                  </svg>
                </div>
                <div>
                  <h3 className="font-semibold" style={{ color: '#000000', fontSize: '17px', margin: 0 }}>
                    Start New Game
                  </h3>
                  <p className="text-sm mt-1" style={{ color: 'rgba(0,0,0,0.6)', margin: 0 }}>
                    Track live stats on the field
                  </p>
                </div>
              </div>
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                <path d="M9 18L15 12L9 6" stroke="#000000" strokeWidth="2" strokeLinecap="round"/>
              </svg>
            </div>
          </div>

          {/* Secondary Actions Grid */}
          <div className="grid grid-cols-2 gap-3 mb-8">
            <div 
              className="rounded-2xl p-4 cursor-pointer hover:opacity-90 transition-opacity"
              style={{ backgroundColor: t.card, border: `1px solid ${t.cardBorder}` }}
            >
              <div 
                className="w-10 h-10 rounded-xl flex items-center justify-center mb-3"
                style={{ backgroundColor: t.accentMuted }}
              >
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                  <path d="M17 21V19C17 16.79 15.21 15 13 15H5C2.79 15 1 16.79 1 19V21" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                  <circle cx="9" cy="7" r="4" stroke={t.accent} strokeWidth="2"/>
                  <path d="M23 21V19C22.99 17.18 21.77 15.59 20 15.13" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                  <path d="M16 3.13C17.76 3.6 18.99 5.18 19 7C18.99 8.82 17.76 10.4 16 10.87" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                </svg>
              </div>
              <h3 className="font-semibold" style={{ color: t.text, fontSize: '15px', margin: 0 }}>My Teams</h3>
              <p className="text-xs mt-1" style={{ color: t.textSecondary, margin: 0 }}>2 teams</p>
            </div>
            
            <div 
              className="rounded-2xl p-4 cursor-pointer hover:opacity-90 transition-opacity"
              style={{ backgroundColor: t.card, border: `1px solid ${t.cardBorder}` }}
            >
              <div 
                className="w-10 h-10 rounded-xl flex items-center justify-center mb-3"
                style={{ backgroundColor: t.accentMuted }}
              >
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                  <path d="M12 15C15.866 15 19 11.866 19 8V2H5V8C5 11.866 8.134 15 12 15Z" stroke={t.accent} strokeWidth="2"/>
                  <path d="M5 2H2V5C2 6.657 3.343 8 5 8" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                  <path d="M19 2H22V5C22 6.657 20.657 8 19 8" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                  <path d="M12 15V18M8 22H16M12 18V22" stroke={t.accent} strokeWidth="2" strokeLinecap="round"/>
                </svg>
              </div>
              <h3 className="font-semibold" style={{ color: t.text, fontSize: '15px', margin: 0 }}>Tournaments</h3>
              <p className="text-xs mt-1" style={{ color: t.textSecondary, margin: 0 }}>Browse events</p>
            </div>
          </div>

          {/* Recent Games */}
          <div className="flex justify-between items-center mb-4">
            <p className="text-xs font-semibold uppercase tracking-wider" style={{ color: t.textSecondary, margin: 0, letterSpacing: '1.5px' }}>
              Recent Games
            </p>
            <button className="text-sm font-medium" style={{ color: t.accent, background: 'none', border: 'none' }}>
              View All
            </button>
          </div>

          {/* Game Card 1 - Win */}
          <div 
            className="rounded-2xl p-4 mb-3"
            style={{ 
              backgroundColor: t.card, 
              border: `1px solid ${t.cardBorder}`,
              boxShadow: isDarkMode ? '0 0 20px rgba(34,197,94,0.1)' : 'none',
            }}
          >
            <div className="flex justify-between items-center mb-3">
              <span className="text-xs uppercase tracking-wide" style={{ color: t.textTertiary }}>
                Dec 27 · Pool Play
              </span>
              <span 
                className="text-xs font-semibold px-2 py-1 rounded-md"
                style={{ color: t.success, backgroundColor: `${t.success}15` }}
              >
                W
              </span>
            </div>
            <div className="flex justify-between items-center">
              <div className="flex-1">
                <p className="font-semibold" style={{ color: t.text, fontSize: '15px', margin: 0 }}>Ring of Fire</p>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-2xl font-bold tabular-nums" style={{ color: t.accent }}>15</span>
                <span style={{ color: t.textTertiary }}>-</span>
                <span className="text-2xl font-bold tabular-nums" style={{ color: t.textSecondary }}>11</span>
              </div>
              <div className="flex-1 text-right">
                <p className="font-medium" style={{ color: t.textSecondary, fontSize: '15px', margin: 0 }}>Truck Stop</p>
              </div>
            </div>
          </div>

          {/* Game Card 2 - Loss */}
          <div 
            className="rounded-2xl p-4 mb-6"
            style={{ backgroundColor: t.card, border: `1px solid ${t.cardBorder}` }}
          >
            <div className="flex justify-between items-center mb-3">
              <span className="text-xs uppercase tracking-wide" style={{ color: t.textTertiary }}>
                Dec 26 · Scrimmage
              </span>
              <span 
                className="text-xs font-semibold px-2 py-1 rounded-md"
                style={{ color: t.error, backgroundColor: `${t.error}15` }}
              >
                L
              </span>
            </div>
            <div className="flex justify-between items-center">
              <div className="flex-1">
                <p className="font-semibold" style={{ color: t.text, fontSize: '15px', margin: 0 }}>Ring of Fire</p>
              </div>
              <div className="flex items-center gap-2">
                <span className="text-2xl font-bold tabular-nums" style={{ color: t.textSecondary }}>12</span>
                <span style={{ color: t.textTertiary }}>-</span>
                <span className="text-2xl font-bold tabular-nums" style={{ color: t.text }}>15</span>
              </div>
              <div className="flex-1 text-right">
                <p className="font-medium" style={{ color: t.textSecondary, fontSize: '15px', margin: 0 }}>PoNY</p>
              </div>
            </div>
          </div>

          {/* Season Stats */}
          <p className="text-xs font-semibold uppercase tracking-wider mb-4" style={{ color: t.textSecondary, letterSpacing: '1.5px' }}>
            Season Stats
          </p>
          <div className="grid grid-cols-4 gap-2 mb-6">
            {[
              { label: 'Games', value: '12' },
              { label: 'Goals', value: '24' },
              { label: 'Assists', value: '31' },
              { label: 'Ds', value: '18' },
            ].map((stat, i) => (
              <div 
                key={i}
                className="rounded-xl p-3 text-center"
                style={{ backgroundColor: t.card, border: `1px solid ${t.cardBorder}` }}
              >
                <p className="text-xl font-bold tabular-nums" style={{ color: t.accent, margin: 0 }}>{stat.value}</p>
                <p className="text-xs mt-1" style={{ color: t.textSecondary, margin: 0 }}>{stat.label}</p>
              </div>
            ))}
          </div>
        </div>

        {/* Bottom Navigation */}
        <div 
          className="absolute bottom-0 left-0 right-0 flex justify-around items-start pt-3"
          style={{ height: '83px', backgroundColor: t.bg, borderTop: `1px solid ${t.cardBorder}` }}
        >
          {[
            { label: 'Home', active: true },
            { label: 'Games', active: false },
            { label: 'Teams', active: false },
            { label: 'Stats', active: false },
            { label: 'Profile', active: false },
          ].map((item, i) => (
            <div key={i} className="flex flex-col items-center gap-1 cursor-pointer">
              <div className="w-6 h-6 flex items-center justify-center">
                {item.label === 'Home' && (
                  <svg width="22" height="22" viewBox="0 0 24 24" fill={item.active ? t.accent : 'none'}>
                    <path d="M3 9L12 2L21 9V20C21 21.1 20.1 22 19 22H5C3.9 22 3 21.1 3 20V9Z" stroke={item.active ? t.accent : t.textTertiary} strokeWidth="2"/>
                  </svg>
                )}
                {item.label === 'Games' && (
                  <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
                    <circle cx="12" cy="12" r="10" stroke={t.textTertiary} strokeWidth="2"/>
                    <path d="M12 8V12L15 15" stroke={t.textTertiary} strokeWidth="2" strokeLinecap="round"/>
                  </svg>
                )}
                {item.label === 'Teams' && (
                  <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
                    <path d="M17 21V19C17 16.79 15.21 15 13 15H5C2.79 15 1 16.79 1 19V21" stroke={t.textTertiary} strokeWidth="2" strokeLinecap="round"/>
                    <circle cx="9" cy="7" r="4" stroke={t.textTertiary} strokeWidth="2"/>
                  </svg>
                )}
                {item.label === 'Stats' && (
                  <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
                    <path d="M18 20V10M12 20V4M6 20V14" stroke={t.textTertiary} strokeWidth="2" strokeLinecap="round"/>
                  </svg>
                )}
                {item.label === 'Profile' && (
                  <svg width="22" height="22" viewBox="0 0 24 24" fill="none">
                    <circle cx="12" cy="8" r="4" stroke={t.textTertiary} strokeWidth="2"/>
                    <path d="M20 21C20 16.58 16.42 13 12 13C7.58 13 4 16.58 4 21" stroke={t.textTertiary} strokeWidth="2" strokeLinecap="round"/>
                  </svg>
                )}
              </div>
              <span 
                className="text-xs"
                style={{ color: item.active ? t.accent : t.textTertiary, fontWeight: item.active ? '600' : '500' }}
              >
                {item.label}
              </span>
            </div>
          ))}
        </div>

        {/* Home Indicator */}
        <div 
          className="absolute bottom-2 left-1/2 -translate-x-1/2 w-32 h-1 rounded-full"
          style={{ background: t.gradient, opacity: 0.6 }}
        />
      </div>

      {/* Design Notes */}
      <p className="text-center text-sm mt-8" style={{ color: '#8A7550' }}>
        <strong style={{ color: '#C4A878' }}>Golden Hour Theme</strong> · Warm Amber · Sunset Glow · Premium Feel
      </p>
    </div>
  );
};

export default GoldenHourHomeScreen;
