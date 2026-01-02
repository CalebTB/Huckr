import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/domain/entities/player.dart';

/// Player Selector Widget - For selecting players during tracking
class PlayerSelector extends StatelessWidget {
  final List<GamePlayer> players;
  final String? selectedPlayerId;
  final Function(GamePlayer) onPlayerSelected;
  final bool showOnlyOnField;
  
  const PlayerSelector({
    super.key,
    required this.players,
    this.selectedPlayerId,
    required this.onPlayerSelected,
    this.showOnlyOnField = true,
  });

  @override
  Widget build(BuildContext context) {
    final filteredPlayers = showOnlyOnField 
        ? players.where((p) => p.isOnField).toList()
        : players;
    
    if (filteredPlayers.isEmpty) {
      return _buildEmptyState(context);
    }
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: filteredPlayers.map((player) {
        final isSelected = player.id == selectedPlayerId;
        return _PlayerChip(
          player: player,
          isSelected: isSelected,
          onTap: () => onPlayerSelected(player),
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(
            Icons.person_off,
            size: 48,
            color: AppTheme.gray500,
          ),
          const SizedBox(height: 8),
          Text(
            'No players on field',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.gray500,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerChip extends StatelessWidget {
  final GamePlayer player;
  final bool isSelected;
  final VoidCallback onTap;
  
  const _PlayerChip({
    required this.player,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected 
          ? AppTheme.primaryGreen 
          : AppTheme.gray700.withValues(alpha:0.5),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Jersey number
              if (player.jerseyNumber != null) ...[
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? Colors.white.withValues(alpha:0.2)
                        : AppTheme.gray600,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text(
                      '${player.jerseyNumber}',
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppTheme.gray300,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              
              // Player name
              Text(
                player.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.gray200,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Player Selector Modal - Full screen player selection
class PlayerSelectorModal extends StatelessWidget {
  final List<GamePlayer> players;
  final String title;
  final String? selectedPlayerId;
  final Function(GamePlayer) onPlayerSelected;
  
  const PlayerSelectorModal({
    super.key,
    required this.players,
    required this.title,
    this.selectedPlayerId,
    required this.onPlayerSelected,
  });

  @override
  Widget build(BuildContext context) {
    final onFieldPlayers = players.where((p) => p.isOnField).toList();
    final benchPlayers = players.where((p) => !p.isOnField).toList();
    
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // On field section
          if (onFieldPlayers.isNotEmpty) ...[
            Text(
              'On Field',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.primaryGreen,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: onFieldPlayers.map((player) {
                return _PlayerSelectButton(
                  player: player,
                  isSelected: player.id == selectedPlayerId,
                  onTap: () {
                    onPlayerSelected(player);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          ],
          
          // Bench section
          if (benchPlayers.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(
              'On Bench',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.gray500,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: benchPlayers.map((player) {
                return _PlayerSelectButton(
                  player: player,
                  isSelected: player.id == selectedPlayerId,
                  onTap: () {
                    onPlayerSelected(player);
                    Navigator.pop(context);
                  },
                  isBench: true,
                );
              }).toList(),
            ),
          ],
          
          // Quick add option
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => _showQuickAddPlayer(context),
            icon: const Icon(Icons.person_add),
            label: const Text('Add Player'),
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showQuickAddPlayer(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => _QuickAddPlayerDialog(
        onAdd: (name, number) {
          final newPlayer = GamePlayer(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: name,
            jerseyNumber: number,
            isOnField: true,
          );
          onPlayerSelected(newPlayer);
          Navigator.pop(context); // Close dialog
          Navigator.pop(context); // Close modal
        },
      ),
    );
  }
}

class _PlayerSelectButton extends StatelessWidget {
  final GamePlayer player;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isBench;
  
  const _PlayerSelectButton({
    required this.player,
    required this.isSelected,
    required this.onTap,
    this.isBench = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected 
          ? AppTheme.primaryGreen 
          : isBench 
              ? AppTheme.gray800 
              : AppTheme.gray700,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            children: [
              // Jersey number or avatar
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Colors.white.withValues(alpha:0.2)
                      : AppTheme.gray600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    player.jerseyNumber?.toString() ?? '?',
                    style: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.gray300,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              
              // Name
              Text(
                player.name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isSelected 
                      ? Colors.white 
                      : isBench 
                          ? AppTheme.gray400 
                          : AppTheme.gray200,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAddPlayerDialog extends StatefulWidget {
  final Function(String name, int? number) onAdd;
  
  const _QuickAddPlayerDialog({required this.onAdd});

  @override
  State<_QuickAddPlayerDialog> createState() => _QuickAddPlayerDialogState();
}

class _QuickAddPlayerDialogState extends State<_QuickAddPlayerDialog> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  
  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Player'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              hintText: 'Player name',
            ),
            autofocus: true,
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _numberController,
            decoration: const InputDecoration(
              labelText: 'Jersey Number (optional)',
              hintText: '00',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              widget.onAdd(
                _nameController.text,
                int.tryParse(_numberController.text),
              );
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

/// Line Selector - For selecting O-line or D-line at start of point
class LineSelector extends StatelessWidget {
  final List<GamePlayer> allPlayers;
  final List<String> selectedPlayerIds;
  final Function(List<String>) onLineSelected;
  final int maxPlayers;
  
  const LineSelector({
    super.key,
    required this.allPlayers,
    required this.selectedPlayerIds,
    required this.onLineSelected,
    this.maxPlayers = 7,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Line (${selectedPlayerIds.length}/$maxPlayers)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            if (selectedPlayerIds.isNotEmpty)
              TextButton(
                onPressed: () => onLineSelected([]),
                child: const Text('Clear'),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allPlayers.map((player) {
            final isSelected = selectedPlayerIds.contains(player.id);
            final canSelect = selectedPlayerIds.length < maxPlayers || isSelected;
            
            return _LinePlayerChip(
              player: player,
              isSelected: isSelected,
              canSelect: canSelect,
              onTap: () {
                final newSelection = List<String>.from(selectedPlayerIds);
                if (isSelected) {
                  newSelection.remove(player.id);
                } else if (canSelect) {
                  newSelection.add(player.id);
                }
                onLineSelected(newSelection);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _LinePlayerChip extends StatelessWidget {
  final GamePlayer player;
  final bool isSelected;
  final bool canSelect;
  final VoidCallback onTap;
  
  const _LinePlayerChip({
    required this.player,
    required this.isSelected,
    required this.canSelect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: canSelect ? 1.0 : 0.5,
      child: FilterChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (player.jerseyNumber != null) ...[
              Text(
                '#${player.jerseyNumber}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: isSelected ? Colors.white : AppTheme.gray400,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Text(player.name),
          ],
        ),
        selected: isSelected,
        onSelected: canSelect ? (_) => onTap() : null,
        selectedColor: AppTheme.primaryGreen,
        checkmarkColor: Colors.white,
        backgroundColor: AppTheme.gray700,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppTheme.gray200,
        ),
      ),
    );
  }
}
