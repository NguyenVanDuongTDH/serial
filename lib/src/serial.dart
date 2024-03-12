// ignore_for_file: prefer_final_fields, non_constant_identifier_names, camel_case_types, recursive_getters, camel_case_extensions, library_private_types_in_public_api

import 'dart:async';
import 'dart:typed_data';
import 'package:serial/serial.dart';
import 'package:serial/src/tcp_server.dart';
import 'package:serial/src/windows_usb_serial.dart';
import 'package:serial/src/windows_usb_serial_slave.dart';
import 'tcp_client.dart';

abstract class SerialClient {
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
  Future<bool> bind();
  StreamSubscription<SerialClient> listen(
      void Function(SerialClient socket)? onData,
      {void Function()? onDone});
  Future<void> close();
}
