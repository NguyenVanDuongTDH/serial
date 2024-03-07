// ignore_for_file: prefer_final_fields

import 'dart:async';

import 'package:serial/serial.dart';

class SerialWindowsServerUSB extends SerialServer {
  SerialClient _client;
  StreamController<SerialClient>? _controller;
  SerialWindowsServerUSB(String name,
      {int baudRate = 9600,
      int parity = SerialPortParity.none,
      int stopBits = 1,
      int bits = 8})
      : _client = SerialWindowsClientUSB(name,
            baudRate: baudRate, parity: parity, stopBits: stopBits, bits: bits);
  @override
  Future<bool> bind() async {
    final res = await _client.connect();
    if (res) {
      _controller = StreamController();
      _controller!.sink.add(_client);
    }
    return res;
  }

  @override
  Future<void> close() async {
    await _controller?.close();
    _controller = null;
    await _client.close();
  }

  @override
  StreamSubscription<SerialClient> listen(
          void Function(SerialClient socket)? onData,
          {void Function()? onDone}) =>
      _controller!.stream.listen(onData, onDone: onDone);
}
