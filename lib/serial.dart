/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

export 'src/tcp_server.dart' show SerialServerTCP;
export 'src/tcp_client.dart' show SerialClientTCP;
export 'src/serial.dart' show SerialClient, SerialServer;
export 'src/windows_usb_serial.dart' show SerialWindowsMasterUSB;
export 'src/windows_usb_serial_slave.dart' show SerialWindowsServerUSB;
export 'package:libserialport/libserialport.dart' show SerialPortParity;
