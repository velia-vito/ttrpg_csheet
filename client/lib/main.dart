import 'package:api/build/data/dice.pb.dart';
import 'package:api/build/data/identity.pb.dart';
import 'package:api/build/service/handler.pbgrpc.dart';
import 'package:api/build/service/roller.pbgrpc.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:ui/ui.dart';

void main() => runApp(MaterialApp(theme: appTheme(), home: const _ConnectScreen()));

// ──────────────────────────── Connect Screen ────────────────────────────

class _ConnectScreen extends StatefulWidget {
  const _ConnectScreen();
  @override
  State<_ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<_ConnectScreen> {
  final _hostCtrl = TextEditingController(text: 'localhost');
  final _portCtrl = TextEditingController(text: '50051');
  bool _connecting = false;
  String? _error;

  Future<void> _connect() async {
    setState(() {
      _connecting = true;
      _error = null;
    });

    final host = _hostCtrl.text.trim();
    final port = int.tryParse(_portCtrl.text.trim()) ?? 0;

    if (host.isEmpty || port <= 0) {
      setState(() {
        _error = 'Enter a valid host and port.';
        _connecting = false;
      });
      return;
    }

    try {
      final channel = ClientChannel(
        host,
        port: port,
        options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
      );
      // Quick connectivity check — request an unknown service.
      final handler = HandlerClient(channel);
      await handler.requestService(ServiceRequest(serviceName: Services.UNKNOWN_SERVICE));

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => _LoginScreen(channel: channel)),
      );
    } catch (e) {
      setState(() {
        _error = 'Connection failed: $e';
        _connecting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Connect to Server', style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 24),
                  TextField(controller: _hostCtrl, decoration: const InputDecoration(labelText: 'Host')),
                  const SizedBox(height: 12),
                  TextField(controller: _portCtrl, decoration: const InputDecoration(labelText: 'Port'), keyboardType: TextInputType.number),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _connecting ? null : _connect,
                    child: _connecting ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Connect'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────── Login Screen ────────────────────────────

class _LoginScreen extends StatefulWidget {
  final ClientChannel channel;
  const _LoginScreen({required this.channel});
  @override
  State<_LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _busy = false;
  String? _message;
  bool _isError = false;

  late final HandlerClient _handler = HandlerClient(widget.channel);

  Future<void> _login() async {
    setState(() {
      _busy = true;
      _message = null;
    });

    try {
      final id = PlayerIdentity(username: _userCtrl.text.trim(), password: _passCtrl.text);
      final result = await _handler.handshake(id);

      if (result.isApproved == ApprovedAs.APPROVED_AS_UNAPPROVED || result.token.isEmpty) {
        setState(() {
          _message = 'User is not approved.';
          _isError = true;
          _busy = false;
        });
        return;
      }

      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => _RollerScreen(
            channel: widget.channel,
            sessionToken: result.token,
            username: _userCtrl.text.trim(),
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _message = 'Login failed: $e';
        _isError = true;
        _busy = false;
      });
    }
  }

  Future<void> _createProfile() async {
    setState(() {
      _busy = true;
      _message = null;
    });

    try {
      final id = PlayerIdentity(username: _userCtrl.text.trim(), password: _passCtrl.text);
      await _handler.logIdentity(id);
      setState(() {
        _message = 'Profile awaiting admin approval.';
        _isError = false;
        _busy = false;
      });
    } catch (e) {
      setState(() {
        _message = 'Registration failed: $e';
        _isError = true;
        _busy = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Login', style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 24),
                  TextField(controller: _userCtrl, decoration: const InputDecoration(labelText: 'Username')),
                  const SizedBox(height: 12),
                  TextField(controller: _passCtrl, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
                  if (_message != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _message!,
                      style: TextStyle(color: _isError ? theme.colorScheme.error : theme.colorScheme.primary),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FilledButton(onPressed: _busy ? null : _login, child: const Text('Login')),
                      const SizedBox(width: 12),
                      OutlinedButton(onPressed: _busy ? null : _createProfile, child: const Text('Create Profile')),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ──────────────────────────── Roller Screen ────────────────────────────

class _RollerScreen extends StatelessWidget {
  final ClientChannel channel;
  final String sessionToken;
  final String username;

  const _RollerScreen({
    required this.channel,
    required this.sessionToken,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    final roller = RollerClient(
      channel,
      options: CallOptions(metadata: {'session-token': sessionToken}),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Dice Roller — $username')),
      body: DiceRoller(
        rollLabel: 'Roll',
        onRoll: (diceSets) async {
          final def = DiceDefinition(
            diceSets: diceSets.map((ds) => DiceSet(count: ds.$1, sides: ds.$2)).toList(),
          );
          final result = await roller.roll(def);
          return result.individualRolls;
        },
      ),
    );
  }
}
