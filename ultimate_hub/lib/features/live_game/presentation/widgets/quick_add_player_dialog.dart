import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ultimate_hub/core/theme/app_theme.dart';

/// Quick add player dialog
///
/// Simple dialog for adding a player mid-game
/// TextField for player name
/// TextField for jersey number (optional)
/// Returns Map<String, String> with 'name' and optional 'number'
class QuickAddPlayerDialog extends StatefulWidget {
  const QuickAddPlayerDialog({super.key});

  @override
  State<QuickAddPlayerDialog> createState() => _QuickAddPlayerDialogState();
}

class _QuickAddPlayerDialogState extends State<QuickAddPlayerDialog> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_checkValid);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  void _checkValid() {
    setState(() {
      _isValid = _nameController.text.trim().isNotEmpty;
    });
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final number = _numberController.text.trim();

      Navigator.of(context).pop({
        'name': name,
        if (number.isNotEmpty) 'number': number,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppTheme.cardBorder,
            width: 1,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                'Add Player',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 24),

              // Name field
              TextFormField(
                controller: _nameController,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Player Name',
                  hintText: 'Enter name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 16),

              // Jersey number field
              TextFormField(
                controller: _numberController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                decoration: const InputDecoration(
                  labelText: 'Jersey Number (Optional)',
                  hintText: 'e.g., 7',
                  prefixIcon: Icon(Icons.tag),
                ),
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isValid ? _submit : null,
                      child: const Text('Add'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
