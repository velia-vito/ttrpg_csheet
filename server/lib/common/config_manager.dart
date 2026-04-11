import 'dart:convert';
import 'dart:io';

import 'package:api/build/data/log_entry.pb.dart';
import 'package:server/service/logger_service.dart';

/// Manages reading and writing config files to `<server>/../config/`.
///
/// ### Notes
/// - Path is resolved from the script URI, not the working directory.
///   `server/bin/server.dart` → `../../config` → `ttrpg_csheet/config/`.
class ConfigManager {
  /// Absolute path to the config directory.
  late final String _configDir = Directory.fromUri(Platform.script.resolve('../../config')).path;

  /// Singleton instance of [ConfigManager].
  static final ConfigManager _instance = ConfigManager._();

  final _logger = Logger();

  /// Return the singleton instance of [ConfigManager].
  factory ConfigManager() => _instance;

  /// Private constructor.
  ConfigManager._();

  /// Load `<configDir>/<configIdentifier>.json` and populate [obj] in-place.
  ///
  /// ### Notes
  /// - Returns `true` if the file existed and [obj] was populated.
  /// - Returns `false` if the file was absent; [obj] is left unchanged.
  ///
  /// ### Logs
  /// - `error` failed to read or parse file
  Future<bool> load(DiskBak obj) async {
    final path = _pathFor(obj);

    try {
      final file = File(path);
      if (!await file.exists()) return false;

      obj.updateFromJson(jsonDecode(await file.readAsString()));

      return true;
    } catch (e) {
      _logger.logLocally(
        'Failed to load ${obj.configIdentifier}: $e',
        'ConfigManager/load',
        LogLevel.ERROR,
        true,
      );

      return false;
    }
  }

  /// Save [obj] to `<configDir>/<configIdentifier>.json`.
  ///
  /// ### Notes
  /// - Await this for guaranteed completion, or call unawaited for fire-and-forget.
  ///
  /// ### Logs
  /// - `error` failed to write or rename file
  Future<void> save(DiskBak obj) async {
    final path = _pathFor(obj);

    try {
      final json = JsonEncoder.withIndent('  ').convert(obj.toJson());

      // Write to temp first, then rotate live → bak, then promote temp → live.
      final live = File(path);
      final temp = File('$path.tmp');

      await temp.writeAsString(json);
      if (await live.exists()) await live.rename('$path.bak');
      await temp.rename(path);
    } catch (e) {
      _logger.logLocally(
        'Failed to save ${obj.configIdentifier}: $e',
        'ConfigManager/save',
        LogLevel.ERROR,
        true,
      );
    }
  }

  String _pathFor(DiskBak obj) =>
      '$_configDir${Platform.pathSeparator}${obj.configIdentifier}.json';
}

/// Mixin for objects that can be persisted to disk via [ConfigManager].
abstract mixin class DiskBak {
  /// Unique config file identifier, resolved to
  /// `<configDir>/<configIdentifier>.json` by [ConfigManager].
  String get configIdentifier;

  /// Serialize this object to a JSON-encodable value.
  dynamic toJson();

  /// Populate this object's state from a decoded JSON value.
  ///
  /// ### Args
  /// - `json` decoded JSON — typically a `List` or `Map<String, dynamic>`
  void updateFromJson(dynamic json);
}
