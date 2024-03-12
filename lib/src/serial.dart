// ignore_for_file: prefer_final_fields, non_constant_identifier_names

import 'dart:async';
import 'dart:typed_data';
import 'package:serial/serial.dart';
import 'package:serial/src/tcp_server.dart';
import 'package:serial/src/windows_usb_serial.dart';
import 'package:serial/src/windows_usb_serial_slave.dart';
import 'tcp_client.dart';

abstract class SerialClient {
  static SerialClient tcp(String host, int port) {
    return SerialClientTCP(host, port);
  }

  static SerialClient winUsb(String name,
      {int baudRate = 9600,
      int parity = SerialPortParity.none,
      int stopBits = 1,
      int bits = 8}) {
    return SerialWindowsClientUSB(name,
        baudRate: baudRate, bits: bits, parity: parity, stopBits: stopBits);
  }

  Future<bool> connect();
  void add(Uint8List datas);
  void write(Uint8List datas, {int? length}) {
    length == null ? add(datas) : add(datas.sublist(0, length));
  }

  StreamSubscription<Uint8List> listen(void Function(Uint8List event)? onData,
      {void Function()? onDone});
  Future<void> close();
}

abstract class SerialServer {
  static SerialServer tcp(String host, int port) {
    return SerialServerTCP(host, port);
  }

  static SerialServer winUsb(String name,
      {int baudRate = 9600,
      int parity = SerialPortParity.none,
      int stopBits = 1,
      int bits = 8}) {
    return SerialWindowsServerUSB(name,
        baudRate: baudRate, bits: bits, parity: parity, stopBits: stopBits);
  }

  Future<bool> bind();
  StreamSubscription<SerialClient> listen(
      void Function(SerialClient socket)? onData,
      {void Function()? onDone});
  Future<void> close();
}
