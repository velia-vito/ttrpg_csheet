import 'package:grpc/grpc.dart';
import 'package:server/service/handler_service.dart';
import 'package:server/common/logger.dart';

void main() async {
  var logger = Logger();
  logger.logs.forEach(
    (le) => print('${le.timestamp}\t${le.message}\n${le.source}\n${le.level}\n\n'),
  );

  var handlerServer = HandlerService();
  handlerServer.initialize();

  var server = Server([handlerServer]);
  server.serve(port: 8008);
}
