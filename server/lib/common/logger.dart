import 'dart:async';

/// Singleton broadcast-stream logger. Access via `Logger()` anywhere.
class Logger {
  /// Priority stream controller for critical logs that must be processed immediately.
  final _priorityController = StreamController<LogEntry>.broadcast(sync: true);

  /// Normal stream controller for routine logs.
  final _normalController = StreamController<LogEntry>.broadcast();

  static final Logger _instance = Logger._();

  /// Stream of log entries.
  Stream<LogEntry> get logs => _priorityController.stream;

  /// Return the singleton instance of [Logger].
  factory Logger() => _instance;

  /// Private constructor.
  Logger._() {
    // Forward normal logs to the priority stream to ensure all logs are processed in order.
    _normalController.stream.listen(_priorityController.add);
  }

  /// Emit a log entry.
  ///
  /// ### Args
  /// - `level` defaults to [LogLevel.info]
  void log(
    String message,
    String source, [
    LogLevel level = LogLevel.info,
    bool isPriority = false,
  ]) {
    if (isPriority) {
      _priorityController.add(LogEntry(message, source, level));
    } else {
      _normalController.add(LogEntry(message, source, level));
    }
  }
}

/// A single log entry.
class LogEntry {
  /// Severity level of the log entry.
  final LogLevel level;

  /// Log message.
  final String message;

  /// Source of the log entry.
  final String source;

  /// Timestamp of log entry creation.
  final DateTime timestamp = DateTime.now();

  /// Create a [LogEntry] with the given message and level.
  LogEntry(this.message, this.source, this.level);
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
