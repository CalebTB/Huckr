import 'package:flutter/material.dart';
import 'dart:async';

import '../../../../core/theme/app_theme.dart';

/// Game Clock Widget - Displays game time with cap warnings
class GameClock extends StatefulWidget {
  final Stopwatch stopwatch;
  final bool isRunning;
  final VoidCallback onToggle;
  final bool compact;
  final int? softCapMinutes;
  final int? hardCapMinutes;
  
  const GameClock({
    super.key,
    required this.stopwatch,
    required this.isRunning,
    required this.onToggle,
    this.compact = false,
    this.softCapMinutes = 75,
    this.hardCapMinutes = 90,
  });

  @override
  State<GameClock> createState() => _GameClockState();
}

class _GameClockState extends State<GameClock> {
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _startTimer();
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = widget.stopwatch.elapsed;
    final elapsedMinutes = elapsed.inMinutes;
    final elapsedSeconds = elapsed.inSeconds;

    final softCapSeconds = (widget.softCapMinutes ?? 75) * 60;
    final hardCapSeconds = (widget.hardCapMinutes ?? 90) * 60;

    // Determine cap status and countdown time
    final capStatus = _getCapStatus(elapsedMinutes);
    int remainingSeconds;
    String timeLabel;

    if (elapsedSeconds >= hardCapSeconds) {
      // Hard cap reached - show time over hard cap
      remainingSeconds = elapsedSeconds - hardCapSeconds;
      timeLabel = 'OVERTIME';
    } else if (elapsedSeconds >= softCapSeconds) {
      // In hard cap countdown - show time until hard cap
      remainingSeconds = hardCapSeconds - elapsedSeconds;
      timeLabel = 'TO HARD CAP';
    } else {
      // In soft cap countdown - show time until soft cap
      remainingSeconds = softCapSeconds - elapsedSeconds;
      timeLabel = 'TO SOFT CAP';
    }

    final minutes = remainingSeconds.abs() ~/ 60;
    final seconds = remainingSeconds.abs() % 60;
    final timeString = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    if (widget.compact) {
      return _buildCompactClock(context, timeString, capStatus, timeLabel);
    }

    return _buildFullClock(context, timeString, capStatus, minutes, timeLabel, elapsedMinutes);
  }

  Widget _buildFullClock(BuildContext context, String timeString, _CapStatus capStatus, int minutes, String timeLabel, int elapsedMinutes) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Play/Pause button
          IconButton(
            onPressed: widget.onToggle,
            icon: Icon(
              widget.isRunning ? Icons.pause_circle : Icons.play_circle,
              size: 32,
            ),
            color: AppTheme.primaryGreen,
          ),

          const SizedBox(width: 16),

          // Time display
          Column(
            children: [
              // Time label (TO SOFT CAP / TO HARD CAP / OVERTIME)
              Text(
                timeLabel,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: capStatus.color,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              // Countdown time
              Text(
                timeString,
                style: AppStyles.clockStyle(context).copyWith(
                  color: capStatus.color,
                ),
              ),
              if (capStatus.label != null)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: capStatus.color.withValues(alpha:0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    capStatus.label!,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: capStatus.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(width: 16),

          // Cap indicator
          _CapIndicator(
            softCapMinutes: widget.softCapMinutes ?? 75,
            hardCapMinutes: widget.hardCapMinutes ?? 90,
            currentMinutes: elapsedMinutes,
          ),
        ],
      ),
    );
  }

  Widget _buildCompactClock(BuildContext context, String timeString, _CapStatus capStatus, String timeLabel) {
    return InkWell(
      onTap: widget.onToggle,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: capStatus.color.withValues(alpha:0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: capStatus.color.withValues(alpha:0.3),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Time label
            Text(
              timeLabel,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: capStatus.color,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 4),
            // Timer row
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.isRunning ? Icons.pause : Icons.play_arrow,
                  size: 20,
                  color: capStatus.color,
                ),
                const SizedBox(width: 8),
                Text(
                  timeString,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: capStatus.color,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'JetBrainsMono',
                  ),
                ),
                if (capStatus.label != null) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: capStatus.color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      capStatus.label!,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 9,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  _CapStatus _getCapStatus(int minutes) {
    final softCap = widget.softCapMinutes ?? 75;
    final hardCap = widget.hardCapMinutes ?? 90;

    if (minutes >= hardCap) {
      return _CapStatus(
        color: AppTheme.error,
        label: 'HARD CAP',
      );
    } else if (minutes >= softCap) {
      return _CapStatus(
        color: AppTheme.warning,
        label: 'SOFT CAP',
      );
    } else if (minutes >= softCap - 5) {
      // Warning: 5 minutes before soft cap
      return _CapStatus(
        color: AppTheme.accent,
        label: null,
      );
    }

    return _CapStatus(
      color: AppTheme.textPrimary,
      label: null,
    );
  }
}

class _CapStatus {
  final Color color;
  final String? label;
  
  _CapStatus({required this.color, this.label});
}

/// Cap Indicator - Shows progress toward soft/hard cap
class _CapIndicator extends StatelessWidget {
  final int softCapMinutes;
  final int hardCapMinutes;
  final int currentMinutes;
  
  const _CapIndicator({
    required this.softCapMinutes,
    required this.hardCapMinutes,
    required this.currentMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Soft cap row
        _CapRow(
          label: 'Soft',
          targetMinutes: softCapMinutes,
          currentMinutes: currentMinutes,
          color: AppTheme.warning,
        ),
        const SizedBox(height: 4),
        // Hard cap row
        _CapRow(
          label: 'Hard',
          targetMinutes: hardCapMinutes,
          currentMinutes: currentMinutes,
          color: AppTheme.error,
        ),
      ],
    );
  }
}

class _CapRow extends StatelessWidget {
  final String label;
  final int targetMinutes;
  final int currentMinutes;
  final Color color;
  
  const _CapRow({
    required this.label,
    required this.targetMinutes,
    required this.currentMinutes,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isReached = currentMinutes >= targetMinutes;
    final progress = (currentMinutes / targetMinutes).clamp(0.0, 1.0);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 32,
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isReached ? color : AppTheme.gray500,
              fontWeight: isReached ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 50,
          height: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppTheme.gray700,
              valueColor: AlwaysStoppedAnimation<Color>(
                isReached ? color : color.withValues(alpha:0.5),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$targetMinutes',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: isReached ? color : AppTheme.gray500,
            fontFamily: 'JetBrainsMono',
          ),
        ),
      ],
    );
  }
}

/// Point Clock - Timer for between points
class PointClock extends StatefulWidget {
  final int secondsAllowed; // Usually 75 seconds between points
  final VoidCallback? onExpired;
  
  const PointClock({
    super.key,
    this.secondsAllowed = 75,
    this.onExpired,
  });

  @override
  State<PointClock> createState() => _PointClockState();
}

class _PointClockState extends State<PointClock> {
  late int _secondsRemaining;
  Timer? _timer;
  bool _isRunning = false;
  
  @override
  void initState() {
    super.initState();
    _secondsRemaining = widget.secondsAllowed;
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  void _startTimer() {
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          if (_secondsRemaining > 0) {
            _secondsRemaining--;
          } else {
            _timer?.cancel();
            _isRunning = false;
            widget.onExpired?.call();
          }
        });
      }
    });
  }
  
  void _pauseTimer() {
    _timer?.cancel();
    _isRunning = false;
  }
  
  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = widget.secondsAllowed;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWarning = _secondsRemaining <= 15;
    final isExpired = _secondsRemaining <= 0;
    
    final color = isExpired 
        ? AppTheme.error 
        : isWarning 
            ? AppTheme.warning 
            : AppTheme.primaryGreen;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha:0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha:0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'POINT CLOCK',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _formatSeconds(_secondsRemaining),
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
              fontFamily: 'JetBrainsMono',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: _isRunning ? _pauseTimer : _startTimer,
                icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                color: color,
              ),
              IconButton(
                onPressed: _resetTimer,
                icon: const Icon(Icons.refresh),
                color: color,
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  String _formatSeconds(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}

/// Stall Count Widget
class StallCount extends StatefulWidget {
  final Function(int)? onStallChange;
  
  const StallCount({super.key, this.onStallChange});

  @override
  State<StallCount> createState() => _StallCountState();
}

class _StallCountState extends State<StallCount> {
  int _count = 0;
  
  void _increment() {
    if (_count < 10) {
      setState(() {
        _count++;
      });
      widget.onStallChange?.call(_count);
    }
  }
  
  void _reset() {
    setState(() {
      _count = 0;
    });
    widget.onStallChange?.call(_count);
  }

  @override
  Widget build(BuildContext context) {
    final isWarning = _count >= 7;
    final isStall = _count >= 10;
    
    final color = isStall 
        ? AppTheme.error 
        : isWarning 
            ? AppTheme.warning 
            : AppTheme.primaryGreen;
    
    return GestureDetector(
      onTap: _increment,
      onLongPress: _reset,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha:0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'STALL',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: color,
                letterSpacing: 1,
              ),
            ),
            Text(
              '$_count',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'tap +1 | hold reset',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.gray500,
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
