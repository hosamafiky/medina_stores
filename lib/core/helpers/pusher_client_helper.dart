import 'dart:developer';

import 'package:pusher_client/pusher_client.dart';

class PusherClientEvents {
  static const String receivedMessage = 'received_message';
  static const String sentMessage = 'sent_message';
}

class PusherClientHelper {
  late PusherClient _pusher;
  late Channel _channel;

  PusherClientHelper() {
    _pusher = PusherClient(
      'f65af03edae1bb39aeff',
      PusherOptions(
        cluster: 'eu',
        encrypted: true,
      ),
    );
  }

  void connect() {
    _pusher.connect();
    _pusher.onConnectionStateChange((state) {
      if (state?.currentState == 'connected') {
        log("Connected to pusher", name: "PusherClientHelper");
      }
    });

    _pusher.onConnectionError((error) {
      log("Connection error: ${error!.message}", name: "PusherClientHelper");
    });
  }

  void subscribe(String channelName) => _channel = _pusher.subscribe(channelName);

  Future<void> bind(String eventName, Function(PusherEvent?) onEvent) async {
    return await _channel.bind(eventName, onEvent);
  }

  Future<void> trigger(String eventName, String data) async {
    return await _channel.trigger(eventName, data);
  }

  Future<void> unsubscribe(String channelName) async {
    return await _pusher.unsubscribe(channelName);
  }

  Future<dynamic> disconnect() async {
    return await _pusher.disconnect();
  }
}
