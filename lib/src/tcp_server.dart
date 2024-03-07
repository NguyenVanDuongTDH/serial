// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:io';
import 'package:serial/serial.dart';
import 'package:serial/src/serial.dart';
import 'package:serial/src/tcp_client.dart';

class SerialServerTCP extends SerialServer {
  ServerSocket? _server;
  String _host = "";
  int _port = 502;
  StreamSubscription<Socket>? _listen;
  StreamController<SerialClientTCP>? _streamController;

  SerialServerTCP(String host, int port)
      : _host = host,
        _port = port;
  @override
  Future<bool> bind() async {
    try {
      _server = await ServerSocket.bind(_host, _port);
      _streamController = StreamController<SerialClientTCP>();
      _listen = _server!.listen((event) {
        _streamController!.sink.add(SerialClientTCP.fromSocket(event));
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> close() async {
    if (_server != null) {
      await _server!.close();
      _server = null;
    }
    if (_listen != null) {
      _listen!.cancel();
      _listen = null;
    }
    if (_streamController == null) {
      _streamController?.close();
      _streamController = null;
    }
  }

  @override
  StreamSubscription<SerialClient> listen(
          void Function(SerialClient event)? onData,
          {void Function()? onDone}) =>
      _streamController!.stream.listen(onData, onDone: onDone);
}
