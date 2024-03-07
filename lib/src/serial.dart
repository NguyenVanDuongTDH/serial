// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:typed_data';
// export "src/tcp_client.dart" show SerialClientTCP;
// export "src/tcp_server.dart" show SerialServerTCP;
// export "src/windows_usb_serial.dart" show SerialWindowsUSB;




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
