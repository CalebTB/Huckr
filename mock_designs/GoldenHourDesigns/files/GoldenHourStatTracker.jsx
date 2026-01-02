import React, { useState, useEffect } from 'react';

export default function GoldenHourStatTracker() {
  const [isDark, setIsDark] = useState(true);
  const [homeScore, setHomeScore] = useState(8);
  const [awayScore, setAwayScore] = useState(7);
  const [isOffense, setIsOffense] = useState(true);
  const [discHolder, setDiscHolder] = useState(null);
  const [gameTime] = useState('42:18');
  const [lastPlay, setLastPlay] = useState(null);
  const [playLog, setPlayLog] = useState([]);
  const [defensePhase, setDefensePhase] = useState('pre-pull');
  const [pullPlayer, setPullPlayer] = useState(null);
  const [pullTime, setPullTime] = useState(0);
  const [selectedDefender, setSelectedDefender] = useState(null);
  
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
    orange: '#F59E0B',
    blue: '#60A5FA',
    purple: '#A855F7',
    yellow: '#FBBF24',
    foul: '#F59E0B',
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
    orange: '#D97706',
    blue: '#3B82F6',
    purple: '#9333EA',
    yellow: '#EAB308',
    foul: '#D97706',
  };

  const players = [
    { id: 1, number: '7', name: 'Smith' },
    { id: 2, number: '23', name: 'Johnson' },
    { id: 3, number: '11', name: 'Williams' },
    { id: 4, number: '5', name: 'Davis' },
    { id: 5, number: '8', name: 'Miller' },
    { id: 6, number: '15', name: 'Wilson' },
    { id: 7, number: '3', name: 'Moore' },
  ];

  useEffect(() => {
    let interval;
    if (defensePhase === 'pulling') {
      interval = setInterval(() => {
        setPullTime(prev => prev + 0.1);
      }, 100);
    }
    return () => clearInterval(interval);
  }, [defensePhase]);

  const logPlay = (play) => {
    setPlayLog(prev => [{ ...play, id: Date.now(), time: gameTime }, ...prev]);
    setLastPlay({ ...play, time: gameTime });
  };

  const handlePlayerTap = (player) => {
    if (defensePhase === 'pulling') return;
    
    if (isOffense) {
      if (!discHolder) {
        setDiscHolder(player);
        logPlay({ type: 'pickup', player: player, text: `#${player.number} picks up` });
      } else if (discHolder.id === player.id) {
        setDiscHolder(null);
      } else {
        logPlay({ 
          type: 'catch', 
          thrower: discHolder, 
          receiver: player,
          text: `#${discHolder.number} → #${player.number}`,
          isCompletion: true,
        });
        setDiscHolder(player);
      }
    } else {
      if (defensePhase === 'pre-pull') {
        if (pullPlayer?.id === player.id) {
          setPullPlayer(null);
        } else {
          setPullPlayer(player);
        }
      } else if (defensePhase === 'watching') {
        if (selectedDefender?.id === player.id) {
          setSelectedDefender(null);
        } else {
          setSelectedDefender(player);
        }
      }
    }
  };

  const handleGoal = () => {
    if (discHolder) {
      logPlay({ 
        type: 'goal', 
        player: discHolder, 
        text: `★ GOAL #${discHolder.number}`,
        isGoal: true,
      });
      setHomeScore(homeScore + 1);
      setDiscHolder(null);
      setIsOffense(false);
      setDefensePhase('pre-pull');
      setPullPlayer(null);
      setSelectedDefender(null);
    }
  };

  const handleTurnover = (type) => {
    if (discHolder) {
      logPlay({ 
        type: 'turnover', 
        turnoverType: type,
        player: discHolder, 
        text: `✕ ${type} #${discHolder.number}`,
        isTurnover: true,
      });
    } else {
      logPlay({ type: 'turnover', turnoverType: type, text: `✕ ${type}`, isTurnover: true });
    }
    setDiscHolder(null);
    setIsOffense(false);
    setDefensePhase('watching');
    setPullPlayer(null);
    setSelectedDefender(null);
  };

  const handlePull = () => {
    if (pullPlayer) {
      setDefensePhase('pulling');
      setPullTime(0);
      logPlay({ type: 'pull-start', player: pullPlayer, text: `#${pullPlayer.number} pulling...`, isPull: true });
    }
  };

  const handlePullResult = (result) => {
    logPlay({ 
      type: 'pull-end', 
      player: pullPlayer, 
      text: `Pull ${result} (${pullTime.toFixed(1)}s)`,
      isPull: true,
      hangTime: pullTime,
    });
    setDefensePhase('watching');
    setPullPlayer(null);
    setPullTime(0);
  };

  const handleDefensivePlay = (type) => {
    const playerNum = selectedDefender ? `#${selectedDefender.number}` : '';
    
    if (type === 'block') {
      logPlay({ type: 'block', text: `⊘ BLOCK ${playerNum}`, isBlock: true });
    } else if (type === 'turnover') {
      logPlay({ type: 'opp-turnover', text: '✕ Opponent turnover', isBlock: true });
    } else if (type === 'stall') {
      logPlay({ type: 'opp-stall', text: '✕ Stall out', isBlock: true });
    }
    setIsOffense(true);
    setDefensePhase('pre-pull');
    setPullPlayer(null);
    setSelectedDefender(null);
  };

  const handleOpponentScore = () => {
    setAwayScore(awayScore + 1);
    logPlay({ type: 'opp-goal', text: '✕ Opponent scores', isOppGoal: true });
    setIsOffense(true);
    setDiscHolder(null);
    setDefensePhase('pre-pull');
    setPullPlayer(null);
    setSelectedDefender(null);
  };

  const undo = () => {
    if (playLog.length > 0) {
      const lastEntry = playLog[0];
      setPlayLog(prev => prev.slice(1));
      if (lastEntry.isGoal) setHomeScore(homeScore - 1);
      if (lastEntry.isOppGoal) setAwayScore(awayScore - 1);
      if (lastEntry.type === 'pull-start') {
        setDefensePhase('pre-pull');
        setPullTime(0);
      }
      if (lastEntry.type === 'pull-end') {
        setDefensePhase('pre-pull');
      }
    }
  };

  const selectedPlayer = isOffense ? discHolder : (defensePhase === 'pre-pull' ? pullPlayer : selectedDefender);
  const selectedColor = t.accent;

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
        🌅 Golden Hour Theme — Stat Tracker
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
            <svg width="25" height="12" fill={t.accent}><rect x="0" y="0" width="22" height="12" rx="3" fill="none" stroke={t.accent}/><rect x="2" y="2" width="17" height="8" rx="1.5"/></svg>
          </div>
        </div>

        {/* Score Bar */}
        <div style={{ 
          margin: '0 16px 8px', padding: '10px 16px',
          background: t.card, border: `1px solid ${t.cardBorder}`, borderRadius: 14,
          display: 'flex', justifyContent: 'space-between', alignItems: 'center',
        }}>
          <div style={{ textAlign: 'center' }}>
            <p style={{ margin: 0, fontSize: 11, color: t.textSecondary }}>ROF</p>
            <p style={{ margin: 0, fontSize: 28, fontWeight: 700, color: t.accent }}>{homeScore}</p>
          </div>
          <div style={{ textAlign: 'center' }}>
            <p style={{ margin: 0, fontSize: 11, color: t.textSecondary }}>{gameTime}</p>
            <div style={{ display: 'flex', alignItems: 'center', gap: 4, marginTop: 2 }}>
              <span style={{ width: 6, height: 6, borderRadius: '50%', background: t.error, animation: 'pulse 1.5s infinite' }} />
              <span style={{ fontSize: 10, fontWeight: 600, color: t.error }}>LIVE</span>
            </div>
          </div>
          <div style={{ textAlign: 'center' }}>
            <p style={{ margin: 0, fontSize: 11, color: t.textSecondary }}>SOC</p>
            <p style={{ margin: 0, fontSize: 28, fontWeight: 700, color: t.text }}>{awayScore}</p>
          </div>
        </div>

        {/* Offense/Defense Toggle */}
        <div style={{ 
          display: 'flex', margin: '0 16px 10px', 
          background: t.card, borderRadius: 12, padding: 4,
          border: `1px solid ${t.cardBorder}`,
        }}>
          <button 
            onClick={() => { setIsOffense(true); setDiscHolder(null); setPullPlayer(null); setSelectedDefender(null); setDefensePhase('pre-pull'); }}
            style={{
              flex: 1, padding: '12px', borderRadius: 10, border: 'none',
              background: isOffense ? t.gradient : 'transparent',
              color: isOffense ? '#000' : t.textSecondary,
              fontWeight: 700, fontSize: 14, cursor: 'pointer',
              boxShadow: isOffense ? '0 4px 15px rgba(245,158,11,0.3)' : 'none',
            }}
          >
            ⬆ OFFENSE
          </button>
          <button 
            onClick={() => { setIsOffense(false); setDiscHolder(null); setPullPlayer(null); setSelectedDefender(null); setDefensePhase('watching'); }}
            style={{
              flex: 1, padding: '12px', borderRadius: 10, border: 'none',
              background: !isOffense ? t.blue : 'transparent',
              color: !isOffense ? '#FFF' : t.textSecondary,
              fontWeight: 700, fontSize: 14, cursor: 'pointer',
            }}
          >
            ⬇ DEFENSE
          </button>
        </div>

        {/* Pull Timer Overlay */}
        {defensePhase === 'pulling' && (
          <div style={{
            margin: '0 16px 10px', padding: '20px',
            background: t.accentMuted, border: `2px solid ${t.accent}`,
            borderRadius: 14, textAlign: 'center',
          }}>
            <p style={{ margin: 0, fontSize: 12, color: t.accent, fontWeight: 600 }}>
              PULL IN AIR - #{pullPlayer?.number}
            </p>
            <p style={{ margin: '8px 0 16px', fontSize: 48, fontWeight: 700, color: t.text, fontVariantNumeric: 'tabular-nums' }}>
              {pullTime.toFixed(1)}s
            </p>
            <div style={{ display: 'flex', gap: 10 }}>
              <button 
                onClick={() => handlePullResult('Caught')}
                style={{
                  flex: 1, padding: '16px', borderRadius: 12,
                  border: 'none', background: t.success, color: '#FFF',
                  fontWeight: 700, fontSize: 15, cursor: 'pointer',
                }}
              >
                ✓ Caught
              </button>
              <button 
                onClick={() => handlePullResult('OB')}
                style={{
                  flex: 1, padding: '16px', borderRadius: 12,
                  border: 'none', background: t.error, color: '#FFF',
                  fontWeight: 700, fontSize: 15, cursor: 'pointer',
                }}
              >
                ✕ OB
              </button>
            </div>
          </div>
        )}

        {/* Context hint */}
        {defensePhase !== 'pulling' && (
          <div style={{ padding: '0 16px', marginBottom: 8 }}>
            <p style={{ 
              margin: 0, fontSize: 12, color: t.textSecondary, textAlign: 'center',
              background: t.accentMuted, padding: '8px 12px', borderRadius: 8,
            }}>
              {isOffense 
                ? (discHolder 
                    ? `#${discHolder.number} has disc → Tap receiver` 
                    : 'Tap player who has the disc')
                : defensePhase === 'pre-pull'
                  ? (pullPlayer 
                      ? `#${pullPlayer.number} selected → Tap PULL`
                      : 'Tap player who is pulling')
                  : (selectedDefender
                      ? `#${selectedDefender.number} selected for D`
                      : 'Opponent has disc → Tap player for D or outcome')
              }
            </p>
          </div>
        )}

        {/* Players Grid */}
        {defensePhase !== 'pulling' && (
          <div style={{ padding: '0 16px', marginBottom: 10 }}>
            <div style={{ display: 'flex', gap: 8, marginBottom: 8 }}>
              {players.slice(0, 4).map((player) => (
                <button
                  key={player.id}
                  onClick={() => handlePlayerTap(player)}
                  style={{
                    flex: 1,
                    padding: '12px 8px',
                    borderRadius: 12,
                    border: selectedPlayer?.id === player.id 
                      ? `3px solid ${selectedColor}` 
                      : `1px solid ${t.cardBorder}`,
                    background: selectedPlayer?.id === player.id 
                      ? t.accentMuted 
                      : t.card,
                    cursor: 'pointer',
                    textAlign: 'center',
                    boxShadow: selectedPlayer?.id === player.id 
                      ? `0 0 16px ${selectedColor}40` 
                      : 'none',
                  }}
                >
                  <p style={{ 
                    margin: 0, 
                    fontSize: 18, 
                    fontWeight: 800, 
                    color: selectedPlayer?.id === player.id ? selectedColor : t.text,
                  }}>
                    {player.number}
                  </p>
                  <p style={{ margin: '2px 0 0', fontSize: 9, color: t.textSecondary }}>
                    {player.name}
                  </p>
                </button>
              ))}
            </div>
            
            <div style={{ display: 'flex', gap: 8, justifyContent: 'center' }}>
              <div style={{ flex: 0.5 }} />
              {players.slice(4, 7).map((player) => (
                <button
                  key={player.id}
                  onClick={() => handlePlayerTap(player)}
                  style={{
                    flex: 1,
                    maxWidth: 'calc(25% - 6px)',
                    padding: '12px 8px',
                    borderRadius: 12,
                    border: selectedPlayer?.id === player.id 
                      ? `3px solid ${selectedColor}` 
                      : `1px solid ${t.cardBorder}`,
                    background: selectedPlayer?.id === player.id 
                      ? t.accentMuted 
                      : t.card,
                    cursor: 'pointer',
                    textAlign: 'center',
                    boxShadow: selectedPlayer?.id === player.id 
                      ? `0 0 16px ${selectedColor}40` 
                      : 'none',
                  }}
                >
                  <p style={{ 
                    margin: 0, 
                    fontSize: 18, 
                    fontWeight: 800, 
                    color: selectedPlayer?.id === player.id ? selectedColor : t.text,
                  }}>
                    {player.number}
                  </p>
                  <p style={{ margin: '2px 0 0', fontSize: 9, color: t.textSecondary }}>
                    {player.name}
                  </p>
                </button>
              ))}
              <div style={{ flex: 0.5 }} />
            </div>
          </div>
        )}

        {/* Action Buttons */}
        {defensePhase !== 'pulling' && (
          <div style={{ padding: '0 16px', marginBottom: 6 }}>
            {isOffense ? (
              <>
                <div style={{ display: 'flex', gap: 6, marginBottom: 6 }}>
                  {['Drop', 'Throwaway', 'Stalled'].map(type => (
                    <button 
                      key={type}
                      onClick={() => handleTurnover(type)}
                      style={{
                        flex: 1, padding: '14px 8px', borderRadius: 12,
                        border: `1px solid ${t.error}50`, background: `${t.error}12`,
                        color: t.error, fontWeight: 700, fontSize: 12, cursor: 'pointer',
                      }}
                    >
                      {type}
                    </button>
                  ))}
                </div>

                <button 
                  onClick={handleGoal}
                  disabled={!discHolder}
                  style={{
                    width: '100%', padding: '14px', borderRadius: 12,
                    border: 'none', 
                    background: discHolder ? t.success : t.textTertiary,
                    color: '#FFF',
                    fontWeight: 700, fontSize: 15, cursor: discHolder ? 'pointer' : 'not-allowed',
                    opacity: discHolder ? 1 : 0.4,
                  }}
                >
                  ★ GOAL
                </button>
              </>
            ) : defensePhase === 'pre-pull' ? (
              <button 
                onClick={handlePull}
                disabled={!pullPlayer}
                style={{
                  width: '100%', padding: '18px', borderRadius: 14,
                  border: 'none', 
                  background: pullPlayer ? t.gradient : t.textTertiary,
                  color: pullPlayer ? '#000' : '#FFF',
                  fontWeight: 700, fontSize: 16, cursor: pullPlayer ? 'pointer' : 'not-allowed',
                  opacity: pullPlayer ? 1 : 0.4,
                  boxShadow: pullPlayer ? '0 4px 20px rgba(245,158,11,0.4)' : 'none',
                }}
              >
                ↗ PULL
              </button>
            ) : (
              <>
                <div style={{ display: 'flex', gap: 8, marginBottom: 6 }}>
                  <button 
                    onClick={() => handleDefensivePlay('block')}
                    style={{
                      flex: 1, padding: '14px 12px', borderRadius: 12,
                      border: 'none', background: t.blue,
                      color: '#FFF', fontWeight: 700, fontSize: 13, cursor: 'pointer',
                    }}
                  >
                    ⊘ Block
                  </button>
                  <button 
                    onClick={() => handleDefensivePlay('turnover')}
                    style={{
                      flex: 1, padding: '14px 12px', borderRadius: 12,
                      border: `1px solid ${t.cardBorder}`, background: t.card,
                      color: t.text, fontWeight: 700, fontSize: 13, cursor: 'pointer',
                    }}
                  >
                    Turnover
                  </button>
                  <button 
                    onClick={() => handleDefensivePlay('stall')}
                    style={{
                      flex: 1, padding: '14px 12px', borderRadius: 12,
                      border: `1px solid ${t.cardBorder}`, background: t.card,
                      color: t.text, fontWeight: 700, fontSize: 13, cursor: 'pointer',
                    }}
                  >
                    Stall
                  </button>
                </div>
                
                <button 
                  onClick={handleOpponentScore}
                  style={{
                    width: '100%', padding: '12px', borderRadius: 10,
                    border: `1px solid ${t.error}50`, background: `${t.error}12`,
                    color: t.error, fontWeight: 600, fontSize: 13, cursor: 'pointer',
                  }}
                >
                  Opponent Scores
                </button>
              </>
            )}
          </div>
        )}

        {/* Last Play Indicator */}
        {lastPlay && defensePhase !== 'pulling' && (
          <div style={{ 
            margin: '4px 16px', padding: '8px 12px',
            background: lastPlay.isGoal ? `${t.success}15` : lastPlay.isTurnover || lastPlay.isOppGoal ? `${t.error}15` : lastPlay.isBlock ? `${t.blue}15` : lastPlay.isPull ? t.accentMuted : t.accentMuted,
            border: `1px solid ${lastPlay.isGoal ? t.success : lastPlay.isTurnover || lastPlay.isOppGoal ? t.error : lastPlay.isBlock ? t.blue : lastPlay.isPull ? t.accent : t.cardBorder}40`,
            borderRadius: 10,
            display: 'flex', justifyContent: 'space-between', alignItems: 'center',
          }}>
            <span style={{ 
              fontSize: 12, fontWeight: 600, 
              color: lastPlay.isGoal ? t.success : lastPlay.isTurnover || lastPlay.isOppGoal ? t.error : lastPlay.isBlock ? t.blue : lastPlay.isPull ? t.accent : t.text,
            }}>
              {lastPlay.text}
            </span>
            <span style={{ fontSize: 10, color: t.textSecondary }}>{lastPlay.time}</span>
          </div>
        )}

        {/* Play Log */}
        {defensePhase !== 'pulling' && (
          <div style={{ 
            margin: '4px 16px', padding: '6px 0',
            background: t.card, border: `1px solid ${t.cardBorder}`, borderRadius: 10,
            maxHeight: 70, overflowY: 'auto',
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '0 10px 4px', borderBottom: `1px solid ${t.cardBorder}` }}>
              <span style={{ fontSize: 9, fontWeight: 600, color: t.textSecondary, textTransform: 'uppercase', letterSpacing: 1.5 }}>
                Play Log
              </span>
              <span style={{ fontSize: 9, color: t.textTertiary }}>{playLog.length}</span>
            </div>
            {playLog.length === 0 ? (
              <p style={{ margin: 0, padding: '8px', fontSize: 11, color: t.textTertiary, textAlign: 'center' }}>
                No plays yet
              </p>
            ) : (
              playLog.slice(0, 4).map((play, i) => (
                <div 
                  key={play.id}
                  style={{ 
                    padding: '4px 10px',
                    borderBottom: i < Math.min(playLog.length - 1, 3) ? `1px solid ${t.cardBorder}` : 'none',
                    display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                  }}
                >
                  <span style={{ 
                    fontSize: 10, 
                    color: play.isGoal ? t.success : play.isTurnover || play.isOppGoal ? t.error : play.isBlock ? t.blue : play.isPull ? t.accent : play.isCompletion ? t.text : t.textSecondary,
                    fontWeight: play.isGoal || play.isBlock ? 600 : 400,
                  }}>
                    {play.text}
                  </span>
                  <span style={{ fontSize: 9, color: t.textTertiary }}>{play.time}</span>
                </div>
              ))
            )}
          </div>
        )}

        {/* Bottom Bar */}
        <div style={{ 
          position: 'absolute', bottom: 0, left: 0, right: 0,
          padding: '10px 16px 28px',
          background: t.bg, borderTop: `1px solid ${t.cardBorder}`,
          display: 'flex', gap: 8,
        }}>
          <button 
            onClick={undo}
            disabled={playLog.length === 0}
            style={{
              flex: 1, padding: '12px', borderRadius: 10,
              border: `1px solid ${t.cardBorder}`, background: t.card,
              color: playLog.length ? t.textSecondary : t.textTertiary, 
              fontWeight: 600, fontSize: 12, cursor: playLog.length ? 'pointer' : 'not-allowed',
              opacity: playLog.length ? 1 : 0.5,
            }}
          >
            ↩ Undo
          </button>
          <button style={{
            flex: 1, padding: '12px', borderRadius: 10,
            border: `1px solid ${t.cardBorder}`, background: t.card,
            color: t.textSecondary, fontWeight: 600, fontSize: 12, cursor: 'pointer',
          }}>
            ⏸ Timeout
          </button>
          <button style={{
            flex: 1, padding: '12px', borderRadius: 10,
            border: `1px solid ${t.purple}`, background: `${t.purple}15`,
            color: t.purple, fontWeight: 600, fontSize: 12, cursor: 'pointer',
          }}>
            Subs
          </button>
          <button style={{
            padding: '12px 16px', borderRadius: 10,
            border: `1px solid ${t.error}40`, background: `${t.error}10`,
            color: t.error, fontWeight: 600, fontSize: 12, cursor: 'pointer',
          }}>
            End
          </button>
        </div>
      </div>
      
      <p style={{ textAlign: 'center', marginTop: 24, fontSize: 13, color: '#8A7550' }}>
        <strong style={{ color: '#C4A878' }}>Golden Hour</strong> · Stat Tracker · Amber Glow UI
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
