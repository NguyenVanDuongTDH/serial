import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:serial/src/serial.dart';

class SerialClientTCP extends SerialClient {
  bool _connected = false;
  Socket? _socket;
  String _host = "";
  int _port = 502;

  factory SerialClientTCP.fromSocket(Socket socket) {
    return SerialClientTCP("", 502).._socket = socket;
  }

  SerialClientTCP(String host, int port)
      : _host = host,
        _port = port;

  @override
  Future<void> close() async {
    if (_socket != null) {
      await _socket!.close();
      _socket!.destroy();
      _socket = null;
    }
  }

  @override
  Future<bool> connect() async {
    try {
      _socket = await Socket.connect(_host, _port);

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  StreamSubscription<Uint8List> listen(void Function(Uint8List event)? onData,
          {void Function()? onDone}) =>
      _socket!.listen(onData, onDone: onDone);

  @override
  void add(Uint8List datas) {
    _socket!.add(datas);
  }
  
  @override
  // TODO: implement connected
  bool get connected => throw UnimplementedError();
}
