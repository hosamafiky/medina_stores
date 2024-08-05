import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart';

class SocketIOHelper {
  Socket? _socket;

  void connect(String url) {
    _socket = io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket!.connect();
    if (_socket!.connected) log("Connecting socket", name: "SocketIOHelper");
  }

  void disconnect() {
    _socket?.disconnect();
    if (_socket!.disconnected) log("Disconnected socket", name: "SocketIOHelper");
  }

  void emit(String event, dynamic data) {
    log("Emitting $event with $data", name: "SocketIOHelper");
    _socket?.emit(event, data);
  }

  void on(String event, Function(dynamic) callback) {
    log("Listening $event", name: "SocketIOHelper");
    _socket?.on(event, callback);
  }
}
