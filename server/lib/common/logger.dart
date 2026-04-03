import 'dart:async';

/// Singleton broadcast-stream logger. Access via `Logger()` anywhere.
class Logger {
  /// Broadcast stream controller — multiple listeners allowed.
  final _controller = StreamController<LogEntry>.broadcast(sync: true);

  static final Logger _instance = Logger._();

  /// Stream of log entries; emits on every [log] call.
  Stream<LogEntry> get logs => _controller.stream;

  /// Return the singleton instance of [Logger].
  factory Logger() => _instance;

  /// Private constructor.
  Logger._();

  /// Emit a log entry.
  ///
  /// ### Args
  /// - `level` defaults to [LogLevel.info]
  void log(String message, [LogLevel level = LogLevel.info]) {
    _controller.add(LogEntry(message, level));
  }
}

/// A single log entry.
class LogEntry {
  /// Severity level of the log entry.
  final LogLevel level;

  /// Log message.
  final String message;

  /// Timestamp of log entry creation.
  final DateTime timestamp = DateTime.now();

  /// Create a [LogEntry] with the given message and level.
  LogEntry(this.message, this.level);
}

/// Severity levels for log entries.
enum LogLevel {
  /// Routine information.
  info,

  /// Something unexpected that the server can recover from.
  warning,

  /// A failure that requires attention.
  error,
}
