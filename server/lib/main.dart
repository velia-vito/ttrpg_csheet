import 'dart:math';

import 'package:api/build/data/log_entry.pb.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:server/common/identity_store.dart';
import 'package:server/service/handler_service.dart';
import 'package:server/service/logger_service.dart';
import 'package:server/service/roller_service.dart';
import 'package:ui/ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final handler = HandlerService();
  final roller = RollerService();
  final logger = Logger();

  // Initialize services.
  try {
    await handler.initialize();
  } catch (_) {
    // First run — config was created with defaults.
  }

  // Start gRPC server.
  final server = Server.create(services: [handler, roller, logger]);
  await server.serve(port: 50051);

  runApp(_ServerApp(logger: logger));
}

// ──────────────────────────── Server App ────────────────────────────

class _ServerApp extends StatelessWidget {
  final Logger logger;
  const _ServerApp({required this.logger});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TTRPG Server',
      theme: appTheme(),
      home: _ServerHome(logger: logger),
    );
  }
}

class _ServerHome extends StatefulWidget {
  final Logger logger;
  const _ServerHome({required this.logger});
  @override
  State<_ServerHome> createState() => _ServerHomeState();
}

class _ServerHomeState extends State<_ServerHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TTRPG Server'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.people), text: 'Profiles'),
              Tab(icon: Icon(Icons.casino), text: 'DM Roller'),
              Tab(icon: Icon(Icons.list_alt), text: 'Roll Log'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ProfilesTab(),
            _DmRollerTab(),
            _RollLogTab(logger: widget.logger),
          ],
        ),
      ),
    );
  }
}

// ──────────────────────────── Tab 1: Profiles ────────────────────────────

class _ProfilesTab extends StatefulWidget {
  @override
  State<_ProfilesTab> createState() => _ProfilesTabState();
}

class _ProfilesTabState extends State<_ProfilesTab> {
  final _store = IdentityStore();
  bool _showApproved = false;

  @override
  Widget build(BuildContext context) {
    final identities = _showApproved ? _store.approvedIdentities : _store.unapprovedIdentities;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: SegmentedButton<bool>(
            segments: const [
              ButtonSegment(value: false, label: Text('Unapproved')),
              ButtonSegment(value: true, label: Text('Approved')),
            ],
            selected: {_showApproved},
            onSelectionChanged: (v) => setState(() => _showApproved = v.first),
          ),
        ),
        Expanded(
          child: identities.isEmpty
              ? const Center(child: Text('No profiles.'))
              : ListView.builder(
                  itemCount: identities.length,
                  itemBuilder: (ctx, i) {
                    final id = identities[i];
                    return ListTile(
                      title: Text(id.username),
                      subtitle: Text(id.approvedAs.name),
                      trailing: _showApproved
                          ? IconButton(
                              icon: const Icon(Icons.block),
                              tooltip: 'Disapprove',
                              onPressed: () {
                                _store.disapproveIdentity(id);
                                setState(() {});
                              },
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.check),
                                  tooltip: 'Approve as Player',
                                  onPressed: () {
                                    _store.approveIdentity(id);
                                    setState(() {});
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.shield),
                                  tooltip: 'Approve as DM',
                                  onPressed: () {
                                    _store.approveIdentity(id, true);
                                    setState(() {});
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  tooltip: 'Delete',
                                  onPressed: () {
                                    _store.deleteIdentity(id);
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ──────────────────────────── Tab 2: DM Roller ────────────────────────────

class _DmRollerTab extends StatelessWidget {
  final _rng = Random.secure();

  @override
  Widget build(BuildContext context) {
    return DiceRoller(
      rollLabel: 'DM Roll',
      onRoll: (diceSets) async {
        final logger = Logger();
        final rolls = <int>[];

        for (final ds in diceSets) {
          for (var i = 0; i < ds.$1; i++) {
            rolls.add(_rng.nextInt(ds.$2) + 1);
          }
        }

        logger.logLocally(
          'DM rolled ${rolls.length} dice → $rolls (total: ${rolls.fold<int>(0, (a, b) => a + b)})',
          'DM/roll',
          LogLevel.INFO,
        );

        return rolls;
      },
    );
  }
}

// ──────────────────────────── Tab 3: Roll Log ────────────────────────────

class _RollLogTab extends StatefulWidget {
  final Logger logger;
  const _RollLogTab({required this.logger});
  @override
  State<_RollLogTab> createState() => _RollLogTabState();
}

class _RollLogTabState extends State<_RollLogTab> {
  final _entries = <LogEntry>[];

  @override
  void initState() {
    super.initState();
    widget.logger.logs.listen((entry) {
      if (mounted) setState(() => _entries.insert(0, entry));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_entries.isEmpty) return const Center(child: Text('No log entries yet.'));

    return ListView.builder(
      itemCount: _entries.length,
      itemBuilder: (ctx, i) {
        final e = _entries[i];
        final color = switch (e.level) {
          LogLevel.ERROR => Theme.of(context).colorScheme.error,
          LogLevel.WARNING => Colors.orange,
          _ => null,
        };

        return ListTile(
          dense: true,
          leading: Icon(
            switch (e.level) {
              LogLevel.ERROR => Icons.error,
              LogLevel.WARNING => Icons.warning,
              _ => Icons.info_outline,
            },
            color: color,
          ),
          title: Text(e.message, style: TextStyle(color: color)),
          subtitle: Text(e.source),
        );
      },
    );
  }
}
