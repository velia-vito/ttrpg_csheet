import 'package:flutter/material.dart';

/// Common dice face options.
const _faceOptions = [4, 6, 8, 10, 12, 20, 100];

/// Common dice count options.
const _countOptions = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

/// A single dice-set row: count dropdown + "d" + faces dropdown.
class _DiceSetRow extends StatelessWidget {
  final int count;
  final int faces;
  final ValueChanged<int> onCountChanged;
  final ValueChanged<int> onFacesChanged;
  final VoidCallback onRemove;

  const _DiceSetRow({
    required this.count,
    required this.faces,
    required this.onCountChanged,
    required this.onFacesChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: DropdownButtonFormField<int>(
            initialValue: count,
            decoration: const InputDecoration(
              labelText: '#',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: _countOptions
                .map((c) => DropdownMenuItem(value: c, child: Text('$c')))
                .toList(),
            onChanged: (v) => onCountChanged(v!),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('d', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          width: 100,
          child: DropdownButtonFormField<int>(
            initialValue: faces,
            decoration: const InputDecoration(
              labelText: 'Faces',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            items: _faceOptions
                .map((f) => DropdownMenuItem(value: f, child: Text('$f')))
                .toList(),
            onChanged: (v) => onFacesChanged(v!),
          ),
        ),
        const SizedBox(width: 8),
        IconButton.filledTonal(
          icon: const Icon(Icons.remove_circle_outline, size: 20),
          onPressed: onRemove,
        ),
      ],
    );
  }
}

/// Callback with (diceSets: List<(count, faces)>).
typedef RollCallback = Future<List<int>> Function(List<(int count, int faces)> diceSets);

/// Reusable dice roller widget. Provide [onRoll] to perform the actual roll.
class DiceRoller extends StatefulWidget {
  final RollCallback onRoll;
  final String rollLabel;

  const DiceRoller({super.key, required this.onRoll, this.rollLabel = 'Roll'});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  final _diceSets = <(int count, int faces)>[(1, 20)];
  List<int>? _rolls;
  bool _rolling = false;
  String? _error;

  void _addDiceSet() => setState(() => _diceSets.add((1, 6)));

  void _removeDiceSet(int i) {
    if (_diceSets.length > 1) setState(() => _diceSets.removeAt(i));
  }

  Future<void> _roll() async {
    setState(() {
      _rolling = true;
      _error = null;
    });
    try {
      final results = await widget.onRoll(List.of(_diceSets));
      setState(() {
        _rolls = results;
        _rolling = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _rolling = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (var i = 0; i < _diceSets.length; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _DiceSetRow(
                    count: _diceSets[i].$1,
                    faces: _diceSets[i].$2,
                    onCountChanged: (v) =>
                        setState(() => _diceSets[i] = (v, _diceSets[i].$2)),
                    onFacesChanged: (v) =>
                        setState(() => _diceSets[i] = (_diceSets[i].$1, v)),
                    onRemove: () => _removeDiceSet(i),
                  ),
                ),
              Center(
                child: TextButton.icon(
                  onPressed: _addDiceSet,
                  icon: const Icon(Icons.add),
                  label: const Text('Add dice set'),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: FilledButton.icon(
                  onPressed: _rolling ? null : _roll,
                  icon: _rolling
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.casino),
                  label: Text(widget.rollLabel),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 16),
                Card(
                  color: theme.colorScheme.errorContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(_error!, style: TextStyle(color: theme.colorScheme.onErrorContainer)),
                  ),
                ),
              ],
              if (_rolls != null && _error == null) ...[
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Total: ${_rolls!.fold<int>(0, (a, b) => a + b)}',
                          style: theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 4,
                          children: [
                            for (var (i, r) in _rolls!.indexed)
                              Chip(label: Text('${i + 1}: $r')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
