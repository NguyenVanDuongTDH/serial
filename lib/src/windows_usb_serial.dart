import 'dart:async';

import 'dart:typed_data';

import 'package:libserialport/libserialport.dart';
import 'package:serial/serial.dart';
import 'package:serial/src/serial.dart';

class SerialWindowsClientUSB extends SerialClient {
  SerialPort? _serialPort;
  SerialPortReader? _reader;
  String _name;
  int _baudRate;
  int _parity;
  int _stopBits;
  int _bits;

  SerialWindowsClientUSB(String name,
      {int baudRate = 9600,
      int parity = SerialPortParity.none,
      int stopBits = 1,
      int bits = 8})
      : _name = name,
        _baudRate = baudRate,
        _parity = parity,
        _stopBits = stopBits,
        _bits = bits;

  @override
  Future<void> close() async {
    if (_serialPort != null) {
      _serialPort?.close();
      _serialPort?.dispose();
      _serialPort = null;
    }
    if (_reader != null) {
      _reader!.close();
    }
  }

  @override
  Future<bool> connect() async {
    try {
      _serialPort = SerialPort(_name);
      _serialPort!.openReadWrite();
      _serialPort!.config = SerialPortConfig()
        ..baudRate = _baudRate
        ..bits = _bits
        ..stopBits = _stopBits
        ..parity = _parity
        ..setFlowControl(SerialPortFlowControl.none);
      _reader = SerialPortReader(_serialPort!);
    

      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  StreamSubscription<Uint8List> listen(void Function(Uint8List event)? onData,
          {void Function()? onDone}) =>
      _reader!.stream.listen(onData, onDone: onDone);

  @override
  void add(Uint8List datas) {
    _serialPort!.write(datas);
  }
}
