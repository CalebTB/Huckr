import React, { useState, useEffect } from 'react';

export default function FastStatTracker() {
  const [isDark, setIsDark] = useState(true);
  const [homeScore, setHomeScore] = useState(8);
  const [awayScore, setAwayScore] = useState(7);
  const [isOffense, setIsOffense] = useState(true);
  const [discHolder, setDiscHolder] = useState(null);
  const [gameTime] = useState('42:18');
  const [lastPlay, setLastPlay] = useState(null);
  const [playLog, setPlayLog] = useState([]);
  
  // Defense states: 'pre-pull' (after WE score), 'pulling', 'watching' (after turnover or pull lands)
  const [defensePhase, setDefensePhase] = useState('pre-pull');
  const [pullPlayer, setPullPlayer] = useState(null);
  const [pullTime, setPullTime] = useState(0);
  const [selectedDefender, setSelectedDefender] = useState(null);
  
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
    foul: '#F59E0B',
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
    foul: '#F59E0B',
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

  // Pull timer
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

  // Check if players are selectable
  const playersSelectable = isOffense || (!isOffense && defensePhase === 'pre-pull') || (!isOffense && defensePhase === 'watching');

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
      // Defense - select player for pull (pre-pull) or for D attribution (watching)
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
      setDefensePhase('pre-pull'); // Only pre-pull after WE score
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
    setDefensePhase('watching'); // They have disc now, we're watching
    setPullPlayer(null);
    setSelectedDefender(null);
  };

  const handleFoul = (result) => {
    const playerNum = isOffense ? (discHolder ? `#${discHolder.number}` : '') : (selectedDefender ? `#${selectedDefender.number}` : '');
    
    if (isOffense) {
      if (result === 'stays') {
        logPlay({ type: 'foul', text: `⚠ Foul ${playerNum} (Stays)`, isFoul: true });
      } else if (result === 'uncontested') {
        logPlay({ type: 'foul', text: `⚠ Foul ${playerNum} (Uncontested)`, isFoul: true });
      } else {
        logPlay({ type: 'foul', text: `⚠ Foul ${playerNum} (Turnover)`, isFoul: true, isTurnover: true });
        setDiscHolder(null);
        setIsOffense(false);
        setDefensePhase('watching'); // Turnover means they have disc
        setSelectedDefender(null);
      }
    } else {
      if (result === 'stays') {
        logPlay({ type: 'foul', text: `⚠ Foul ${playerNum} (They keep)`, isFoul: true });
      } else if (result === 'uncontested') {
        logPlay({ type: 'foul', text: `⚠ Foul ${playerNum} (Uncontested)`, isFoul: true });
      } else {
        logPlay({ type: 'foul', text: `⚠ Foul ${playerNum} (We get disc)`, isFoul: true, isBlock: true });
        setIsOffense(true);
        setDefensePhase('pre-pull');
        setPullPlayer(null);
        setSelectedDefender(null);
      }
    }
  };

  // Defense actions
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
    setIsOffense(true); // We receive after they score
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
  const selectedColor = isOffense ? t.orange : t.blue;
  const hasPlayerSelected = isOffense ? !!discHolder : !!selectedDefender;

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
            <svg width="25" height="12" fill={t.text}><rect x="0" y="0" width="22" height="12" rx="3" fill="none" stroke={t.text}/><rect x="2" y="2" width="17" height="8" rx="1.5"/></svg>
          </div>
        </div>

        {/* Score Bar */}
        <div style={{ 
          margin: '0 16px 8px', padding: '10px 16px',
          background: t.card, border: `1px solid ${t.border}`, borderRadius: 14,
          display: 'flex', justifyContent: 'space-between', alignItems: 'center',
        }}>
          <div style={{ textAlign: 'center' }}>
            <p style={{ margin: 0, fontSize: 11, color: t.muted }}>ROF</p>
            <p style={{ margin: 0, fontSize: 28, fontWeight: 700, color: t.text }}>{homeScore}</p>
          </div>
          <div style={{ textAlign: 'center' }}>
            <p style={{ margin: 0, fontSize: 11, color: t.muted }}>{gameTime}</p>
            <div style={{ display: 'flex', alignItems: 'center', gap: 4, marginTop: 2 }}>
              <span style={{ width: 6, height: 6, borderRadius: '50%', background: t.lose, animation: 'pulse 1.5s infinite' }} />
              <span style={{ fontSize: 10, fontWeight: 600, color: t.lose }}>LIVE</span>
            </div>
          </div>
          <div style={{ textAlign: 'center' }}>
            <p style={{ margin: 0, fontSize: 11, color: t.muted }}>SOC</p>
            <p style={{ margin: 0, fontSize: 28, fontWeight: 700, color: t.text }}>{awayScore}</p>
          </div>
        </div>

        {/* Offense/Defense Toggle */}
        <div style={{ 
          display: 'flex', margin: '0 16px 10px', 
          background: t.card, borderRadius: 12, padding: 4,
          border: `1px solid ${t.border}`,
        }}>
          <button 
            onClick={() => { setIsOffense(true); setDiscHolder(null); setPullPlayer(null); setSelectedDefender(null); setDefensePhase('pre-pull'); }}
            style={{
              flex: 1, padding: '12px', borderRadius: 10, border: 'none',
              background: isOffense ? t.orange : 'transparent',
              color: isOffense ? '#FFF' : t.muted,
              fontWeight: 700, fontSize: 14, cursor: 'pointer',
              transition: 'all 0.2s',
            }}
          >
            ⬆ OFFENSE
          </button>
          <button 
            onClick={() => { setIsOffense(false); setDiscHolder(null); setPullPlayer(null); setSelectedDefender(null); setDefensePhase('watching'); }}
            style={{
              flex: 1, padding: '12px', borderRadius: 10, border: 'none',
              background: !isOffense ? t.blue : 'transparent',
              color: !isOffense ? '#FFF' : t.muted,
              fontWeight: 700, fontSize: 14, cursor: 'pointer',
              transition: 'all 0.2s',
            }}
          >
            ⬇ DEFENSE
          </button>
        </div>

        {/* Pull Timer Overlay */}
        {defensePhase === 'pulling' && (
          <div style={{
            margin: '0 16px 10px', padding: '20px',
            background: `${t.yellow}15`, border: `2px solid ${t.yellow}`,
            borderRadius: 14, textAlign: 'center',
          }}>
            <p style={{ margin: 0, fontSize: 12, color: t.yellow, fontWeight: 600 }}>
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
                  border: 'none', background: t.win, color: '#FFF',
                  fontWeight: 700, fontSize: 15, cursor: 'pointer',
                }}
              >
                ✓ Caught
              </button>
              <button 
                onClick={() => handlePullResult('OB')}
                style={{
                  flex: 1, padding: '16px', borderRadius: 12,
                  border: 'none', background: t.lose, color: '#FFF',
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
              margin: 0, fontSize: 12, color: t.muted, textAlign: 'center',
              background: t.accentBg, padding: '8px 12px', borderRadius: 8,
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
            {/* Row 1: 4 players */}
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
                      : `1px solid ${t.border}`,
                    background: selectedPlayer?.id === player.id 
                      ? `${selectedColor}20` 
                      : t.card,
                    cursor: 'pointer',
                    textAlign: 'center',
                    boxShadow: selectedPlayer?.id === player.id 
                      ? `0 0 16px ${selectedColor}40` 
                      : 'none',
                    transition: 'all 0.15s',
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
                  <p style={{ margin: '2px 0 0', fontSize: 9, color: t.muted }}>
                    {player.name}
                  </p>
                </button>
              ))}
            </div>
            
            {/* Row 2: 3 players centered */}
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
                      : `1px solid ${t.border}`,
                    background: selectedPlayer?.id === player.id 
                      ? `${selectedColor}20` 
                      : t.card,
                    cursor: 'pointer',
                    textAlign: 'center',
                    boxShadow: selectedPlayer?.id === player.id 
                      ? `0 0 16px ${selectedColor}40` 
                      : 'none',
                    transition: 'all 0.15s',
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
                  <p style={{ margin: '2px 0 0', fontSize: 9, color: t.muted }}>
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
                {/* OFFENSE: Turnovers */}
                <div style={{ display: 'flex', gap: 6, marginBottom: 6 }}>
                  {['Drop', 'Throwaway', 'Stalled'].map(type => (
                    <button 
                      key={type}
                      onClick={() => handleTurnover(type)}
                      style={{
                        flex: 1, padding: '14px 8px', borderRadius: 12,
                        border: `1px solid ${t.lose}50`, background: `${t.lose}12`,
                        color: t.lose, fontWeight: 700, fontSize: 12, cursor: 'pointer',
                      }}
                    >
                      {type}
                    </button>
                  ))}
                </div>
                
                {/* Foul buttons - only show when player selected */}
                {hasPlayerSelected && (
                  <div style={{ display: 'flex', gap: 6, marginBottom: 6 }}>
                    <button 
                      onClick={() => handleFoul('stays')}
                      style={{
                        flex: 1, padding: '10px 6px', borderRadius: 10,
                        border: `1px solid ${t.foul}50`, background: `${t.foul}12`,
                        color: t.foul, fontWeight: 600, fontSize: 10, cursor: 'pointer',
                      }}
                    >
                      ⚠ #{discHolder?.number} Foul (Stays)
                    </button>
                    <button 
                      onClick={() => handleFoul('uncontested')}
                      style={{
                        flex: 1, padding: '10px 6px', borderRadius: 10,
                        border: `1px solid ${t.foul}50`, background: `${t.foul}12`,
                        color: t.foul, fontWeight: 600, fontSize: 10, cursor: 'pointer',
                      }}
                    >
                      ⚠ Uncontested
                    </button>
                    <button 
                      onClick={() => handleFoul('turnover')}
                      style={{
                        flex: 1, padding: '10px 6px', borderRadius: 10,
                        border: `1px solid ${t.foul}50`, background: `${t.foul}12`,
                        color: t.foul, fontWeight: 600, fontSize: 10, cursor: 'pointer',
                      }}
                    >
                      ⚠ Turnover
                    </button>
                  </div>
                )}

                <button 
                  onClick={handleGoal}
                  disabled={!discHolder}
                  style={{
                    width: '100%', padding: '14px', borderRadius: 12,
                    border: 'none', 
                    background: discHolder ? t.win : t.dim,
                    color: '#FFF',
                    fontWeight: 700, fontSize: 15, cursor: discHolder ? 'pointer' : 'not-allowed',
                    opacity: discHolder ? 1 : 0.4,
                  }}
                >
                  ★ GOAL
                </button>
              </>
            ) : defensePhase === 'pre-pull' ? (
              <>
                {/* DEFENSE PRE-PULL - only after we score */}
                <button 
                  onClick={handlePull}
                  disabled={!pullPlayer}
                  style={{
                    width: '100%', padding: '18px', borderRadius: 14,
                    border: 'none', 
                    background: pullPlayer ? t.yellow : t.dim,
                    color: pullPlayer ? '#000' : '#FFF',
                    fontWeight: 700, fontSize: 16, cursor: pullPlayer ? 'pointer' : 'not-allowed',
                    opacity: pullPlayer ? 1 : 0.4,
                  }}
                >
                  ↗ PULL
                </button>
              </>
            ) : (
              <>
                {/* DEFENSE WATCHING - after turnover or pull lands */}
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
                      border: `1px solid ${t.border}`, background: t.card,
                      color: t.text, fontWeight: 700, fontSize: 13, cursor: 'pointer',
                    }}
                  >
                    Turnover
                  </button>
                  <button 
                    onClick={() => handleDefensivePlay('stall')}
                    style={{
                      flex: 1, padding: '14px 12px', borderRadius: 12,
                      border: `1px solid ${t.border}`, background: t.card,
                      color: t.text, fontWeight: 700, fontSize: 13, cursor: 'pointer',
                    }}
                  >
                    Stall
                  </button>
                </div>
                
                {/* Foul buttons for defense - only show when player selected */}
                {selectedDefender && (
                  <div style={{ display: 'flex', gap: 6, marginBottom: 6 }}>
                    <button 
                      onClick={() => handleFoul('stays')}
                      style={{
                        flex: 1, padding: '10px 6px', borderRadius: 10,
                        border: `1px solid ${t.foul}50`, background: `${t.foul}12`,
                        color: t.foul, fontWeight: 600, fontSize: 10, cursor: 'pointer',
                      }}
                    >
                      ⚠ #{selectedDefender.number} Foul (They keep)
                    </button>
                    <button 
                      onClick={() => handleFoul('uncontested')}
                      style={{
                        flex: 1, padding: '10px 6px', borderRadius: 10,
                        border: `1px solid ${t.foul}50`, background: `${t.foul}12`,
                        color: t.foul, fontWeight: 600, fontSize: 10, cursor: 'pointer',
                      }}
                    >
                      ⚠ Uncontested
                    </button>
                    <button 
                      onClick={() => handleFoul('turnover')}
                      style={{
                        flex: 1, padding: '10px 6px', borderRadius: 10,
                        border: `1px solid ${t.foul}50`, background: `${t.foul}12`,
                        color: t.foul, fontWeight: 600, fontSize: 10, cursor: 'pointer',
                      }}
                    >
                      ⚠ We get disc
                    </button>
                  </div>
                )}
                
                <button 
                  onClick={handleOpponentScore}
                  style={{
                    width: '100%', padding: '12px', borderRadius: 10,
                    border: `1px solid ${t.lose}50`, background: `${t.lose}12`,
                    color: t.lose, fontWeight: 600, fontSize: 13, cursor: 'pointer',
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
            background: lastPlay.isGoal ? `${t.win}15` : lastPlay.isTurnover || lastPlay.isOppGoal ? `${t.lose}15` : lastPlay.isBlock ? `${t.blue}15` : lastPlay.isPull ? `${t.yellow}15` : lastPlay.isFoul ? `${t.foul}15` : t.accentBg,
            border: `1px solid ${lastPlay.isGoal ? t.win : lastPlay.isTurnover || lastPlay.isOppGoal ? t.lose : lastPlay.isBlock ? t.blue : lastPlay.isPull ? t.yellow : lastPlay.isFoul ? t.foul : t.border}40`,
            borderRadius: 10,
            display: 'flex', justifyContent: 'space-between', alignItems: 'center',
          }}>
            <span style={{ 
              fontSize: 12, fontWeight: 600, 
              color: lastPlay.isGoal ? t.win : lastPlay.isTurnover || lastPlay.isOppGoal ? t.lose : lastPlay.isBlock ? t.blue : lastPlay.isPull ? t.yellow : lastPlay.isFoul ? t.foul : t.text,
            }}>
              {lastPlay.text}
            </span>
            <span style={{ fontSize: 10, color: t.muted }}>{lastPlay.time}</span>
          </div>
        )}

        {/* Play Log */}
        {defensePhase !== 'pulling' && (
          <div style={{ 
            margin: '4px 16px', padding: '6px 0',
            background: t.card, border: `1px solid ${t.border}`, borderRadius: 10,
            maxHeight: 70, overflowY: 'auto',
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '0 10px 4px', borderBottom: `1px solid ${t.border}` }}>
              <span style={{ fontSize: 9, fontWeight: 600, color: t.muted, textTransform: 'uppercase', letterSpacing: 1 }}>
                Play Log
              </span>
              <span style={{ fontSize: 9, color: t.dim }}>{playLog.length}</span>
            </div>
            {playLog.length === 0 ? (
              <p style={{ margin: 0, padding: '8px', fontSize: 11, color: t.dim, textAlign: 'center' }}>
                No plays yet
              </p>
            ) : (
              playLog.slice(0, 4).map((play, i) => (
                <div 
                  key={play.id}
                  style={{ 
                    padding: '4px 10px',
                    borderBottom: i < Math.min(playLog.length - 1, 3) ? `1px solid ${t.border}` : 'none',
                    display: 'flex', justifyContent: 'space-between', alignItems: 'center',
                  }}
                >
                  <span style={{ 
                    fontSize: 10, 
                    color: play.isGoal ? t.win : play.isTurnover || play.isOppGoal ? t.lose : play.isBlock ? t.blue : play.isPull ? t.yellow : play.isFoul ? t.foul : play.isCompletion ? t.text : t.muted,
                    fontWeight: play.isGoal || play.isBlock ? 600 : 400,
                  }}>
                    {play.text}
                  </span>
                  <span style={{ fontSize: 9, color: t.dim }}>{play.time}</span>
                </div>
              ))
            )}
          </div>
        )}

        {/* Bottom Bar */}
        <div style={{ 
          position: 'absolute', bottom: 0, left: 0, right: 0,
          padding: '10px 16px 28px',
          background: t.bg, borderTop: `1px solid ${t.border}`,
          display: 'flex', gap: 8,
        }}>
          <button 
            onClick={undo}
            disabled={playLog.length === 0}
            style={{
              flex: 1, padding: '12px', borderRadius: 10,
              border: `1px solid ${t.border}`, background: t.card,
              color: playLog.length ? t.muted : t.dim, 
              fontWeight: 600, fontSize: 12, cursor: playLog.length ? 'pointer' : 'not-allowed',
              opacity: playLog.length ? 1 : 0.5,
            }}
          >
            ↩ Undo
          </button>
          <button style={{
            flex: 1, padding: '12px', borderRadius: 10,
            border: `1px solid ${t.border}`, background: t.card,
            color: t.muted, fontWeight: 600, fontSize: 12, cursor: 'pointer',
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
            border: `1px solid ${t.lose}40`, background: `${t.lose}10`,
            color: t.lose, fontWeight: 600, fontSize: 12, cursor: 'pointer',
          }}>
            End
          </button>
        </div>
      </div>
      
      <p style={{ textAlign: 'center', marginTop: 24, fontSize: 13, color: '#737373' }}>
        <strong>Fast Stat Tracker v5</strong> · Fouls with player attribution · Fixed defense flow
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
