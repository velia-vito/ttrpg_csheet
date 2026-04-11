import 'dart:async';

import 'package:api/build/common.pb.dart';
import 'package:api/build/data/log_entry.pb.dart';
import 'package:api/build/service/logger.pbgrpc.dart';
import 'package:grpc/grpc.dart';

/// Singleton broadcast-stream logger. Access via `Logger()` anywhere.
class Logger extends LoggerServiceBase {
  static final Logger _instance = Logger._();

  /// Normal stream controller for routine logs.
  final _normalController = StreamController<LogEntry>.broadcast();

  /// Priority stream controller for critical logs that must be processed immediately.
  final _priorityController = StreamController<LogEntry>.broadcast(sync: true);

  /// Stream of log entries.
  Stream<LogEntry> get logs => _priorityController.stream;

  /// Return the singleton instance of [Logger].
  factory Logger() => _instance;

  /// Private constructor.
  Logger._() {
    // Forward normal logs to the priority stream to ensure all logs are processed in order.
    _normalController.stream.listen(_priorityController.add);
  }

  /// Emit a log entry via gRPC.
  @override
  Future<Empty> log(ServiceCall call, LogEntry request) async {
    if (request.isPriotiy) {
      _priorityController.add(request);
    } else {
      _normalController.add(request);
    }

    return Empty();
  }

  /// Emit a log entry locally without a gRPC [ServiceCall].
  ///
  /// ### Args
  /// - `level` defaults to [LogLevel.INFO]
  void logLocally(
    String message,
    String source, [
    LogLevel level = LogLevel.INFO,
    bool isPriority = false,
  ]) {
    final entry = LogEntry(message: message, source: source, level: level, isPriotiy: isPriority);

    if (isPriority) {
      _priorityController.add(entry);
    } else {
      _normalController.add(entry);
    }
  }
}
